import 'package:drift/drift.dart';

@DataClassName('KeyValueStoreEntry')
class KeyValueStore extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
