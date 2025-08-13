import 'package:multiple_result/multiple_result.dart';

import '../core.dart';

Future<Result<T, Failure>> handleRepositoryCall<T>({
  required Future<T> Function() action,
  required String operation, // info to save logs or debugging
}) async {
  try {
    final result = await action();
    return Success(result);
  } on ServerException catch (e) {
    return Error(ServerFailure(message: e.message));
  } on ConnectionException catch (e) {
    return Error(ConnectionFailure(message: e.message));
  } on CacheException catch (e) {
    return Error(CacheFailure(message: e.message));
  } on DataBaseException catch (e) {
    return Error(DataBaseFailure(message: e.message));
  } on UnauthorizedException catch (e) {
    return Error(AuthenticationFailure(message: e.message));
  } on ForbiddenException catch (e) {
    return Error(PermissionFailure(message: e.message));
  } on NotFoundException catch (e) {
    return Error(NotFoundFailure(message: e.message));
  } on ValidationException catch (e) {
    return Error(ValidationFailure(message: e.message));
  } on CustomTimeoutException catch (e) {
    return Error(TimeoutFailure(message: e.message));
  } on UnknownException catch (e) {
    return Error(ErrorFailure(message: e.message));
  } on Exception catch (e) {
    return Error(ErrorFailure(message: e.toString()));
  } catch (e) {
    return Error(ErrorFailure(message: e.toString()));
  }
}