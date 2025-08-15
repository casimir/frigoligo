import 'dart:convert';

import 'package:cadanse/cadanse.dart';
import 'package:cadanse/components/widgets/adaptive/buttons.dart';
import 'package:cadanse/components/widgets/adaptive/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../db/database.dart';
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

    final logs = DB().appLogsDao;
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
            onPressed: _shareLogFile,
          ),
          ActionButton(
            icon: C(context).icons.delete,
            onPressed: () => logs.clear(),
          ),
        ],
      ),
      body: Material(
        child: AListView.builder(
          itemCount: logs.count(),
          itemBuilder: (context, index) async {
            final record = (await logs.index(index))!;
            var message = '${record.loggerName}: ${record.message}';
            if (record.error != null) {
              message += ' (${record.error})';
            }
            return Container(
              color:
                  index.isEven && context.mounted
                      ? colorScheme.surfaceContainerHighest
                      : colorScheme.surfaceContainerLowest,
              child: Text(
                message,
                style: TextStyle(color: _levelColor(record.level, colorScheme)),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _shareLogFile() async {
    final loglines = await DB().appLogsDao.currentRunLoglines();
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
