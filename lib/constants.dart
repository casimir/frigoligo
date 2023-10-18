import 'dart:io' show Platform;

import 'package:flutter/material.dart';

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

final Icon shareIcon = Platform.isIOS || Platform.isMacOS
    ? const Icon(Icons.ios_share)
    : const Icon(Icons.share);

const int autoSyncThrottleSeconds = 15 * 60;
const int logCountResetThreshold = 1000;

final isMobilePlatform = Platform.isAndroid || Platform.isIOS;
final appBadgeSupported = isMobilePlatform || Platform.isMacOS;
const appGroupId = 'group.net.casimir-lab.frigoligo';

const narrowScreenBreakpoint = 600.0;
const listingHeight = 130.0;
const idealListingWidth = 333.3;
