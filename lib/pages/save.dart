import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../buildcontext_extension.dart';
import '../providers/settings.dart';
import '../services/remote_sync.dart';
import '../services/remote_sync_actions.dart';
import '../wallabag/client.dart';

class SavePage extends ConsumerStatefulWidget {
  const SavePage({super.key, required this.url});

  final String? url;

  @override
  ConsumerState<SavePage> createState() => _SavePageState();
}

class _SavePageState extends ConsumerState<SavePage> {
  SaveStep step = SaveStep.pending;
  int? savedArticleId;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    if (widget.url == null) {
      step = SaveStep.error;
      errorMessage = context.L.save_noUrl;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final settings = ref.read(settingsProvider);
        if (settings[Sk.tagSaveEnabled]) {
          _doSave([settings[Sk.tagSaveLabel]]);
        } else {
          _doSave();
        }
      });
    }
  }

  Future<void> _doSave([List<String>? tags]) async {
    final url = Uri.tryParse(widget.url!);
    if (url?.host.isEmpty ?? true) {
      final res = await showOkCancelAlertDialog(
        context: context,
        title: context.L.save_dubiousUrlTitle,
        message: context.L.save_dubiousUrlMessage(widget.url!),
        okLabel: context.L.save_dubiousUrlConfirm,
      );
      if (res == OkCancelResult.cancel) {
        if (mounted) context.pop();
        return;
      }
    }

    try {
      final action = SaveArticleAction(url!, tags: tags);
      final syncer = ref.read(remoteSyncerProvider.notifier);
      await syncer.add(action);
      final res = await syncer.synchronize();

      setState(() {
        step = SaveStep.success;
        savedArticleId = res[action.key]!;
      });
    } catch (e) {
      setState(() {
        step = SaveStep.error;
        if (e is ServerError) {
          errorMessage = e.message;
        } else {
          errorMessage = e.toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.save_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: switch (step) {
            SaveStep.pending => _buildPendingWidgets(),
            SaveStep.success => _buildSuccessWidgets(),
            SaveStep.error => _buildErrorWidgets(),
          },
        ),
      ),
    );
  }

  List<Widget> _buildPendingWidgets() {
    return [
      const CircularProgressIndicator.adaptive(),
    ];
  }

  List<Widget> _buildSuccessWidgets() {
    return [
      Text(
        context.L.save_confirmationTitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      C.spacers.verticalContent,
      const Icon(Icons.check_circle_outline, size: 40),
      C.spacers.verticalContent,
      // TODO a preview card would be waaaay nicer
      ElevatedButton(
        onPressed: () => context.go('/articles/$savedArticleId'),
        child: Text(context.L.save_viewArticle),
      ),
    ];
  }

  List<Widget> _buildErrorWidgets() {
    return [
      Text(
        errorMessage!,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      C.spacers.verticalContent,
      const Icon(Icons.error_outline, size: 40),
    ];
  }
}

enum SaveStep {
  pending,
  success,
  error,
}
