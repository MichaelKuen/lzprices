import 'package:get_it/get_it.dart';
import 'package:lzprices/integrations/supabase_service.dart';
import 'package:lzprices/repositories/product_repository.dart';
import 'package:lzprices/services/local_storage_service.dart';
import 'package:lzprices/services/product_sync_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Services
  sl.registerLazySingleton(() => SupabaseService());
  sl.registerLazySingleton(() => LocalStorageService());
  sl.registerLazySingleton(() => ProductSyncService());

  // Repositories
  sl.registerLazySingleton(() => ProductRepository());
}
