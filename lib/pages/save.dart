import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../models/db.dart';
import '../providers/settings.dart';
import '../wallabag/wallabag.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key, required this.url});

  final String? url;

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  SaveStep step = SaveStep.pending;
  int? savedArticleId;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    if (widget.url == null) {
      setState(() {
        step = SaveStep.error;
        errorMessage = 'No URL provided';
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final settings = context.read<SettingsProvider>();
        if (settings[Sk.tagSaveEnabled]) {
          _doSave([settings[Sk.tagSaveLabel]]);
        } else {
          _doSave();
        }
      });
    }
  }

  Future<void> _doSave([List<String>? tags]) async {
    if (Uri.tryParse(widget.url!)?.host.isEmpty ?? true) {
      final res = await showOkCancelAlertDialog(
        context: context,
        title: 'Dubious URL',
        message:
            'This URL does not look like one. Save it anyway?\n${widget.url}',
        okLabel: 'Save it',
      );
      if (res == OkCancelResult.cancel) {
        if (context.mounted) context.pop();
        return;
      }
    }

    try {
      final entry =
          await WallabagInstance.get().createEntry(widget.url!, tags: tags);
      final article = Article.fromWallabagEntry(entry);

      final db = DB.get();
      await db.writeTxn(() async => await db.articles.put(article));

      setState(() {
        step = SaveStep.success;
        savedArticleId = article.id;
      });
    } catch (e) {
      setState(() {
        step = SaveStep.error;
        if (e is WallabagError) {
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
        title: const Text('Save article'),
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
      Text(
        widget.url.toString(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 16.0),
      const CircularProgressIndicator.adaptive(),
    ];
  }

  List<Widget> _buildSuccessWidgets() {
    return [
      Text(
        'Article saved!',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 16.0),
      const Icon(Icons.check_circle_outline, size: 40),
      const SizedBox(height: 16.0),
      // TODO a preview card would be waaaay nicer
      ElevatedButton(
        onPressed: () => context.replace('/?articleId=$savedArticleId'),
        child: const Text('View article'),
      ),
    ];
  }

  List<Widget> _buildErrorWidgets() {
    return [
      Text(
        errorMessage!,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 16.0),
      const Icon(Icons.error_outline, size: 40),
    ];
  }
}

enum SaveStep {
  pending,
  success,
  error,
}
