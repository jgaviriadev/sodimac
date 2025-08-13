import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


import 'daos/cart_dao.dart';
import 'tables/cart_items_table.dart';

part 'app_database.g.dart';


@DriftDatabase(
  tables: [CartItems],
  daos: [CartDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sodimac.db'));
    return NativeDatabase.createInBackground(file);
  });
}
