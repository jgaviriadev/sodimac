import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cart_items_table.dart';

part 'cart_dao.g.dart';

@DriftAccessor(tables: [CartItems])
class CartDao extends DatabaseAccessor<AppDatabase> with _$CartDaoMixin {
  CartDao(super.db);

  Future<void> upsertItem({
    required String productId,
    String? imageUrl,
    String? description,
    String? priceValue,
    String? priceCurrency,
    int qty = 1,
  }) async {
    await into(cartItems).insertOnConflictUpdate(
      CartItem(
        productId: productId,
        imageUrl: imageUrl,
        description: description,
        priceValue: priceValue,
        priceCurrency: priceCurrency,
        qty: qty,
      ),
    );
  }

  Future<void> incrementQty(String productId) async {
    await (update(cartItems)..where((t) => t.productId.equals(productId))).write(
      CartItemsCompanion.custom(qty: cartItems.qty + const Constant(1)),
    );
  }

  Future<void> decrementQty(String productId) async {
    final row = await (select(cartItems)..where((t) => t.productId.equals(productId))).getSingleOrNull();
    if (row == null) return;
    if (row.qty <= 1) {
      await removeItem(productId);
    } else {
      await (update(cartItems)..where((t) => t.productId.equals(productId))).write(
        CartItemsCompanion.custom(qty: cartItems.qty - const Constant(1)),
      );
    }
  }

  Future<void> setQty(String productId, int qty) async {
    if (qty <= 0) return removeItem(productId);
    await (update(cartItems)..where((t) => t.productId.equals(productId))).write(CartItemsCompanion(qty: Value(qty)));
  }

  Future<void> removeItem(String productId) async {
    await (delete(cartItems)..where((t) => t.productId.equals(productId))).go();
  }

  Future<void> clear() async => delete(cartItems).go();

  Future<bool> exists(String productId) async {
    final q = select(cartItems)..where((t) => t.productId.equals(productId));
    return (await q.getSingleOrNull()) != null;
  }

  Stream<int> watchDistinctItemsCount() {
    final q = selectOnly(cartItems)..addColumns([cartItems.productId.count()]);
    return q.watchSingle().map((r) => r.read(cartItems.productId.count()) ?? 0);
  }

  Stream<int> watchTotalQty() {
    final q = selectOnly(cartItems)..addColumns([cartItems.qty.sum()]);
    return q.watchSingle().map((r) => r.read(cartItems.qty.sum()) ?? 0);
  }

  Stream<List<CartItem>> watchAll() => select(cartItems).watch();
  Future<List<CartItem>> getAll() => select(cartItems).get();
}
