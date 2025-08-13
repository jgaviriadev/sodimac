import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../usecases/usecases.dart';

abstract class ProductsRepository {
  Future<Result<SearchProductsUseCaseResult, Failure>> searchProducts({
    required String query,
    required int page,
  });
}
