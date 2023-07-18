// This file is versionned as is and intended for (local) build specific values.
// To avoid some annoyance with git, you can use the following command:
//     git update-index --no-skip-worktree lib/server_presets.dart
const List<ServerPreset> serverPresets = [];

class ServerPreset {
  const ServerPreset({
    required this.label,
    required this.server,
    required this.clientId,
    required this.clientSecret,
  });

  final String label;
  final String server;
  final String? clientId;
  final String? clientSecret;
}
