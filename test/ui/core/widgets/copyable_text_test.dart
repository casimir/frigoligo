import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/widgets/copyable_text.dart';

void main() {
  Widget buildWidget(String text, [String? data]) {
    return MaterialApp(
      home: Scaffold(body: CopyableText(text: Text(text), data: data)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }

  void setupClipboardCallback(
    WidgetTester tester,
    void Function(String?) callback,
  ) {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (methodCall) async {
        if (methodCall.method == 'Clipboard.setData') {
          callback(methodCall.arguments['text']);
        }
        return null;
      },
    );
  }

  group('CopyableText', () {
    testWidgets('should display the wrappped Text', (tester) async {
      await tester.pumpWidget(buildWidget('test'));

      expect(find.text('test'), findsOneWidget);
    });

    testWidgets('should copy text to the clipboard and show a snackbar', (
      tester,
    ) async {
      late final String? clipboardContent;
      setupClipboardCallback(tester, (text) => clipboardContent = text);

      await tester.pumpWidget(buildWidget('test'));

      await tester.tap(find.text('test'));
      await tester.pumpAndSettle();

      expect(clipboardContent, 'test');
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should copy data to the clipboard and show a snackbar', (
      tester,
    ) async {
      late final String? clipboardContent;
      setupClipboardCallback(tester, (text) => clipboardContent = text);

      await tester.pumpWidget(buildWidget('test', 'data'));

      await tester.tap(find.text('test'));
      await tester.pumpAndSettle();

      expect(clipboardContent, 'data');
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
