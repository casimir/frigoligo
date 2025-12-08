import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/remote_sync.dart';
import '../services/remote_sync_actions.dart';
import 'settings.dart';

part '_g/save_article.freezed.dart';
part '_g/save_article.g.dart';

@freezed
sealed class SaveArticleState with _$SaveArticleState {
  const factory SaveArticleState.pending() = SASPending;
  const factory SaveArticleState.postponed() = SASPostponed;
  const factory SaveArticleState.success(int articleId) = SASSuccess;
  const factory SaveArticleState.error(Object e) = SASError;
  const factory SaveArticleState.errorDubiousUrl(Uri? parsed) =
      SASErrorDubiousUrl;
}

@riverpod
class SaveArticle extends _$SaveArticle {
  static final _log = Logger('P/SaveArticle');

  @override
  SaveArticleState build(String url) {
    _doSave(url);
    return const SaveArticleState.pending();
  }

  Future<void> _doSave(String url) async {
    final parsedUri = Uri.tryParse(url);
    if (parsedUri?.host.isEmpty ?? true) {
      state = SaveArticleState.errorDubiousUrl(parsedUri);
      return;
    }

    final settings = ref.read(settingsProvider);
    final tags = settings[Sk.tagSaveEnabled]
        ? [settings[Sk.tagSaveLabel] as String]
        : null;

    try {
      final action = SaveArticleAction(parsedUri!, tags: tags);
      final syncer = ref.read(remoteSyncerProvider.notifier);
      await syncer.add(action);
      final res = await syncer.synchronize();

      final int? articleId = res[action.key];
      state = articleId != null
          ? SASSuccess(res[action.key])
          : const SASPostponed();
    } catch (e, st) {
      _log.severe('failed to save URL: $url', e, st);
      state = SaveArticleState.error(e);
    }
  }
}

class _AsyncSaveArticle {
  _AsyncSaveArticle(this._container, this.url);

  final Completer<SaveArticleState> _completer = Completer();
  final ProviderContainer _container;
  final String url;

  Future<SaveArticleState> execute() {
    _container.listen(saveArticleProvider(url), (previous, next) {
      if (next is! SASPending) {
        _completer.complete(next);
      }
    });
    return _completer.future;
  }
}

Future<SaveArticleState> saveArticle(ProviderContainer container, String url) =>
    _AsyncSaveArticle(container, url).execute();
