// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LanguageSelection)
const languageSelectionProvider = LanguageSelectionProvider._();

final class LanguageSelectionProvider
    extends $AsyncNotifierProvider<LanguageSelection, LanguagePair> {
  const LanguageSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageSelectionHash();

  @$internal
  @override
  LanguageSelection create() => LanguageSelection();
}

String _$languageSelectionHash() => r'dac24e34e5cebf717a75338d19eb45c8642dec61';

abstract class _$LanguageSelection extends $AsyncNotifier<LanguagePair> {
  FutureOr<LanguagePair> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<LanguagePair>, LanguagePair>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LanguagePair>, LanguagePair>,
              AsyncValue<LanguagePair>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
