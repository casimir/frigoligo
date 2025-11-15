import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/models/article_data.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/article/controllers/article_sheet_controller.dart';
import 'package:frigoligo/ui/article/widgets/article_sheet.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleSheetController extends Mock
    implements ArticleSheetController {}

class MockRect extends Mock implements Rect {}

class MockUri extends Mock implements Uri {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockRect());
    registerFallbackValue(MockUri());
  });

  group('ArticleSheet', () {
    const testData = ArticleData(
      id: 1,
      title: 'Article Title',
      domainName: 'domain.tld',
      url: 'https://domain.tld/article',
      hasContent: true,
      readingTime: 5,
      previewPicture: 'https://domain.tld/article.png',
      tags: ['tag1', 'tag2'],
      isArchived: false,
      isStarred: false,
    );

    late MockArticleSheetController mockController;

    setUp(() {
      mockController = MockArticleSheetController();
      when(
        () => mockController.allTags(),
      ).thenAnswer((_) async => testData.tags);
      when(() => mockController.refetchContent()).thenAnswer((_) async {});
      when(
        () => mockController.share(captureAny(), captureAny(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockController.openInBrowser(captureAny()),
      ).thenAnswer((_) async {});
      when(() => mockController.setTags(captureAny())).thenAnswer((_) async {});
    });

    Widget buildWidget([ArticleData? withData]) {
      return ProviderScope(
        child: MaterialApp(
          home: Material(
            child: ArticleSheet(
              controller: mockController,
              data: withData ?? testData,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      );
    }

    testWidgets('should render article data', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text(testData.title), findsOneWidget);
      expect(find.text(testData.domainName!), findsOneWidget);
      expect(find.text('${testData.readingTime} min'), findsOneWidget);
      for (final tag in testData.tags) {
        expect(find.text(tag), findsOneWidget);
      }
    });

    testWidgets('should allow to refetch the article content', (tester) async {
      await tester.pumpWidget(buildWidget());

      final BuildContext context = tester.element(find.byType(ArticleSheet));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.article_refetchContent));
      await tester.pumpAndSettle();

      verify(() => mockController.refetchContent()).called(1);
    });

    testWidgets('should allow to share the article', (tester) async {
      await tester.pumpWidget(buildWidget());

      final BuildContext context = tester.element(find.byType(ArticleSheet));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.g_share));

      verify(
        () => mockController.share(testData.title, testData.url, any()),
      ).called(1);
    });

    testWidgets('should allow to open the article in the browser', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget());

      final BuildContext context = tester.element(find.byType(ArticleSheet));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.article_openInBrowser));

      verify(
        () => mockController.openInBrowser(Uri.parse(testData.url)),
      ).called(1);
    });

    testWidgets('should allow to modify the tags', (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text(testData.tags[0]));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Select ${testData.tags.length} tags'));
      await tester.pumpAndSettle();

      verify(() => mockController.setTags(testData.tags)).called(1);
    });

    testWidgets('should allow to add tags when there are no tags', (
      tester,
    ) async {
      const articleData = ArticleData(
        id: 1,
        title: '',
        domainName: '',
        url: '',
        hasContent: true,
        readingTime: 1,
        previewPicture: '',
        tags: [],
        isArchived: false,
        isStarred: false,
      );
      await tester.pumpWidget(buildWidget(articleData));

      final BuildContext context = tester.element(find.byType(ArticleSheet));
      final l = AppLocalizations.of(context)!;

      await tester.tap(find.text(l.article_addTags));
      await tester.pumpAndSettle();

      expect(find.text('Select 0 tags'), findsOneWidget);
    });
  });
}
