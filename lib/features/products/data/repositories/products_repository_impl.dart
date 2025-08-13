import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/products_repository.dart';
import '../../domain/usecases/usecases.dart';
import '../datasources/products_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource productsDatasource;

  ProductsRepositoryImpl({
    required this.productsDatasource,
  });

  @override
  Future<Result<SearchProductsUseCaseResult, Failure>> searchProducts({
    required String query,
    required int page,
  }) async {
    return await handleRepositoryCall<SearchProductsUseCaseResult>(
      action: () async {
        final response = await productsDatasource.searchProducts(query, page);
        return SearchProductsUseCaseResult(
          totalCount: response.totalCount,
          result: response.items
              .map(
                (e) => e.toEntity(),
              )
              .toList(),
        );
      },
      operation: "searchProducts",
    );
  }
}
