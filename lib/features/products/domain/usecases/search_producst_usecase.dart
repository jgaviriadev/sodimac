
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';


class SearchProductsUseCase implements UseCase<SearchProductsUseCaseResult, SearchProductsUseCaseParams> {
  final ProductsRepository repository;

  SearchProductsUseCase({required this.repository});

  @override
  Future<Result<SearchProductsUseCaseResult, Failure>> call(SearchProductsUseCaseParams params) async {
    final result = await repository.searchProducts(
      page: params.page,
      query: params.query,
    );

    switch (result) {
      case Success():
        return Success(result.success);
      case Error():
        return Error(result.error);
    }
  }
}

class SearchProductsUseCaseParams {
  final String query;
  final int page;

  const SearchProductsUseCaseParams({required this.query, required this.page,});
}

class SearchProductsUseCaseResult {
  final List<ProductEntity> result;
  final int totalCount;
  const SearchProductsUseCaseResult({required this.result, required this.totalCount});
}