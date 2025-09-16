// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file


part of '../logconsole.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogConsole)
const logConsoleProvider = LogConsoleProvider._();

final class LogConsoleProvider
    extends $NotifierProvider<LogConsole, LogConsoleToken> {
  const LogConsoleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logConsoleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logConsoleHash();

  @$internal
  @override
  LogConsole create() => LogConsole();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogConsoleToken value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogConsoleToken>(value),
    );
  }
}

String _$logConsoleHash() => r'b6d63ae92e01a719dd5e1049ab6851801a386294';

abstract class _$LogConsole extends $Notifier<LogConsoleToken> {
  LogConsoleToken build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<LogConsoleToken, LogConsoleToken>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LogConsoleToken, LogConsoleToken>,
              LogConsoleToken,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
