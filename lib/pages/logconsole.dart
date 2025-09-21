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
import '../data/services/local/storage/storage_service.dart';
import '../providers/logconsole.dart';
import '../widgets/async/list.dart';

class LogConsolePage extends ConsumerStatefulWidget {
  const LogConsolePage({super.key});

  @override
  ConsumerState<LogConsolePage> createState() => _LogConsolePageState();
}

class _LogConsolePageState extends ConsumerState<LogConsolePage> {
  final GlobalKey _shareButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ref.watch(logConsoleProvider);

    final colorScheme = Theme.of(context).colorScheme;

    final LocalStorageService storageService = dependencies.get();
    final logs = storageService.db.appLogsDao;
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
            onPressed: () => logs.clear(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacingInGroup),
        child: Material(
          child: AListView.builder(
            itemCount: logs.getLineCount(),
            itemBuilder: (context, index) async {
              final record = (await logs.index(index))!;
              var message = '${record.loggerName}: ${record.message}';
              if (record.error != null) {
                message += ' (${record.error})';
              }
              return Container(
                color:
                    index.isEven && context.mounted
                        ? colorScheme.surfaceContainer
                        : colorScheme.surfaceContainerLowest,
                child: Text(
                  message,
                  style: TextStyle(
                    color: _levelColor(record.level, colorScheme),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool?> _askForExportType() async {
    final LocalStorageService storageService = dependencies.get();
    final logs = storageService.db.appLogsDao;
    final currentRunLineCount = await logs.getCurrentRunLineCount();

    if (currentRunLineCount == 0) {
      return false;
    }

    final lineCount = await logs.getLineCount();

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

Color? _levelColor(String level, ColorScheme colorScheme) => switch (level) {
  'INFO' => colorScheme.onSurfaceVariant,
  'WARNING' => colorScheme.onSurface,
  'SEVERE' => colorScheme.error,
  _ => null,
};
