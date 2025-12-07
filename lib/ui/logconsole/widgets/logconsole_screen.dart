import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../buildcontext_extension.dart';
import '../../../domain/models/log_entry.dart';
import '../../core/widgets/future_loader.dart';
import '../viewmodels/logconsole_viewmodel.dart';
import 'log_entry_message.dart';

class LogConsoleScreen extends StatefulWidget {
  const LogConsoleScreen({super.key, required this.viewModel});

  final LogConsoleViewModel viewModel;

  @override
  State<LogConsoleScreen> createState() => _LogConsoleScreenState();
}

class _LogConsoleScreenState extends State<LogConsoleScreen> {
  final GlobalKey _shareButtonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Rect get _sharePositionOrigin {
    final box =
        _shareButtonKey.currentContext!.findRenderObject() as RenderBox?;
    return box!.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoader(
      future: widget.viewModel.getCurrentRunLogs(),
      builder: buildLoaded,
    );
  }

  Widget buildLoaded(BuildContext context, List<LogEntry> logs) {
    if (!_hasScrolledToBottom) {
      _scheduleScrollToBottom();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveScaffold(
      barData: AdaptiveBarData(
        title: Text(context.L.logconsole_title),
        actions: [
          ActionButton(
            key: _shareButtonKey,
            icon: kIsWeb ? Icons.download : Icons.adaptive.share,
            tooltip: context.L.logconsole_export_title,
            onPressed: () async {
              final onlyCurrentRun = await _askForExportType();
              if (onlyCurrentRun != null) {
                await widget.viewModel.shareLogs(
                  onlyCurrentRun,
                  _sharePositionOrigin,
                );
              }
            },
          ),
          ActionButton(
            icon: C(context).icons.delete,
            tooltip: context.L.logconsole_clear_logs,
            onPressed: () async {
              await widget.viewModel.clearLogs();
              // this screen is useless without data, let's go back
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacingInGroup),
        child: Material(
          child: SelectionArea(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: logs.length,
              prototypeItem: logs.isNotEmpty
                  ? LogEntryMessage(
                      entry: logs[0],
                      colorScheme: colorScheme,
                      alternativeBackground: false,
                    )
                  : null,
              itemBuilder: (context, index) {
                return LogEntryMessage(
                  entry: logs[index],
                  colorScheme: colorScheme,
                  alternativeBackground: index.isOdd,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _scheduleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        _hasScrolledToBottom = true;
      }
    });
  }

  Future<bool?> _askForExportType() async {
    final currentRunLineCount = await widget.viewModel.getCurrentRunLogCount();

    if (currentRunLineCount == 0) {
      return false;
    }

    final lineCount = await widget.viewModel.getLogCount();

    if (!mounted) {
      return null;
    }

    return await showConfirmationDialog(
      context: context,
      title: context.L.logconsole_export_title,
      actions: [
        AlertDialogAction(
          key: true,
          label: context.L.logconsole_export_current_session(
            currentRunLineCount,
          ),
        ),
        AlertDialogAction(
          key: false,
          label: context.L.logconsole_export_all_logs(lineCount),
          isDefaultAction: false,
        ),
      ],
    );
  }
}
