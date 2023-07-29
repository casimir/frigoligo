import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frigoligo/constants.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/logconsole.dart';

class LogConsolePage extends StatelessWidget {
  const LogConsolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final console = context.watch<LogConsoleProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Console'),
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
              }),
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
