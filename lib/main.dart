import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lzprices/drift_database.dart';
import 'package:lzprices/integrations/supabase_service.dart';
import 'package:lzprices/screens/search_page.dart';
import 'package:lzprices/services/product_sync_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the database
  db = AppDatabase();

  // Initialize Supabase
  await SupabaseService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductSyncService>(
          create: (_) => ProductSyncService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LZ Prices',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SearchPage(),
      ),
    );
  }
}
