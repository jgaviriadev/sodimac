import 'package:multiple_result/multiple_result.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';
import '../usecases/usecases.dart';

abstract class CartRepository {
  Future<Result<bool, Failure>> addOrUpdate(CartItemEntity item, {int qty = 1});
  Future<Result<bool, Failure>> incrementQty(String productId);
  Future<Result<bool, Failure>> decrementQty(String productId);
  Future<Result<bool, Failure>> setQty(String productId, int qty);
  Future<Result<bool, Failure>> remove(String productId);
  Future<Result<bool, Failure>> clear();

  Future<Result<WatchAllItemsUseCaseResult, Failure>> watchAll();
}
