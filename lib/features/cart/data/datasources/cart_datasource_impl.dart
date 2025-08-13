import '../../../../core/core.dart';
import '../models/models.dart';
import 'cart_datasource.dart';

class CartDataSourceImpl implements CartDataSource {
  final CartDao _dao;

  CartDataSourceImpl(this._dao);

  @override
  Future<void> addOrUpdateFromProduct(CartItemModel item, {int qty = 1}) async {
    await _dao.upsertItem(
      productId: item.productId,
      imageUrl: item.imageUrl,
      description: item.description,
      priceValue: item.priceValue,
      priceCurrency: item.priceCurrency,
      qty: qty,
    );
  }

  @override
  Future<void> clear() async {
    _dao.clear();
  }

  @override
  Future<void> decrementQty(String productId) async {
    _dao.decrementQty(productId);
  }

  @override
  Future<bool> exists(String productId) async {
    return _dao.exists(productId);
  }

  @override
  Future<void> incrementQty(String productId) async {
    _dao.incrementQty(productId);
  }

  @override
  Future<void> remove(String productId) async {
    _dao.removeItem(productId);
  }

  @override
  Future<void> setQty(String productId, int qty) async {
    _dao.setQty(productId, qty);
  }

  @override
  Stream<int> watchDistinctItemsCount() {
    return _dao.watchDistinctItemsCount();
  }

  @override
  Stream<int> watchTotalQty() {
    return _dao.watchTotalQty();
  }

  @override
  Stream<List<CartItemModel>> watchAll() {
    return _dao.watchAll().map(
      (items) => items.map((dbItem) {
        return CartItemModel(
          productId: dbItem.productId,
          description: dbItem.description,
          imageUrl: dbItem.imageUrl,
          priceValue: dbItem.priceValue,
          priceCurrency: dbItem.priceCurrency,
          qty: dbItem.qty
        );
      }).toList(),
    );
  }
}
