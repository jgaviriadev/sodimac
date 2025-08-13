import 'package:drift/drift.dart';

class CartItems extends Table {
  TextColumn get productId => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get priceValue => text().nullable()();
  TextColumn get priceCurrency => text().nullable()();
  IntColumn get qty => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {productId};
}
