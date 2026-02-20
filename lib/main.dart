import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lzprices/drift_database.dart';
import 'package:lzprices/integrations/supabase_service.dart';
import 'package:lzprices/screens/login_screen.dart';
import 'package:lzprices/screens/search_page.dart';
import 'package:lzprices/service_locator.dart';
import 'package:lzprices/services/settings_service.dart';
import 'package:lzprices/viewmodels/search_page_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Settings Service
  await SettingsService().initialize();

  // Initialize the database
  db = AppDatabase();

  // Setup the service locator
  setupServiceLocator();

  // Initialize Supabase
  await sl<SupabaseService>().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LZ Prices',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (context) => SearchPageViewModel(),
              child: const SearchPage(),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
