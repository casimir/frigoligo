import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/wallabag/credentials.dart';
import 'package:frigoligo/wallabag/wallabag.dart';
import 'package:http/http.dart' as http;

// this is obviously not versioned
import 'test_credentials.local.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: HomePage())));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool importLaunched = false;
  int? _urlCount;
  double? _progress;
  String? _progressMessage;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: importLaunched
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Uploading $_urlCount urls',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(value: _progress),
                    const SizedBox(height: 10),
                    if (_progressMessage != null) Text(_progressMessage!),
                  ],
                ),
              )
            : Center(
                child: ElevatedButton(
                  onPressed: lauchImport,
                  child: const Text('Launch import'),
                ),
              ),
      );

  lauchImport() async {
    importLaunched = true;
    final urls = await extractUrls();
    setState(() => _urlCount = urls.length);

    final wallabag = await WallabagClient.build(
      credentials: Credentials(
        TestCredentials.server,
        TestCredentials.clientId,
        TestCredentials.clientSecret,
      ),
      autoSyncCredentials: false,
    )
      ..fetchToken(TestCredentials.user, TestCredentials.password);
    for (final url in urls) {
      final (tags, archive, starred) = generateEntryState(url.toString());
      try {
        await wallabag.createEntry(
          url.toString(),
          tags: tags,
          archive: archive,
          starred: starred,
        );
      } catch (e) {
        // ignore: avoid_print
        print('Error while creating $url: $e');
      }
      setState(() {
        _progressMessage = url.toString();
        _progress = urls.indexOf(url) / urls.length;
      });
    }
  }
}

Future<List<Uri>> extractUrls() async {
  final datasetUri = Uri.parse(
      'https://raw.githubusercontent.com/awesome-selfhosted/awesome-selfhosted/master/README.md');
  final response = await http.get(datasetUri);
  final regex = RegExp(r'\[.+\]\((http[s]?:\/\/[^)]+)\)');
  return regex
      .allMatches(response.body)
      .map((match) => Uri.tryParse(match.group(1)!))
      .whereType<Uri>()
      .toList();
}

(List<String>, bool, bool) generateEntryState(String url) {
  var tags = ['automatic'];
  if (url.contains('/README')) tags.add('readme');
  if (url.contains('.app')) tags.add('app');
  if (url.contains('https://github.com/')) tags.add('github-repo');
  if (url.contains('matrix.org')) tags.add('matrix');
  if (url.contains('mail')) tags.add('email');
  if (url.contains('bb')) tags.add('forum');
  if (url.contains('web')) tags.add('web');
  if (url.contains('open')) tags.add('open-source');
  if (url.contains('licenses')) tags.add('license');
  if (url.contains('/LICENCE')) tags.add('license');

  final archive = Random().nextInt(5) != 0; // 80%
  final starred = Random().nextInt(10) == 0; // 10%
  return (tags, archive, starred);
}
