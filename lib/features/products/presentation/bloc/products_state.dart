import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

enum ProductsStatus { idle, loadingFirstPage, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<ProductEntity> items;
  final String query;
  final int page;
  final int totalCount;
  final bool hasMore;
  final bool isLoadingMore;
  final String? error;

  const ProductsState({
    this.status = ProductsStatus.idle,
    this.items = const [],
    this.query = '',
    this.page = 0,
    this.totalCount = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.error,
  });

  factory ProductsState.initial() => const ProductsState();

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductEntity>? items,
    String? query,
    int? page,
    int? totalCount,
    bool? hasMore,
    bool? isLoadingMore,
    String? error,
  }) {
    return ProductsState(
      status: status ?? this.status,
      items: items ?? this.items,
      query: query ?? this.query,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }

  bool get isIdle => status == ProductsStatus.idle;
  bool get isLoadingFirstPage => status == ProductsStatus.loadingFirstPage;
  bool get isSuccess => status == ProductsStatus.success;
  bool get isFailure => status == ProductsStatus.failure;

  @override
  List<Object?> get props => [
    status,
    items,
    query,
    page,
    totalCount,
    hasMore,
    isLoadingMore,
    error,
  ];
}
