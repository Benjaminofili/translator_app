// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesHash() => r'c1030f633b83fb92251785d182a1a0b545811e0e';

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
String _$historyHash() => r'64440da09876b4f88557aa90a950d753c00011b5';

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
