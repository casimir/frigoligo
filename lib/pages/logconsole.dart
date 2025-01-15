import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final logs = DB().appLogsDao;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.logconsole_title),
        actions: [
          IconButton(
            key: _shareButtonKey,
            icon: UniversalPlatform.isWeb
                ? const Icon(Icons.download)
                : shareIcon,
            onPressed: () async {
              final loglines = await logs.currentRunLoglines();
              final data = utf8.encode(loglines.join('\n'));
              final fname = 'frigoligo_${DateTime.now().toIso8601String()}.log';
              final box = _shareButtonKey.currentContext!.findRenderObject()
                  as RenderBox?;
              Share.shareXFiles(
                [XFile.fromData(data, mimeType: 'text/plain')],
                subject: fname,
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                fileNameOverrides: [fname],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => logs.clear(),
          ),
        ],
      ),
      body: AListView.builder(
        itemCount: logs.count(),
        itemBuilder: (context, index) async {
          final record = (await logs.index(index))!;
          var message = '${record.loggerName}: ${record.message}';
          if (record.error != null) {
            message += ' (${record.error})';
          }
          return Container(
            color: index.isEven && context.mounted
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            child: Text(
              message,
              style: TextStyle(color: levelColor(record.level)),
            ),
          );
        },
      ),
    );
  }
}

Color levelColor(String level) {
// FIXME doesn't always work in dark mode
  switch (level) {
    case 'INFO':
      return Colors.black;
    case 'WARNING':
      return Colors.orange;
    case 'SEVERE':
      return Colors.red;
    default:
      return Colors.white;
  }
}
