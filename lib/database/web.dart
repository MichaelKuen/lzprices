import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

QueryExecutor openConnection() {
  return WasmDatabase.supported()
      ? WasmDatabase(dbName: 'db')
      : WasmDatabase.serializable();
}