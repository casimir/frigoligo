import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class SharingService {
  SharingService();

  Future<void> shareAsFile(
    String filename,
    Uint8List data, {
    String mimeType = 'text/plain',
    Rect? sharePositionOrigin,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(data, mimeType: mimeType)],
        subject: filename,
        sharePositionOrigin: sharePositionOrigin,
        fileNameOverrides: [filename],
      ),
    );
  }

  Future<void> shareAsTextFile(
    String filename,
    String text, {
    Rect? sharePositionOrigin,
  }) => shareAsFile(
    filename,
    utf8.encode(text),
    mimeType: 'text/plain',
    sharePositionOrigin: sharePositionOrigin,
  );
}
