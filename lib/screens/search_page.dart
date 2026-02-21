import 'package:flutter/material.dart';
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
          create: (_) => SearchPageViewModel(),
        ),
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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
    final permissions = context.watch<Map<String, dynamic>>();
    final authService = AuthService();

    // Permission flags
    final bool canEdit = permissions['canEdit'] ?? false;
    final bool canDelete = permissions['canDelete'] ?? false;
    final bool showPrice = permissions['showPrice'] ?? true;
    final bool showInstallerPrice = permissions['showInstallerPrice'] ?? false;
    final bool showWholesalePrice = permissions['showWholesalePrice'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        actions: [
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
          // Search box
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

          // Category chips
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

          // Sort dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: DropdownButton<SortOption>(
              value: viewModel.activeSort,
              items: const [
                DropdownMenuItem(
                    value: SortOption.none, child: Text('No Sort')),
                DropdownMenuItem(
                    value: SortOption.priceAsc,
                    child: Text('Price Asc')),
                DropdownMenuItem(
                    value: SortOption.priceDesc,
                    child: Text('Price Desc')),
              ],
              onChanged: (option) {
                if (option != null) {
                  viewModel.onSortSelected(option);
                }
              },
            ),
          ),

          // Results
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
    final List<Widget> priceWidgets = [];

    if (showPrice && product.price != null) {
      priceWidgets.add(
        Text('Retail: \$${product.price!.toStringAsFixed(2)}'),
      );
    }

    if (showInstallerPrice && product.installerPrice != null) {
      priceWidgets.add(
        Text('Installer: \$${product.installerPrice!.toStringAsFixed(2)}'),
      );
    }

    if (showWholesalePrice && product.wholesalePrice != null) {
      priceWidgets.add(
        Text('Wholesale: \$${product.wholesalePrice!.toStringAsFixed(2)}'),
      );
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
                  // TODO: Implement edit functionality
                },
              ),
            if (canDelete)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // TODO: Implement delete functionality
                },
              ),
          ],
        ),
      ),
    );
  }
}