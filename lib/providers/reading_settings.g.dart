// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReaderSettingsValues _$ReaderSettingsValuesFromJson(
        Map<String, dynamic> json) =>
    ReaderSettingsValues(
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16.0,
      height: (json['height'] as num?)?.toDouble() ?? 1.5,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0.5,
      fontFamily: json['fontFamily'] as String?,
    );

Map<String, dynamic> _$ReaderSettingsValuesToJson(
        ReaderSettingsValues instance) =>
    <String, dynamic>{
      'fontSize': instance.fontSize,
      'height': instance.height,
      'letterSpacing': instance.letterSpacing,
      'fontFamily': instance.fontFamily,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readingSettingsHash() => r'82dee1fd4400429cc8df011a359631835f6ae000';

/// See also [ReadingSettings].
@ProviderFor(ReadingSettings)
final readingSettingsProvider =
    AutoDisposeNotifierProvider<ReadingSettings, ReaderSettingsValues>.internal(
  ReadingSettings.new,
  name: r'readingSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$readingSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReadingSettings = AutoDisposeNotifier<ReaderSettingsValues>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
