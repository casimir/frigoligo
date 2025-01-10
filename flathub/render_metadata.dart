import 'libtool/renderer.dart';
import 'libtool/versions.dart';

void main(List<String> args) {
  final versions = Versions();
  if (args.contains('--current')) {
    versions.updateAppVersion();
  }
  versions.save();

  Renderer(versions)
    ..process()
    ..write();
}
