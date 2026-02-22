import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lzprices/models/product.dart';
import 'package:lzprices/viewmodels/search_page_view_model.dart';
import 'package:lzprices/screens/settings_screen.dart';
import 'package:lzprices/services/auth_service.dart';
import 'package:lzprices/services/permissions_service.dart';
import 'package:provider/provider.dart';
import 'package:lzprices/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchPageViewModel>(
            create: (_) => SearchPageViewModel()),
        StreamProvider<Map<String, dynamic>>(
          create: (_) => sl<PermissionsService>().permissionsStream,
          initialData: const {},
        ),
      ],
      child: const _SearchPageBody(),
    );
  }
}

class _SearchPageBody extends StatelessWidget {
  const _SearchPageBody({super.key});

  bool _isAccessAllowed(Map<String, dynamic> permissions) {
    // Before permissions are loaded, deny access.
    if (permissions.isEmpty) {
      return false;
    }

    // Admin users always have access.
    final isAdmin = permissions['isAdmin'] as bool? ?? false;
    if (isAdmin) {
      return true;
    }

    // --- Day Check ---
    final now = DateTime.now();
    final currentDay = DateFormat('EEEE').format(now).toLowerCase();

    // Get the accessDays map. If it doesn't exist or isn't a map, treat as no access days set.
    final accessDaysData = permissions['accessDays'];
    if (accessDaysData is! Map) {
      // If there's no accessDays map, there are no valid days to log in.
      return false;
    }

    // Check if access is explicitly granted for the current day.
    // We check for `== true` to be strict. A missing day, null, or false all mean no access.
    final dayHasAccess = accessDaysData[currentDay] as bool? ?? false;
    if (!dayHasAccess) {
      return false;
    }

    // --- Time Check ---
    // If the day check passes, proceed to check the time window.
    final currentTime = TimeOfDay.fromDateTime(now);

    // Safely get start and end time strings with defaults.
    final startTimeString = permissions['accessStartTime'] as String? ?? '00:00';
    final endTimeString = permissions['accessEndTime'] as String? ?? '23:59';

    try {
      final startTimeParts = startTimeString.split(':');
      final endTimeParts = endTimeString.split(':');

      final startTime = TimeOfDay(
        hour: int.parse(startTimeParts[0]),
        minute: int.parse(startTimeParts[1]),
      );
      final endTime = TimeOfDay(
        hour: int.parse(endTimeParts[0]),
        minute: int.parse(endTimeParts[1]),
      );

      final currentTimeInMinutes = currentTime.hour * 60 + currentTime.minute;
      final startTimeInMinutes = startTime.hour * 60 + startTime.minute;
      final endTimeInMinutes = endTime.hour * 60 + endTime.minute;

      // The user has access if the current time is within the allowed window.
      return currentTimeInMinutes >= startTimeInMinutes &&
          currentTimeInMinutes <= endTimeInMinutes;

    } catch (e) {
      // If time strings are malformed, deny access as a safe default.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
    final permissions = context.watch<Map<String, dynamic>>();
    final authService = AuthService();

    if (!_isAccessAllowed(permissions)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Access Denied'),
           actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authService.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'You do not have access at this time. Please check your schedule.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ),
      );
    }

    // Permission flags
    final isAdmin = permissions['isAdmin'] ?? false;
    final canEdit = permissions['canEdit'] ?? false;
    final canDelete = permissions['canDelete'] ?? false;
    final showPrice = permissions['showPrice'] ?? true;
    final showInstallerPrice = permissions['showInstallerPrice'] ?? false;
    final showWholesalePrice = permissions['showWholesalePrice'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: viewModel.searchController,
              decoration: const InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.allCategories.length,
              itemBuilder: (context, index) {
                final category = viewModel.allCategories[index];
                final isSelected =
                    viewModel.selectedCategories.contains(category);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      viewModel.onCategorySelected(selected, category);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: DropdownButton<SortOption>(
              value: viewModel.activeSort,
              items: const [
                DropdownMenuItem(value: SortOption.none, child: Text('No Sort')),
                DropdownMenuItem(
                    value: SortOption.priceAsc, child: Text('Price Asc')),
                DropdownMenuItem(
                    value: SortOption.priceDesc, child: Text('Price Desc')),
              ],
              onChanged: (option) {
                if (option != null) {
                  viewModel.onSortSelected(option);
                }
              },
            ),
          ),
          if (viewModel.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (viewModel.errorMessage.isNotEmpty)
            Expanded(child: Center(child: Text(viewModel.errorMessage)))
          else if (viewModel.searchResults.isEmpty)
            const Expanded(
              child: Center(child: Text('Select a product to see details')),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.searchResults.length,
                itemBuilder: (context, index) {
                  final product = viewModel.searchResults[index];
                  return _buildProductCard(
                    product,
                    canEdit,
                    canDelete,
                    showPrice,
                    showInstallerPrice,
                    showWholesalePrice,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    Product product,
    bool canEdit,
    bool canDelete,
    bool showPrice,
    bool showInstallerPrice,
    bool showWholesalePrice,
  ) {
    List<Widget> priceWidgets = [];

    if (showPrice && product.price != null) {
      priceWidgets.add(Text('Retail: \$${product.price!.toStringAsFixed(2)}'));
    }
    if (showInstallerPrice && product.installerPrice != null) {
      priceWidgets
          .add(Text('Installer: \$${product.installerPrice!.toStringAsFixed(2)}'));
    }
    if (showWholesalePrice && product.wholesalePrice != null) {
      priceWidgets.add(
          Text('Wholesale: \$${product.wholesalePrice!.toStringAsFixed(2)}'));
    }

    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.sku != null) Text('SKU: ${product.sku}'),
            ...priceWidgets,
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canEdit)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
            if (canDelete)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality
                },
              ),
          ],
        ),
      ),
    );
  }
}
