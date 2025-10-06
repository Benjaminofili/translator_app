import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/history_provider.dart';
import '../widgets/empty_history_view.dart';
import '../widgets/history_list_item.dart';
import '../widgets/history_detail_dialog.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// History Screen
///
/// Displays translation history with:
/// - All translations list
/// - Favorites filter
/// - Search functionality
/// - Delete/Clear actions
///
/// Path: lib/features/history/presentation/screens/history_screen.dart
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Favorites'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep_rounded, color: AppColors.error),
                    SizedBox(width: AppTheme.spacingMd),
                    Text('Clear All History'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'clear') {
                _showClearHistoryDialog();
              }
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllHistoryTab(),
          _buildFavoritesTab(),
        ],
      ),
    );
  }

  Widget _buildAllHistoryTab() {
    final historyAsync = ref.watch(historyProvider);

    return historyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              'Error loading history',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      data: (history) {
        if (history.isEmpty) {
          return const EmptyHistoryView(
            message: 'No translations yet',
            icon: Icons.history_rounded,
          );
        }

        final filteredHistory = _searchQuery.isEmpty
            ? history
            : history.where((item) {
          return item.sourceText
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
              item.translatedText
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
        }).toList();

        if (filteredHistory.isEmpty) {
          return EmptyHistoryView(
            message: 'No results for "$_searchQuery"',
            icon: Icons.search_off_rounded,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
          itemCount: filteredHistory.length,
          itemBuilder: (context, index) {
            final item = filteredHistory[index];
            return HistoryListItem(
              history: item,
              onTap: () => _showHistoryDetail(item),
              onFavorite: () {
                ref.read(historyProvider.notifier).toggleFavorite(item.id);
              },
              onDelete: () => _showDeleteDialog(item.id),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    final favoritesAsync = ref.watch(favoritesProvider);

    return favoritesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
      data: (favorites) {
        if (favorites.isEmpty) {
          return const EmptyHistoryView(
            message: 'No favorites yet',
            icon: Icons.star_outline_rounded,
          );
        }

        final filteredFavorites = _searchQuery.isEmpty
            ? favorites
            : favorites.where((item) {
          return item.sourceText
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
              item.translatedText
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
        }).toList();

        if (filteredFavorites.isEmpty) {
          return EmptyHistoryView(
            message: 'No favorites match "$_searchQuery"',
            icon: Icons.search_off_rounded,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
          itemCount: filteredFavorites.length,
          itemBuilder: (context, index) {
            final item = filteredFavorites[index];
            return HistoryListItem(
              history: item,
              onTap: () => _showHistoryDetail(item),
              onFavorite: () {
                ref.read(historyProvider.notifier).toggleFavorite(item.id);
                ref.invalidate(favoritesProvider);
              },
              onDelete: () => _showDeleteDialog(item.id),
            );
          },
        );
      },
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Search History'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter search term...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = '');
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showHistoryDetail(item) {
    showDialog(
      context: context,
      builder: (ctx) => HistoryDetailDialog(history: item),
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Translation'),
        content: const Text(
          'Are you sure you want to delete this translation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(historyProvider.notifier).deleteHistory(id);
              ref.invalidate(favoritesProvider);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Translation deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All History'),
        content: const Text(
          'Are you sure you want to delete all translation history? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(historyProvider.notifier).clearAll();
              ref.invalidate(favoritesProvider);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All history cleared'),
                  backgroundColor: AppColors.success,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}