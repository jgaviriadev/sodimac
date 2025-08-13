import '../models/cart_item_model.dart';

abstract class CartDataSource {
  Future<void> addOrUpdateFromProduct(CartItemModel p, {int qty = 1});
  Future<void> incrementQty(String productId);
  Future<void> decrementQty(String productId);
  Future<void> setQty(String productId, int qty);
  Future<void> remove(String productId);
  Future<void> clear();

  Future<bool> exists(String productId);

  Stream<List<CartItemModel>> watchAll();
  Stream<int> watchTotalQty();
  Stream<int> watchDistinctItemsCount();
}