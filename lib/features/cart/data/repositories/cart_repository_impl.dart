import 'package:multiple_result/multiple_result.dart';
import 'package:sodimac/features/cart/domain/entities/card_item_entity.dart';
import 'package:sodimac/features/cart/domain/usecases/watch_all_items_usecase.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_datasource.dart';
import '../models/models.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Result<bool, Failure>> clear() async{
    return await handleRepositoryCall<bool>(
      action: () async {
        await dataSource.clear();
        return true;
      },
      operation: "clearCart",
    );
  }

  @override
  Future<Result<WatchAllItemsUseCaseResult, Failure>> watchAll() async {
    return await handleRepositoryCall<WatchAllItemsUseCaseResult>(
      action: () async {
        final streamEntities = dataSource.watchAll().map(
          (models) => models.map((m) => m.toEntity()).toList(),
        );

        return WatchAllItemsUseCaseResult(result: streamEntities);
      },
      operation: "searchProducts",
    );
  }

  @override
  Future<Result<bool, Failure>> addOrUpdate(CartItemEntity item, {int qty = 1}) async {
    return await handleRepositoryCall<bool>(
      action: () async {
        await dataSource.addOrUpdateFromProduct(
          CartItemModel.fromEntity(item),
          qty: qty,
        );
        return true;
      },
      operation: "searchProducts",
    );
  }
  
  @override
  Future<Result<bool, Failure>> decrementQty(String productId) async{
    return handleRepositoryCall<bool>(
      action: () async {
        await dataSource.decrementQty(productId);
        return true;
      },
      operation: "decrementQty",
    );
  }
  
  @override
  Future<Result<bool, Failure>> incrementQty(String productId) async {
    return handleRepositoryCall<bool>(
      action: () async {
        await dataSource.incrementQty(productId);
        return true;
      },
      operation: "incrementQty",
    );
  }
  
  @override
  Future<Result<bool, Failure>> remove(String productId) {
    return handleRepositoryCall<bool>(
      action: () async {
        await dataSource.remove(productId);
        return true;
      },
      operation: "removeFromCart",
    );
  }
  
  @override
  Future<Result<bool, Failure>> setQty(String productId, int qty) {
    return handleRepositoryCall<bool>(
      action: () async {
        await dataSource.setQty(productId, qty);
        return true;
      },
      operation: "setQty",
    );
  }
}