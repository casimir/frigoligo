import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/article/widgets/article_content_placeholder.dart';

void main() {
  group('ArticleContentEmpty', () {
    testWidgets(
      'should provide a placeholder with a link to the original article',
      (tester) async {
        int called = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: ArticleContentPlaceholder(
              articleUrl: Uri.parse('https://example.com'),
              openUrlCallback: (_) async {
                called++;
              },
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        );

        final context = tester.element(find.byType(ArticleContentPlaceholder));
        final l = AppLocalizations.of(context)!;

        expect(find.text(l.article_noContentFetched), findsOneWidget);

        await tester.tap(find.text(l.article_openInBrowser));

        expect(called, 1);
      },
    );
  });
}
