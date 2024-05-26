import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../buildcontext_extension.dart';
import '../constants.dart';
import '../providers/logconsole.dart';

class LogConsolePage extends ConsumerWidget {
  const LogConsolePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final console = ref.watch(logConsoleProvider);
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
            onPressed: () => console.clear(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: console.count,
        itemBuilder: (context, index) {
          final record = console.index(index)!;
          var message = record.message;
          if (record.error != null) {
            message += ' (${record.error})';
          }
          return Container(
            color: index.isEven
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
