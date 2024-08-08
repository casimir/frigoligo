import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

// Themes

// Fun fact about the seed colors, both have been chosen using a color picker
// and a picture of a mountain glacier. These are real shades of blue ice.
const Color primaryLight = Color(0xFF28A1C7);
final ColorScheme schemeLight = ColorScheme.fromSeed(
  seedColor: primaryLight,
  brightness: Brightness.light,
);
const Color primaryDark = Color(0xFF0B6598);
final ColorScheme schemeDark = ColorScheme.fromSeed(
  seedColor: primaryDark,
  brightness: Brightness.dark,
);

// Adaptive icons

final Icon shareIcon = UniversalPlatform.isApple
    ? const Icon(Icons.ios_share)
    : const Icon(Icons.share);

// Filters constants

enum StateFilter { all, unread, archived }

final Map<StateFilter, Icon> stateIcons = {
  StateFilter.unread: const Icon(Icons.done),
  StateFilter.archived: const Icon(Icons.unarchive)
};

enum StarredFilter { all, starred, unstarred }

final Map<StarredFilter, Icon> starredIcons = {
  StarredFilter.starred: const Icon(Icons.star),
  StarredFilter.unstarred: const Icon(Icons.star_border),
};

// Behavior constants

const int autoSyncThrottleSeconds = 15 * 60;
const int logCountThreshold = 1000;

// Features flags and constants

const enableDebugLogs = false;
const enableSqlLogs = true;

final appBadgeSupported =
    UniversalPlatform.isMobile || UniversalPlatform.isMacOS;
const appGroupId = 'group.net.casimir-lab.frigoligo';

final periodicSyncSupported = UniversalPlatform.isDesktop; // TODO also web?
const Duration periodicSyncInterval = Duration(minutes: 15);
const Duration periodicSyncTimeout = Duration(minutes: 10);

final pullToRefreshSupported =
    UniversalPlatform.isMobile || UniversalPlatform.isMacOS;
