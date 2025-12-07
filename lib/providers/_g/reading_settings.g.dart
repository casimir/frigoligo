// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of '../reading_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReaderSettingsValues _$ReaderSettingsValuesFromJson(
  Map<String, dynamic> json,
) => ReaderSettingsValues(
  fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16.0,
  height: (json['height'] as num?)?.toDouble() ?? 1.5,
  letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0.5,
  fontFamily: json['fontFamily'] as String? ?? defaultReadingFont,
  justifyText: json['justifyText'] as bool? ?? false,
);

Map<String, dynamic> _$ReaderSettingsValuesToJson(
  ReaderSettingsValues instance,
) => <String, dynamic>{
  'fontSize': instance.fontSize,
  'height': instance.height,
  'letterSpacing': instance.letterSpacing,
  'fontFamily': instance.fontFamily,
  'justifyText': instance.justifyText,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReadingSettings)
const readingSettingsProvider = ReadingSettingsProvider._();

final class ReadingSettingsProvider
    extends $NotifierProvider<ReadingSettings, ReaderSettingsValues> {
  const ReadingSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingSettingsHash();

  @$internal
  @override
  ReadingSettings create() => ReadingSettings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReaderSettingsValues value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReaderSettingsValues>(value),
    );
  }
}

String _$readingSettingsHash() => r'c10dfcc2b6e885c4d5e5ebe24dee9758a5487691';

abstract class _$ReadingSettings extends $Notifier<ReaderSettingsValues> {
  ReaderSettingsValues build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReaderSettingsValues, ReaderSettingsValues>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReaderSettingsValues, ReaderSettingsValues>,
              ReaderSettingsValues,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
