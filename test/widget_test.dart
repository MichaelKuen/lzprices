import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lzprices/main.dart';
import 'package:lzprices/screens/search_page.dart';
import 'package:provider/provider.dart';
import 'package:lzprices/services/product_sync_service.dart';

void main() {
  testWidgets('SearchPage renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ProductSyncService>(
            create: (_) => ProductSyncService(),
          ),
        ],
        child: const MaterialApp(
          home: SearchPage(),
        ),
      ),
    );

    // Verify that the search field is present.
    expect(find.byType(TextField), findsOneWidget);
  });
}
