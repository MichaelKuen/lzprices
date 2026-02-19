import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lzprices/models/product.dart';
import 'package:lzprices/services/product_sync_service.dart';
import 'package:lzprices/service_locator.dart';

enum SortOption { none, priceAsc, priceDesc }

class SearchPageViewModel extends ChangeNotifier {
  final ProductSyncService _syncService = sl<ProductSyncService>();
  Timer? _debounce;

  List<Product> _searchResults = [];
  List<Product> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<String> _allCategories = [];
  List<String> get allCategories => _allCategories;

  final Set<String> _selectedCategories = {'All'};
  Set<String> get selectedCategories => _selectedCategories;

  bool _isLoadingCategories = true;
  bool get isLoadingCategories => _isLoadingCategories;

  SortOption _activeSort = SortOption.priceAsc;
  SortOption get activeSort => _activeSort;

  final TextEditingController searchController = TextEditingController();

  SearchPageViewModel() {
    _fetchCategories();
    searchController.addListener(() {
      _onSearchChanged(searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    _isLoadingCategories = true;
    notifyListeners();
    try {
      final categories = await _syncService.getProductCategories();
      _allCategories = ['All', ...categories];
    } catch (e) {
      // Handle error
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      performSearch();
    });
  }

  void onCategorySelected(bool selected, String category) {
    if (category == 'All') {
      _selectedCategories.clear();
      _selectedCategories.add('All');
    } else {
      _selectedCategories.remove('All');
      if (selected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    }

    if (_selectedCategories.isEmpty) {
      _selectedCategories.add('All');
    }
    notifyListeners();
    performSearch();
  }

    void applyCategoryFilter(Set<String> newCategories) {
    _selectedCategories.clear();
    _selectedCategories.addAll(newCategories);
    notifyListeners();
    performSearch();
  }

  void onSortSelected(SortOption option) {
    _activeSort = option;
    notifyListeners();
    performSearch();
  }

  Future<void> performSearch() async {
    final searchTerm = searchController.text.trim();
    final categoriesToSearch =
        (_selectedCategories.contains('All') || _selectedCategories.isEmpty)
            ? null
            : _selectedCategories.toList();

    if (searchTerm.isEmpty && categoriesToSearch == null) {
      _searchResults = [];
      _errorMessage = '';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<Product> results = await _syncService.searchProducts(searchTerm,
          categories: categoriesToSearch);

      if (_activeSort == SortOption.priceAsc) {
        results.sort((a, b) =>
            (a.price ?? double.maxFinite)
                .compareTo(b.price ?? double.maxFinite));
      } else if (_activeSort == SortOption.priceDesc) {
        results.sort((a, b) => (b.price ?? -1).compareTo(a.price ?? -1));
      }

      _searchResults = results;
    } catch (_) {
      _errorMessage = 'Failed to search products';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
