import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/logconsole.dart';
import '../widgets/async/list.dart';

class LogConsolePage extends ConsumerWidget {
  const LogConsolePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(logConsoleProvider);

    final console = ref.watch(logConsoleProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.L.logconsole_title),
        actions: [
          IconButton(
            icon: shareIcon,
            onPressed: () {
              console.exportCurrentRunToFile().then((filename) {
                final box = context.findRenderObject() as RenderBox?;
                Share.shareXFiles(
                  [XFile(filename)],
                  subject: filename.split(Platform.pathSeparator).last,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => ref.read(logConsoleProvider.notifier).clear(),
          ),
        ],
      ),
      body: AListView.builder(
        itemCount: console.getCount(),
        itemBuilder: (context, index) async {
          final record = (await console.index(index))!;
          var message = '${record.id} ${record.message}';
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
