import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:cadanse/tokens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import '../buildcontext_extension.dart';
import '../config/dependencies.dart';
import '../config/logging.dart';
import '../data/services/local/storage/storage_service.dart';
import '../domain/models/log_entry.dart';
import '../ui/core/widgets/future_loader.dart';
import '../ui/logconsole/logconsole_viewmodel.dart';

class LogConsolePage extends ConsumerStatefulWidget {
  const LogConsolePage({super.key, required this.viewModel});

  final LogConsoleViewModel viewModel;

  @override
  ConsumerState<LogConsolePage> createState() => _LogConsolePageState();
}

class _LogConsolePageState extends ConsumerState<LogConsolePage> {
  final GlobalKey _shareButtonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            icon:
                UniversalPlatform.isWeb
                    ? Icons.download
                    : C(context).icons.share,
            onPressed: () async {
              final onlyCurrentRun = await _askForExportType();
              if (onlyCurrentRun != null) {
                await _shareExportFile(onlyCurrentRun);
              }
            },
          ),
          ActionButton(
            icon: C(context).icons.delete,
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
              prototypeItem: LogEntryMessage(
                entry: logs[0],
                colorScheme: colorScheme,
                alternativeBackground: false,
              ),
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
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _hasScrolledToBottom = true;
    });
  }

  Future<bool?> _askForExportType() async {
    final currentRunLineCount = await widget.viewModel.getCurrentRunLogCount();

    if (currentRunLineCount == 0) {
      return false;
    }

    final lineCount = await widget.viewModel.getLogCount();

    if (mounted) {
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

    return null;
  }

  Future<void> _shareExportFile(bool onlyCurrentRun) async {
    // TODO factor into a sharing service and pass by the viewmodel
    final LocalStorageService storageService = dependencies.get();
    final loglines = await storageService.db.appLogsDao.getLines(
      onlyCurrentRun,
    );
    final timestamp = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());

    final data = utf8.encode(loglines.join('\n'));
    final fname = 'frigoligo_$timestamp.log';
    final box =
        _shareButtonKey.currentContext!.findRenderObject() as RenderBox?;

    SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(data, mimeType: 'text/plain')],
        subject: fname,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        fileNameOverrides: [fname],
      ),
    );
  }
}

class LogEntryMessage extends StatelessWidget {
  const LogEntryMessage({
    super.key,
    required this.entry,
    required this.colorScheme,
    required this.alternativeBackground,
  });

  final LogEntry entry;
  final ColorScheme colorScheme;
  final bool alternativeBackground;

  Color? get _colorForLevel => switch (entry.level) {
    'INFO' => colorScheme.onSurfaceVariant,
    'WARNING' => colorScheme.onSurface,
    'SEVERE' => colorScheme.error,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    const separator = TextSpan(text: ' ');

    final backgroundColor =
        alternativeBackground
            ? colorScheme.surfaceContainerLowest
            : colorScheme.surfaceContainer;
    final textColor =
        entry.message == startingAppMessage
            ? colorScheme.primary
            : _colorForLevel;

    return Container(
      color: backgroundColor,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: entry.time.toIso8601String()),
            separator,
            TextSpan(
              text: entry.loggerName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            separator,
            TextSpan(text: entry.level),
            separator,
            TextSpan(text: entry.message),
          ],
        ),
        style: TextStyle(color: textColor),
        softWrap: false,
      ),
    );
  }
}
