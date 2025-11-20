import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/domain/models/article_data.dart';
import 'package:frigoligo/src/generated/i18n/app_localizations.dart';
import 'package:frigoligo/ui/core/states.dart';
import 'package:frigoligo/ui/home/controllers/article_entry_controller.dart';
import 'package:frigoligo/ui/home/widgets/article_entry.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleEntryController extends Mock
    implements ArticleEntryController {}

// It should be possible to override families and simplify this with riverpod 3.
class _FakeArticleState extends ArticleState {
  _FakeArticleState(this._data);

  final ArticleData _data;

  @override
  Future<ArticleData?> build(int articleId) async {
    return _data;
  }
}

void main() {
  group('ArticleEntry', () {
    late MockArticleEntryController mockController;

    setUp(() {
      mockController = MockArticleEntryController();
      when(() => mockController.articleId).thenReturn(1);
      when(() => mockController.setArchived(any())).thenAnswer((_) async {});
      when(() => mockController.setStarred(any())).thenAnswer((_) async {});
      when(
        () => mockController.changeTagsSearchFilterTo(any()),
      ).thenReturn(null);
    });

    (ArticleData, Widget) buildStateAndWidget({
      String? previewPicture,
      bool isStarred = false,
      bool isArchived = false,
    }) {
      final state = ArticleData(
        id: 1,
        title: 'Article Title',
        domainName: 'domain.tld',
        url: 'https://domain.tld/article',
        hasContent: true,
        readingTime: 5,
        previewPicture: previewPicture,
        tags: ['tag1', 'tag2'],
        isArchived: isArchived,
        isStarred: isStarred,
      );
      final widget = ProviderScope(
        overrides: [
          // ignore: scoped_providers_should_specify_dependencies
          articleStateProvider(1).overrideWith(() => _FakeArticleState(state)),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(body: ArticleEntry(controller: mockController)),
        ),
      );
      return (state, widget);
    }

    testWidgets('should render article data', (tester) async {
      final (state, widget) = buildStateAndWidget();

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(state.title), findsOneWidget);
      expect(find.text(state.domainName!), findsOneWidget);
      expect(find.textContaining('${state.readingTime} min'), findsOneWidget);
      for (final tag in state.tags) {
        expect(find.text(tag), findsOneWidget);
      }
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('should show an image when previewPicture is provided', (
      tester,
    ) async {
      final (state, widget) = buildStateAndWidget(previewPicture: '/image.png');

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(AnyImageView), findsOneWidget);
    });

    testWidgets('should display correct icons baed on state', (tester) async {
      final (state, widget) = buildStateAndWidget(
        isArchived: true,
        isStarred: true,
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.unarchive), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should not show an image when previewPicture is null', (
      tester,
    ) async {
      final (state, widget) = buildStateAndWidget(previewPicture: null);

      await tester.pumpWidget(widget);
      await tester.pump();

      expect(find.byType(Image), findsNothing);
    });

    testWidgets(
      'should call controller.changeTagsSearchFilterTo when a tag is tapped',
      (tester) async {
        final (state, widget) = buildStateAndWidget();

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.tap(find.text('tag2'));

        verify(() => mockController.changeTagsSearchFilterTo('tag2')).called(1);
      },
    );

    testWidgets(
      'should call controller.setArchived when the archive icon is tapped',
      (tester) async {
        final (state, widget) = buildStateAndWidget();

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.done));

        verify(() => mockController.setArchived(true)).called(1);
      },
    );

    testWidgets(
      'should call controller.setStarred when the star icon is tapped',
      (tester) async {
        final (state, widget) = buildStateAndWidget();

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.star_border));

        verify(() => mockController.setStarred(true)).called(1);
      },
    );
  });
}
