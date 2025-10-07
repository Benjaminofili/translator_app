// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesHash() => r'dc5f56aa4417749b76013627b23da50efa910a39';

/// See also [favorites].
@ProviderFor(favorites)
final favoritesProvider =
    AutoDisposeFutureProvider<List<TranslationHistory>>.internal(
  favorites,
  name: r'favoritesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesRef = AutoDisposeFutureProviderRef<List<TranslationHistory>>;
String _$historyHash() => r'5893312881a42677a1d87d1b936edb0f12290f54';

/// See also [History].
@ProviderFor(History)
final historyProvider = AutoDisposeAsyncNotifierProvider<History,
    List<TranslationHistory>>.internal(
  History.new,
  name: r'historyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$historyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$History = AutoDisposeAsyncNotifier<List<TranslationHistory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
