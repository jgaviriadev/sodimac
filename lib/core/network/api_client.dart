import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../core.dart';

class ApiClient {
  final Dio _dio;
  final CacheOptions _cacheOptions;

  ApiClient({
    required String baseUrl,
    Dio? dio,
    CacheOptions? cacheOptions,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 10),
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: connectTimeout,
                receiveTimeout: receiveTimeout,
                sendTimeout: sendTimeout,
                responseType: ResponseType.json,
                validateStatus: (_) => true,
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
              ),
            ),
        _cacheOptions = cacheOptions ??
            CacheOptions(
              store: MemCacheStore(),
              policy: CachePolicy.request,
              hitCacheOnNetworkFailure: true,
              maxStale: const Duration(hours: 12),
              priority: CachePriority.normal,
              keyBuilder: CacheOptions.defaultCacheKeyBuilder,
              allowPostMethod: false,
            ) {
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));  // <- cache
    assert(() {
      _dio.interceptors.add(LogInterceptor(request: true, requestBody: true, error: true));
      return true;
    }());
  }

  String? _extractErrorMessage(Response res) {
    final d = res.data;
    if (d is Map<String, dynamic>) {
      return d['message']?.toString() ??
          d['error']?.toString() ??
          d['detail']?.toString();
    }
    if (d is String && d.isNotEmpty) return d;
    return null;
  }

  Never _throwForStatus(Response res) {
    final c = res.statusCode ?? 0;
    final m = _extractErrorMessage(res);
    if (c >= 200 && c < 300) {
      throw StateError('No llames _throwForStatus en éxito');
    }

    switch (c) {
      case 401:
        throw UnauthorizedException(message: m ?? 'Unauthorized');
      case 403:
        throw ForbiddenException(message: m ?? 'Forbidden');
      case 404:
        throw NotFoundException(message: m ?? 'Not found');
      case 408:
        throw CustomTimeoutException(message: m ?? 'Request timeout');
      case 422:
        throw ValidationException(message: m ?? 'Unprocessable entity');
      default:
        if (c >= 500) {
          throw ServerException(
            message: m ?? 'Service not available. Contact the administrator',
          );
        }
        throw UnknownException(message: m ?? 'HTTP error $c');
    }
  }

  Never _mapAndThrowDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw CustomTimeoutException(message: e.message ?? 'Timeout');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw ConnectionException(message: e.message ?? 'Network error');
      case DioExceptionType.cancel:
        throw UnknownException(message: 'Request cancelled');
      case DioExceptionType.badCertificate:
        throw ConnectionException(message: 'Bad certificate');
      case DioExceptionType.badResponse:
        final r = e.response;
        if (r != null) _throwForStatus(r);
        throw UnknownException(message: 'Bad response without status');
    }
  }

  Future<Response<T>> request<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? query,
    dynamic body,
    Map<String, String>? headers,
    CachePolicy? cachePolicy, 
  }) async {
    try {
      Options opt = Options(headers: headers);
      if (cachePolicy != null) {
        final cacheOpt = _cacheOptions.copyWith(policy: cachePolicy).toOptions();
        opt = opt.copyWith(extra: {...?opt.extra, ...?cacheOpt.extra});
      }
      late Response<T> res;
      switch (method.toUpperCase()) {
        case 'GET':
          res = await _dio.get<T>(
            endpoint,
            queryParameters: query,
            options: opt,
          );
          break;
        case 'POST':
          res = await _dio.post<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: opt,
          );
          break;
        case 'PUT':
          res = await _dio.put<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: opt,
          );
          break;
        case 'PATCH':
          res = await _dio.patch<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: opt,
          );
          break;
        case 'DELETE':
          res = await _dio.delete<T>(
            endpoint,
            data: body,
            queryParameters: query,
            options: opt,
          );
          break;
        default:
          throw UnknownException(message: 'HTTP method $method not supported');
      }

      // --- DEBUG: ¿cache o red? ---
      final cameFromNetwork = res.extra[extraFromNetworkKey] == true;
      final cacheKey = res.extra[extraCacheKey];
      assert(() {
        // Solo corre en modo debug
        // ignore: avoid_print
        print('[${cameFromNetwork ? "NETWORK" : "CACHE"}] '
              '${res.requestOptions.uri}  status=${res.statusCode}  cacheKey=$cacheKey');
        return true;
      }());


      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        _throwForStatus(res);
      }
      return res;
    } on DioException catch (e) {
      _mapAndThrowDioError(e);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> getJson(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    CachePolicy? cachePolicy,
  }) async {
    final r = await request<Map<String, dynamic>>(
      method: 'GET',
      endpoint: endpoint,
      query: query,
      headers: headers,
      cachePolicy: cachePolicy,
    );
    if (r.data is Map<String, dynamic>) return r.data!;
    throw UnknownException(
      message: 'Unexpected response format (expected object)',
    );
  }

  Future<List<dynamic>> getList(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final r = await request<List<dynamic>>(
      method: 'GET',
      endpoint: endpoint,
      query: query,
      headers: headers,
    );
    if (r.data is List) return r.data!;
    throw UnknownException(
      message: 'Unexpected response format (expected list)',
    );
  }
}
