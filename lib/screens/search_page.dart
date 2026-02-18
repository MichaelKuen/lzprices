import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lzprices/services/product_sync_service.dart';
import 'package:lzprices/models/product.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum SortOption { none, priceAsc, priceDesc }

enum ShareableAttribute {
  name,
  sku,
  quantity,
  retailPrice,
  installerPrice,
  wholesalePrice,
  locations,
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late ProductSyncService _syncService;
  Timer? _debounce;

  final ValueNotifier<List<Product>> _searchResults = ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<String> _errorMessage = ValueNotifier('');
  bool _isInitialized = false;
  bool _showSidebar = true;

  // State for category filters
  List<String> _allCategories = [];
  final Set<String> _selectedCategories = {'All'};
  bool _isLoadingCategories = true;

  // State for sorting
  SortOption _activeSort = SortOption.priceAsc;

  bool get _isDesktop {
    if (kIsWeb) return false;
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  bool get _isDesktopOrWeb {
    return kIsWeb || _isDesktop;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _syncService = context.read<ProductSyncService>();
      _fetchCategories();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _searchResults.dispose();
    _isLoading.dispose();
    _errorMessage.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await _syncService.getProductCategories();
      if (mounted) {
        setState(() {
          _allCategories = ['All', ...categories];
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingCategories = false);
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch();
    });
  }

  void _onCategorySelected(bool selected, String category) {
    setState(() {
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
    });
    _performSearch();
  }

  void _applyCategoryFilter(Set<String> newCategories) {
    setState(() {
      _selectedCategories.clear();
      _selectedCategories.addAll(newCategories);
    });
    _performSearch();
  }

  void _onSortSelected(SortOption option) {
    setState(() {
      _activeSort = option;
    });
    _performSearch(); // Re-run the search to apply the new sort order
  }

  void _showFilterSheet() {
    final tempSelectedCategories = Set<String>.from(_selectedCategories);
    var tempSortOption = _activeSort;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              maxChildSize: 0.9,
              builder: (_, scrollController) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Filter & Sort',
                              style: Theme.of(context).textTheme.titleLarge),
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                tempSelectedCategories.clear();
                                tempSelectedCategories.add('All');
                                tempSortOption = SortOption.priceAsc;
                              });
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text('Sort By',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          RadioListTile<SortOption>(
                            title: const Text('Price: Low to High'),
                            value: SortOption.priceAsc,
                            groupValue: tempSortOption,
                            onChanged: (value) {
                              setModalState(() {
                                tempSortOption = value!;
                              });
                            },
                          ),
                          RadioListTile<SortOption>(
                            title: const Text('Price: High to Low'),
                            value: SortOption.priceDesc,
                            groupValue: tempSortOption,
                            onChanged: (value) {
                              setModalState(() {
                                tempSortOption = value!;
                              });
                            },
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text('Categories',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          ..._allCategories.map((category) {
                            return CheckboxListTile(
                              title: Text(category),
                              value: tempSelectedCategories.contains(category),
                              onChanged: (bool? value) {
                                setModalState(() {
                                  if (value == true) {
                                    if (category == 'All') {
                                      tempSelectedCategories.clear();
                                      tempSelectedCategories.add('All');
                                    } else {
                                      tempSelectedCategories.remove('All');
                                      tempSelectedCategories.add(category);
                                    }
                                  } else {
                                    tempSelectedCategories.remove(category);
                                  }

                                  if (tempSelectedCategories.isEmpty) {
                                    tempSelectedCategories.add('All');
                                  }
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          _applyCategoryFilter(tempSelectedCategories);
                          _onSortSelected(tempSortOption);
                          Navigator.pop(context);
                        },
                        child: const Text('Apply'),
                      ),
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _performSearch() async {
    final searchTerm = _searchController.text.trim();
    final categoriesToSearch =
    (_selectedCategories.contains('All') || _selectedCategories.isEmpty)
        ? null
        : _selectedCategories.toList();

    if (searchTerm.isEmpty && categoriesToSearch == null) {
      _searchResults.value = [];
      _errorMessage.value = '';
      return;
    }

    _isLoading.value = true;
    _errorMessage.value = '';

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

      _searchResults.value = results;
    } catch (_) {
      _errorMessage.value = 'Failed to search products';
    } finally {
      _isLoading.value = false;
    }
  }

  String _buildShareMessage(Product product, Set<ShareableAttribute> attributes) {
    final productParts = <String>[];

    if (attributes.contains(ShareableAttribute.name)) {
      productParts.add('Product: ${product.name}');
    }
    if (attributes.contains(ShareableAttribute.sku) && product.sku != null) {
      productParts.add('SKU: ${product.sku}');
    }
    if (attributes.contains(ShareableAttribute.quantity) &&
        product.quantity != null) {
      productParts.add('Qty: ${product.quantity}');
    }
    if (attributes.contains(ShareableAttribute.retailPrice) &&
        product.price != null) {
      productParts
          .add('Retail Price: R${product.price!.toStringAsFixed(2)}');
    }
    if (attributes.contains(ShareableAttribute.installerPrice) &&
        product.installerPrice != null) {
      productParts.add(
          'Installer Price: R${product.installerPrice!.toStringAsFixed(2)}');
    }
    if (attributes.contains(ShareableAttribute.wholesalePrice) &&
        product.wholesalePrice != null) {
      productParts.add(
          'Wholesale Price: R${product.wholesalePrice!.toStringAsFixed(2)}');
    }
    if (attributes.contains(ShareableAttribute.locations) &&
        product.locations != null &&
        product.locations!.isNotEmpty) {
      productParts.add('Locations: ${product.locations!.join(', ')}');
    }
    return productParts.join('\n');
  }

  Future<void> _showShareOptions(Product product) async {
    final selectedAttributes = <ShareableAttribute>{ShareableAttribute.name};

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              maxChildSize: 0.9,
              builder: (_, scrollController) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text('Select details to share',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          CheckboxListTile(
                            title: const Text('Product Name'),
                            value: selectedAttributes
                                .contains(ShareableAttribute.name),
                            onChanged: (value) {
                              setModalState(() {
                                if (value!) {
                                  selectedAttributes
                                      .add(ShareableAttribute.name);
                                } else {
                                  selectedAttributes
                                      .remove(ShareableAttribute.name);
                                }
                              });
                            },
                          ),
                          if (product.sku != null)
                            CheckboxListTile(
                              title: const Text('SKU'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.sku),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes
                                        .add(ShareableAttribute.sku);
                                  } else {
                                    selectedAttributes
                                        .remove(ShareableAttribute.sku);
                                  }
                                });
                              },
                            ),
                          if (product.quantity != null)
                            CheckboxListTile(
                              title: const Text('Quantity'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.quantity),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes
                                        .add(ShareableAttribute.quantity);
                                  } else {
                                    selectedAttributes
                                        .remove(ShareableAttribute.quantity);
                                  }
                                });
                              },
                            ),
                          if (product.price != null)
                            CheckboxListTile(
                              title: const Text('Retail Price'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.retailPrice),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes
                                        .add(ShareableAttribute.retailPrice);
                                  } else {
                                    selectedAttributes.remove(
                                        ShareableAttribute.retailPrice);
                                  }
                                });
                              },
                            ),
                          if (product.installerPrice != null)
                            CheckboxListTile(
                              title: const Text('Installer Price'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.installerPrice),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes.add(
                                        ShareableAttribute.installerPrice);
                                  } else {
                                    selectedAttributes.remove(
                                        ShareableAttribute.installerPrice);
                                  }
                                });
                              },
                            ),
                          if (product.wholesalePrice != null)
                            CheckboxListTile(
                              title: const Text('Wholesale Price'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.wholesalePrice),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes.add(
                                        ShareableAttribute.wholesalePrice);
                                  } else {
                                    selectedAttributes.remove(
                                        ShareableAttribute.wholesalePrice);
                                  }
                                });
                              },
                            ),
                          if (product.locations != null &&
                              product.locations!.isNotEmpty)
                            CheckboxListTile(
                              title: const Text('Locations'),
                              value: selectedAttributes
                                  .contains(ShareableAttribute.locations),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value!) {
                                    selectedAttributes
                                        .add(ShareableAttribute.locations);
                                  } else {
                                    selectedAttributes
                                        .remove(ShareableAttribute.locations);
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(double.infinity, 48),
                              backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              _shareViaWhatsApp(product,
                                  attributes: selectedAttributes);
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp),
                            label: const Text('Share via WhatsApp'),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(0, 48),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _copyToClipboard(product,
                                        attributes: selectedAttributes);
                                  },
                                  icon: const Icon(Icons.copy),
                                  label: const Text('Copy'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(0, 48),
                                    foregroundColor: const Color(0xFF07C160), // WeChat Green
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _shareViaWeChat(product,
                                        attributes: selectedAttributes);
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.weixin),
                                  label: const Text('WeChat'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _copyToClipboard(
      Product product, {Set<ShareableAttribute> attributes = const {}}) async {
    final message = _buildShareMessage(product, attributes);
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item to copy.')),
      );
      return;
    }
    await Clipboard.setData(ClipboardData(text: message));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _shareViaWeChat(
      Product product, {Set<ShareableAttribute> attributes = const {}}) async {
    final message = _buildShareMessage(product, attributes);
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item to share.')),
      );
      return;
    }

    await Clipboard.setData(ClipboardData(text: message));

    const wechatUri = 'weixin://';
    if (await canLaunchUrl(Uri.parse(wechatUri))) {
      await launchUrl(Uri.parse(wechatUri));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard, please paste in WeChat.')),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open WeChat.')),
        );
      }
    }
  }

  void _shareViaWhatsApp(Product product,
      {Set<ShareableAttribute> attributes = const {}}) async {
    if (attributes.isEmpty) {
      _showShareOptions(product);
      return;
    }

    final message = _buildShareMessage(product, attributes);
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one item to share.')),
      );
      return;
    }

    final encodedMessage = Uri.encodeComponent(message);

    // Try to launch native WhatsApp
    final nativeUri = Uri.parse('whatsapp://send?text=$encodedMessage');
    if (await canLaunchUrl(nativeUri)) {
      await launchUrl(nativeUri);
      return;
    }

    // Fallback to web link
    final webUrl = Uri.parse('https://wa.me/?text=$encodedMessage');
    if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch WhatsApp')),
        );
      }
    }
  }

  Widget _buildActiveFilters() {
    if (_isDesktopOrWeb) {
      return const SizedBox.shrink();
    }

    final bool hasActiveCategory =
    !(_selectedCategories.contains('All') || _selectedCategories.isEmpty);

    if (!hasActiveCategory) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Filters',
                  style: Theme.of(context).textTheme.titleSmall),
              TextButton(
                onPressed: () => _onCategorySelected(true, 'All'),
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _selectedCategories.map((category) {
              return Chip(
                label: Text(category),
                onDeleted: () => _onCategorySelected(false, category),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSortChip() {
    if (_activeSort == SortOption.none) {
      return const SizedBox.shrink();
    }

    String label;
    switch (_activeSort) {
      case SortOption.priceAsc:
        label = 'Sort: Price Low to High';
        break;
      case SortOption.priceDesc:
        label = 'Sort: Price High to Low';
        break;
      case SortOption.none:
        label = '';
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Chip(
        label: Text(label),
        onDeleted: () {
          _onSortSelected(SortOption.priceAsc); // Reset to default
        },
      ),
    );
  }

  Widget _buildCategoryFilters() {
    if (kIsWeb ||
        (kIsWeb == false && Platform.isWindows) ||
        !_isDesktopOrWeb ||
        _isLoadingCategories) {
      return const SizedBox.shrink();
    }
    if (_allCategories.length <= 1) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: _allCategories.map((category) {
          final isSelected = _selectedCategories.contains(category);
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selected) {
              _onCategorySelected(selected, category);
            },
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            backgroundColor:
            Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withAlpha(128),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool showSearchPrompt = _searchController.text.isEmpty &&
        (_selectedCategories.contains('All') || _selectedCategories.isEmpty);

    final body = _isDesktopOrWeb
        ? _buildDesktopBody(theme, showSearchPrompt)
        : _buildMobileBody(theme, showSearchPrompt);

    return Scaffold(
      body: body,
    );
  }

  Widget _buildDesktopBody(ThemeData theme, bool showSearchPrompt) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: theme.colorScheme.surface,
                  title: _buildSearchField(theme),
                ),
                SliverToBoxAdapter(child: _buildActiveSortChip()),
                SliverToBoxAdapter(child: _buildCategoryFilters()),
                ValueListenableBuilder<List<Product>>(
                  valueListenable: _searchResults,
                  builder: (context, results, child) {
                    return _buildResultsSliver(showSearchPrompt, theme, results);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBody(ThemeData theme, bool showSearchPrompt) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSearchField(theme),
          ),
          _buildActiveSortChip(),
          _buildActiveFilters(),
          Expanded(
            child: ValueListenableBuilder<List<Product>>(
              valueListenable: _searchResults,
              builder: (context, results, child) {
                return _buildResultsList(showSearchPrompt, theme, results);
              },
            ),
          ),
        ],
      ),
    );
  }

  TextField _buildSearchField(ThemeData theme) {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: 'Search for products...',
        prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isDesktopOrWeb)
              IconButton(
                icon: Icon(Icons.filter_list,
                    color: theme.colorScheme.onSurfaceVariant),
                onPressed: _showFilterSheet,
              ),
            if (_isDesktopOrWeb)
              IconButton(
                icon: Icon(
                    _showSidebar ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _showSidebar = !_showSidebar;
                  });
                },
              ),
            if (_isDesktopOrWeb)
              PopupMenuButton<SortOption>(
                icon: const Icon(Icons.sort),
                tooltip: 'Sort Products',
                onSelected: _onSortSelected,
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SortOption>>[
                  const PopupMenuItem<SortOption>(
                    value: SortOption.priceAsc,
                    child: Text('Price: Low to High'),
                  ),
                  const PopupMenuItem<SortOption>(
                    value: SortOption.priceDesc,
                    child: Text('Price: High to Low'),
                  ),
                  if (_activeSort != SortOption.none) const PopupMenuDivider(),
                  if (_activeSort != SortOption.none)
                    const PopupMenuItem<SortOption>(
                      value: SortOption.none,
                      child: Text('Clear Sort'),
                    ),
                ],
              ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear,
                    color: theme.colorScheme.onSurfaceVariant),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
              ),
          ],
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildResultsSliver(
      bool showSearchPrompt, ThemeData theme, List<Product> searchResults) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()));
        }

        return ValueListenableBuilder<String>(
          valueListenable: _errorMessage,
          builder: (context, errorMessage, child) {
            if (errorMessage.isNotEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: theme.colorScheme.error),
                      const SizedBox(height: 16),
                      Text(errorMessage,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: theme.colorScheme.error)),
                    ],
                  ),
                ),
              );
            }

            if (showSearchPrompt) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search,
                          size: 80,
                          color:
                          theme.colorScheme.onSurfaceVariant.withAlpha(128)),
                      const SizedBox(height: 16),
                      Text('Start typing to search products',
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              );
            }

            if (searchResults.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off,
                          size: 80,
                          color:
                          theme.colorScheme.onSurfaceVariant.withAlpha(128)),
                      const SizedBox(height: 16),
                      Text('No products found',
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                      _buildProductCard(theme, searchResults[index]),
                  childCount: searchResults.length,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildResultsList(
      bool showSearchPrompt, ThemeData theme, List<Product> searchResults) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ValueListenableBuilder<String>(
          valueListenable: _errorMessage,
          builder: (context, errorMessage, child) {
            if (errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64, color: theme.colorScheme.error),
                    const SizedBox(height: 16),
                    Text(errorMessage,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: theme.colorScheme.error)),
                  ],
                ),
              );
            }

            if (showSearchPrompt) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search,
                        size: 80,
                        color:
                        theme.colorScheme.onSurfaceVariant.withAlpha(128)),
                    const SizedBox(height: 16),
                    Text('Start typing to search products',
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              );
            }

            if (searchResults.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off,
                        size: 80,
                        color:
                        theme.colorScheme.onSurfaceVariant.withAlpha(128)),
                    const SizedBox(height: 16),
                    Text('No products found',
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: searchResults.length,
              itemBuilder: (context, index) =>
                  _buildProductCard(theme, searchResults[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildLocationChips(ThemeData theme, List<String> locations) {
    final sortedLocations = List<String>.from(locations)..sort();

    final chips = sortedLocations.map((location) {
      final String prefix;
      final Color chipColor;
      final Color textColor;

      if (location.startsWith('U')) {
        prefix = 'Upstairs';
        chipColor = theme.colorScheme.errorContainer;
        textColor = theme.colorScheme.onErrorContainer;
      } else if (location.startsWith('D')) {
        prefix = 'Downstairs';
        chipColor = theme.colorScheme.primaryContainer;
        textColor = theme.colorScheme.onPrimaryContainer;
      } else if (location.startsWith('C')) {
        prefix = 'Counter';
        chipColor = theme.colorScheme.secondaryContainer;
        textColor = theme.colorScheme.onSecondaryContainer;
      } else if (location.toLowerCase().startsWith('back')) {
        prefix = 'Back';
        chipColor = Colors.orange;
        textColor = Colors.white;
      } else {
        prefix = 'Other';
        chipColor = theme.colorScheme.surfaceContainerHighest;
        textColor = theme.colorScheme.onSurfaceVariant;
      }

      return Chip(
        label: Text('$prefix > $location'),
        backgroundColor: chipColor,
        labelStyle: theme.textTheme.bodySmall?.copyWith(color: textColor),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        visualDensity: VisualDensity.compact,
      );
    }).toList();

    if (chips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 4.0,
        children: chips,
      ),
    );
  }

  Widget _buildProductCard(ThemeData theme, Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (product.sku != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('SKU: ${product.sku}', style: theme.textTheme.bodySmall),
                    ),
                  if (product.quantity != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('Quantity: ${product.quantity}', style: theme.textTheme.bodySmall),
                    ),
                  const SizedBox(height: 8),
                  if (product.price != null)
                    Text(
                      'Retail: R${product.price?.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary),
                    ),
                  if (product.installerPrice != null)
                    Text(
                      'Installer: R${product.installerPrice?.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.secondary),
                    ),
                  if (product.wholesalePrice != null)
                    Text(
                      'Wholesale: R${product.wholesalePrice?.toStringAsFixed(2)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.tertiary),
                    ),
                  if (product.locations != null &&
                      product.locations!.isNotEmpty)
                    _buildLocationChips(theme, product.locations!),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onPressed: () => _showShareOptions(product),
                  tooltip: 'Share Product Details',
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.moneyBillWave, color: Colors.blueGrey),
                  onPressed: () => _shareViaWhatsApp(product,
                      attributes: {
                        ShareableAttribute.name,
                        ShareableAttribute.retailPrice,
                        ShareableAttribute.installerPrice,
                        ShareableAttribute.wholesalePrice,
                      }),
                  tooltip: 'Share All Prices',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
