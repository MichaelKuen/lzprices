import 'package:flutter/material.dart';
import 'package:lzprices/models/product.dart';
import 'package:lzprices/viewmodels/search_page_view_model.dart';
import 'package:lzprices/screens/settings_screen.dart';
import 'package:lzprices/services/auth_service.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchPageViewModel>(
      create: (_) => SearchPageViewModel(),
      child: const _SearchPageBody(),
    );
  }
}

class _SearchPageBody extends StatelessWidget {
  const _SearchPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchPageViewModel>();
    final authService = AuthService();

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
                DropdownMenuItem(
                    value: SortOption.none, child: Text('No Sort')),
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
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (viewModel.errorMessage.isNotEmpty)
            Expanded(
              child: Center(child: Text(viewModel.errorMessage)),
            )
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
                    return _buildProductCard(product);
                  },
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.sku ?? ''),
        trailing: Text(product.price != null
            ? '\$${product.price!.toStringAsFixed(2)}'
            : 'N/A'),
      ),
    );
  }
}