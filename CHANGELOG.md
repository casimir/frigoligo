<a name="v1.2.0"></a>
# [v1.2.0 (v1.2.0)](https://github.com/casimir/frigoligo/releases/tag/v1.2.0) - 30 Jul 2024

## What's Changed
### Features
* Allow connection to the server with a self-signed certificate by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/230
### Bug Fixes
* Fix wallabag refresh token update by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/226
* Fix typo in language label (DE) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/234
### Miscellaneous
* Change wallabag client architecture by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/224
* Rework session handling and providers architecture by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/225
* Add early support for freon by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/227
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/222
* New locales (zh-Hant & ru) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/228
* Update dependency flutter_widget_from_html_core to ^0.15.0 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/216
* Update dependency fastlane to v2.222.0 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/231
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/229


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.1.1...v1.2.0

[Changes][v1.2.0]


<a name="v1.1.1"></a>
# [v1.1.1](https://github.com/casimir/frigoligo/releases/tag/v1.1.1) - 27 Jun 2024

## What's Changed
### Bug Fixes
* Can't open links inside article on Android by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/218
### Miscellaneous
* Use universal_platform to simplify the web experimentation by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/215
* Update dependency fastlane to v2.221.1 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/219
* Change for a more explicit short description by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/220
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/213


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.1.0...v1.1.1

[Changes][v1.1.1]


<a name="v1.1.0"></a>
# [v1.1.0](https://github.com/casimir/frigoligo/releases/tag/v1.1.0) - 02 Jun 2024

A new button to save a link from inside the app, 3 new languages and also lot of bugfixes, especially regarding synchronization and navigation.

## What's Changed
### Features
* Change local data location by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/196
* Add a button to save a link from the listing screen by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/198
* Refactor routing logic for the article view by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/207
* Add 3 languages in settings: gl, pt_BR, zh by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/210
### Bug Fixes
* Fix DB initialization on some android devices by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/199
* Upgrade app_links & fix android SEND intent handling by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/200
* Avoid blocking the syncer with a 404 error on article deletion by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/208
* Fix actions not syncing in some cases by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/209
### Miscellaneous
* A few adjustments after IzzyOnDroid inclusion by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/191
* Finalize riverpod migration by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/202
* Upgrade and organize deps by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/203
* Update dependency go_router to v14 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/176
* Migrate to the new (gradle) android architecture by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/204
* Add a smoke test for android too by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/206
* Update dependency package_info_plus to v8 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/166
* Update dependency share_plus to v9 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/167
* Consolidate fastlane metadata by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/192
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/186
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/211


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.10...v1.1.0

[Changes][v1.1.0]


<a name="v1.0.10"></a>
# [v1.0.10](https://github.com/casimir/frigoligo/releases/tag/v1.0.10) - 14 May 2024

## What's Changed
### Miscellaneous
* Release ABI specific APKs by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/187
* Prevent error after fdroid signingConfig stripping by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/190
* Use a lock file to have isar reproducible builds by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/189


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.9...v1.0.10

[Changes][v1.0.10]


<a name="v1.0.9"></a>
# [v1.0.9](https://github.com/casimir/frigoligo/releases/tag/v1.0.9) - 06 May 2024

Fix apk build for releases.

## What's Changed
### Miscellaneous
* Fix pub-cache path when building isar by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/183


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.8...v1.0.9

[Changes][v1.0.9]


<a name="v1.0.8"></a>
# [v1.0.8](https://github.com/casimir/frigoligo/releases/tag/v1.0.8) - 06 May 2024

Update most of the dependencies so most iOS native libs have a privacy manifest.

## What's Changed
### Miscellaneous
* Update isar to 3.1.7 by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/181
* Bump flutter dependencies by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/182


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.7...v1.0.8

[Changes][v1.0.8]


<a name="v1.0.7"></a>
# [v1.0.7](https://github.com/casimir/frigoligo/releases/tag/v1.0.7) - 06 May 2024

## What's Changed
### Miscellaneous
* Rebuild isar libs for the apk to allow reproducible builds by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/180


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.6...v1.0.7

[Changes][v1.0.7]


<a name="v1.0.6"></a>
# [v1.0.6](https://github.com/casimir/frigoligo/releases/tag/v1.0.6) - 05 May 2024

The reading fonts are now bundled into the application. It makes it a few MB bigger but it is only a one time download and never need an internet connection for that later.
Also lots of ops thing related to metadata management and stores deployment. 

## What's Changed
### Features
* Bundle the reading fonts by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/172
### Miscellaneous
* Update dependency gradle to v7.6.4 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/45
* Rework fastlane metadata for android by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/173
* Version the feature graphic for F-Droid by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/174
* Update dependency fastlane to v2.220.0 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/158
* Pin flutter version by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/175
* Pin flutter version by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/177
* Build third party binaries from sources by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/178


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.5...v1.0.6

[Changes][v1.0.6]


<a name="v1.0.5"></a>
# [v1.0.5](https://github.com/casimir/frigoligo/releases/tag/v1.0.5) - 28 Apr 2024

Fix version numbers and code in all artifacts.

It was wrongly tagged `1.0.2` in the last release.

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.4...v1.0.5

[Changes][v1.0.5]


<a name="v1.0.4"></a>
# [v1.0.4 - THIS IS BROKEN USE LATER VERSION](https://github.com/casimir/frigoligo/releases/tag/v1.0.4) - 28 Apr 2024

Fix version numbers and code in all artifacts.

It was wrongly tagged `1.0.2` in the last release.

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.3...v1.0.4

[Changes][v1.0.4]


<a name="v1.0.3"></a>
# [v1.0.3 - THIS IS BROKEN USE LATER VERSION](https://github.com/casimir/frigoligo/releases/tag/v1.0.3) - 28 Apr 2024

The apk provided in the release will now be signed so its source and integrity can be verified.

## What's Changed

### Miscellaneous
* Sign the apk provided in the release by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/169


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.2...v1.0.3

[Changes][v1.0.3]


<a name="v1.0.2"></a>
# [v1.0.2](https://github.com/casimir/frigoligo/releases/tag/v1.0.2) - 28 Apr 2024

Another maintenance release with store metadata fixes.

## What's Changed
### Miscellaneous
* Add an en-US alias for fdroid by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/168


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.1...v1.0.2

[Changes][v1.0.2]


<a name="v1.0.1"></a>
# [v1.0.1](https://github.com/casimir/frigoligo/releases/tag/v1.0.1) - 27 Apr 2024

Just a few changes and tweaks for stores metadata.

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v1.0.0...v1.0.1

[Changes][v1.0.1]


<a name="v1.0.0"></a>
# [v1.0.0](https://github.com/casimir/frigoligo/releases/tag/v1.0.0) - 17 Apr 2024

This is the first version that will be in the stores! 🎉 

## What's Changed
### Features
* Better login flow by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/160
* Postpone the notification permission prompt as much as possible by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/162
* Listing screen tweaks by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/165
### Miscellaneous
* Setup fastlane config and metadata files by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/154
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/155
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/156
* Migrate current article provider to riverpod by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/163
* Riverpod debug logs by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/164
* Automatic App Store metadata by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/157


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.8.1...v1.0.0

[Changes][v1.0.0]


<a name="v0.8.1"></a>
# [v0.8.1](https://github.com/casimir/frigoligo/releases/tag/v0.8.1) - 22 Mar 2024

Rework of the settings screen plus a few general bugfixes.

## What's Changed
### Features
* Add a deeplink action to open the log console by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/145
* Clear pending actions when clearing local data by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/147
* Localization settings enhancements by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/149
* Rework the settings screen by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/150
* Keep settings sections readable on Android by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/152
### Miscellaneous
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/143
* Move settings backend usages from provider to riverpod by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/146
* Upgrade a few dependencies by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/151
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/153


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.8.0...v0.8.1

[Changes][v0.8.1]


<a name="v0.8.0"></a>
# [0.8.0 (v0.8.0)](https://github.com/casimir/frigoligo/releases/tag/v0.8.0) - 19 Mar 2024

Most likely the last dev version, this release contains the last features planned in the 1.0 milestone. :tada:

## What's Changed
### Features
* Enhance article reading UI by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/131
* Better scroll position management by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/136
* Add a font selector to the reading settings screen by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/139
* Persist pending remote sync actions until there are sent to the server by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/142
### Miscellaneous
* Bump everything (flutter, deps, pods, app version) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/132
* Upgrade flutter dependencies by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/140
* Use an external package for design primitives by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/141
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/137


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.7.2...v0.8.0

[Changes][v0.8.0]


<a name="v0.7.2"></a>
# [v0.7.2](https://github.com/casimir/frigoligo/releases/tag/v0.7.2) - 19 Jan 2024

## What's Changed

A small maintenance release to fix iOS artifact metadata and upload on TestFlight.

### Miscellaneous
* Fix minimum iOS version by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/128


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.7.1...v0.7.2

[Changes][v0.7.2]


<a name="v0.7.1"></a>
# [0.7.1 (v0.7.1)](https://github.com/casimir/frigoligo/releases/tag/v0.7.1) - 18 Jan 2024

Just a few adjustments in the German translation.

## What's Changed
### Miscellaneous
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/126


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.7.0...v0.7.1

[Changes][v0.7.1]


<a name="v0.7.0"></a>
# [0.7.0 (v0.7.0)](https://github.com/casimir/frigoligo/releases/tag/v0.7.0) - 10 Jan 2024

## What's Changed
This release adds two big features: background syncing and the possiblity to choose the language of the application.

### Features
* Background server syncing by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/117
* Disable login button until checks are passed by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/118
* Allow to choose application language by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/119
* In dynamic layout mode, open the drawer on start by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/121
### Miscellaneous
* Build the macOS version on XcodeCloud by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/90
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/113
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/120
* Translate more strings by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/122
* Translations update from Hosted Weblate by [@weblate](https://github.com/weblate) in https://github.com/casimir/frigoligo/pull/123

## New Contributors
* [@weblate](https://github.com/weblate) made their first contribution in https://github.com/casimir/frigoligo/pull/113
* [@jrabensc](https://github.com/jrabensc) provided the german translation

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.6.4...v0.7.0

[Changes][v0.7.0]


<a name="v0.6.4"></a>
# [v0.6.4](https://github.com/casimir/frigoligo/releases/tag/v0.6.4) - 03 Jan 2024

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Add a localization infrastructure by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/112
* Refresh workflow for invalid sessions by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/114
### Bug Fixes
* Refresh tag list when clearing filter by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/115


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.6.3...v0.6.4

[Changes][v0.6.4]


<a name="v0.6.3"></a>
# [0.6.3 (v0.6.3)](https://github.com/casimir/frigoligo/releases/tag/v0.6.3) - 26 Dec 2023

Bugfix release mainly for the tags selector issues in dark mode.

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Bug Fixes
* New simpler tags selector dialog by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/107
### Miscellaneous
* Adaptive layout management by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/108
* Encapsulate dimension constants as much as possible by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/109
* Upgrade packages and build dependencies by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/110


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.6.2...v0.6.3

[Changes][v0.6.3]


<a name="v0.6.2"></a>
# [0.6.2 (v0.6.2)](https://github.com/casimir/frigoligo/releases/tag/v0.6.2) - 20 Nov 2023

This is a maintenance release to fix Windows builds and upgrade a few building tools.

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Miscellaneous
* Upgrade dart, cocoapods and flutter deps by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/98
* Update windows build directory by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/99


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.6.1...v0.6.2

[Changes][v0.6.2]


<a name="v0.6.1"></a>
# [0.6.1 (v0.6.1)](https://github.com/casimir/frigoligo/releases/tag/v0.6.1) - 18 Nov 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Enhance server validation and configuration logic by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/89
* Redesign articles listing and filters by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/93
### Bug Fixes
* Change how iOS share extension attachments are handled by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/95


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.6.0...v0.6.1

[Changes][v0.6.1]


<a name="v0.6.0"></a>
# [0.6.0 (v0.6.0)](https://github.com/casimir/frigoligo/releases/tag/v0.6.0) - 03 Nov 2023

Another big one! The highlights are a completly new synchronization backend and a basic support for tags.

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Pull to refresh for article listing by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/84
* Centralize syncing actions into a single service by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/86
* Allow to change article attributes from the listing view by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/87
* Tags support by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/81
### Miscellaneous
* Update changelog for "v0.5.1" by [@github-actions](https://github.com/github-actions) in https://github.com/casimir/frigoligo/pull/75
* Upgrade flutter packages by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/80
* Upgrade flutter_lints and correct a few warnings by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/85
* Update dependency go_router to v12 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/83


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.5.1...v0.6.0

[Changes][v0.6.0]


<a name="v0.5.1"></a>
# [0.5.1 (v0.5.1)](https://github.com/casimir/frigoligo/releases/tag/v0.5.1) - 28 Sep 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Allow to add a tag when saving articles by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/73
* Add an animation when the save is complete in iOS share sheet by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/74
### Miscellaneous
* Update changelog for "v0.5.0" by [@github-actions](https://github.com/github-actions) in https://github.com/casimir/frigoligo/pull/71
* Update dependency go_router to v11 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/72
* Update actions/checkout action to v4 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/68


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.5.0...v0.5.1

[Changes][v0.5.1]


<a name="v0.5.0"></a>
# [0.5.0 (v0.5.0)](https://github.com/casimir/frigoligo/releases/tag/v0.5.0) - 21 Sep 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Rework page routes navigation logic by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/60
* Add a few deeplinks by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/61
* Rework how the article page is loaded by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/66
* Flexible interface by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/25
* Native integration for URL shares by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/67
* Add hints for password managers for login fields by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/69
### Miscellaneous
* Bulk upgrade flutter dependencies by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/62


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.4.1...v0.5.0

[Changes][v0.5.0]


<a name="v0.4.1"></a>
# [v0.4.1](https://github.com/casimir/frigoligo/releases/tag/v0.4.1) - 14 Aug 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Miscellaneous
* On-demand builds for pull requests by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/55
* Smoke tests by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/57
* Allow to sign debug version alongside release version for android by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/58


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.4.0...v0.4.1

[Changes][v0.4.1]


<a name="v0.4.0"></a>
# [0.4.0 (v0.4.0)](https://github.com/casimir/frigoligo/releases/tag/v0.4.0) - 08 Aug 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Add a button to clear the logs by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/36
* Display unkown error while checking the server in the login screen by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/37
* Add a proper settings menu by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/35
* Allow to select (and copy) article content by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/41
* Add an optional unread app badge for iOS, macOS and some Android versions by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/42
* Add a button to open the log console from the login page after an error by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/43
* A few enhancements to the Session Details screen  by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/51
### Bug Fixes
* Enforce the INTERNET permission on all Android builds by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/38
* Handle server urls with a base path prefix by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/39
### Miscellaneous
* Update dependency com.android.tools.build:gradle to v7.4.2 by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/44
* Add a GHA to upload builds to playstore beta (similar to xcode cloud) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/48
* Add a privacy policy by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/50


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.3.2...v0.4.0

[Changes][v0.4.0]


<a name="v0.3.2"></a>
# [0.3.2 (v0.3.2)](https://github.com/casimir/frigoligo/releases/tag/v0.3.2) - 04 Aug 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* Add of few dialog windows here and there by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/24
* Handle articles without content by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/30
### Miscellaneous
* Release artifacts enhancements by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/27
* Configure Renovate by [@renovate](https://github.com/renovate) in https://github.com/casimir/frigoligo/pull/28
* Use different database names for release and debug builds by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/31
* Log uncatched exceptions by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/32

## New Contributors
* [@github-actions](https://github.com/github-actions) made their first contribution in https://github.com/casimir/frigoligo/pull/23
* [@renovate](https://github.com/renovate) made their first contribution in https://github.com/casimir/frigoligo/pull/28

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.3.1...v0.3.2

[Changes][v0.3.2]


<a name="v0.3.1"></a>
# [0.3.1 (v0.3.1)](https://github.com/casimir/frigoligo/releases/tag/v0.3.1) - 02 Aug 2023

<!-- Release notes generated using configuration in .github/release.yml at main -->

## What's Changed
### Features
* allow to access and share logs from the app by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/19
### Bug Fixes
* Better handling of exceptions while syncing by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/18
* better error handling for json deserialization by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/20
* mark Entry hashed url fields as nullable by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/21
### Miscellaneous
* add artifact upload to releases by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/22


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.3.0...v0.3.1

[Changes][v0.3.1]


<a name="v0.3.0"></a>
# [0.3.0 (v0.3.0)](https://github.com/casimir/frigoligo/releases/tag/v0.3.0) - 27 Jul 2023

## What's Changed
* start an incremental sync on launch (every 15 min at most) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/6
* Restore app state after OS kill by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/7
* fix login form display with native keyboard (and small screens) by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/8
* simplify auto-sync and make it more reliable by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/9
* allow flutter to manage its scrolling position to to avoid weird jumps by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/10


**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.2.0...v0.3.0

[Changes][v0.3.0]


<a name="v0.2.0"></a>
# [0.2.0 (v0.2.0)](https://github.com/casimir/frigoligo/releases/tag/v0.2.0) - 25 Jul 2023

## What's Changed
* rework the login page for a better UX by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/1
* restore scroll position when coming back to an article by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/2
* force a scrollbar on mobile for the article page by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/3
* Design tweaks by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/4
* handle server-side deletions by [@casimir](https://github.com/casimir) in https://github.com/casimir/frigoligo/pull/5

## New Contributors
* [@casimir](https://github.com/casimir) made their first contribution in https://github.com/casimir/frigoligo/pull/1

**Full Changelog**: https://github.com/casimir/frigoligo/compare/v0.1.0...v0.2.0

[Changes][v0.2.0]


<a name="v0.1.0"></a>
# [0.1.0 (v0.1.0)](https://github.com/casimir/frigoligo/releases/tag/v0.1.0) - 25 Jul 2023

Let's begin! This is the very first release.

- article persistence
- api pagination
- article list filtering
- smart full sync (with since)
- refresh progress indicator
- auto refresh of article view
- split views on wide screens (manual switch?)
- check FTUE (/!\ first sync) and reset workflow
- set up logos and launch screen
- Add an about section with the version and licenses and stuff...
- server selection

[Changes][v0.1.0]


[v1.2.0]: https://github.com/casimir/frigoligo/compare/v1.1.1...v1.2.0
[v1.1.1]: https://github.com/casimir/frigoligo/compare/v1.1.0...v1.1.1
[v1.1.0]: https://github.com/casimir/frigoligo/compare/v1.0.10...v1.1.0
[v1.0.10]: https://github.com/casimir/frigoligo/compare/v1.0.9...v1.0.10
[v1.0.9]: https://github.com/casimir/frigoligo/compare/v1.0.8...v1.0.9
[v1.0.8]: https://github.com/casimir/frigoligo/compare/v1.0.7...v1.0.8
[v1.0.7]: https://github.com/casimir/frigoligo/compare/v1.0.6...v1.0.7
[v1.0.6]: https://github.com/casimir/frigoligo/compare/v1.0.5...v1.0.6
[v1.0.5]: https://github.com/casimir/frigoligo/compare/v1.0.4...v1.0.5
[v1.0.4]: https://github.com/casimir/frigoligo/compare/v1.0.3...v1.0.4
[v1.0.3]: https://github.com/casimir/frigoligo/compare/v1.0.2...v1.0.3
[v1.0.2]: https://github.com/casimir/frigoligo/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/casimir/frigoligo/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/casimir/frigoligo/compare/v0.8.1...v1.0.0
[v0.8.1]: https://github.com/casimir/frigoligo/compare/v0.8.0...v0.8.1
[v0.8.0]: https://github.com/casimir/frigoligo/compare/v0.7.2...v0.8.0
[v0.7.2]: https://github.com/casimir/frigoligo/compare/v0.7.1...v0.7.2
[v0.7.1]: https://github.com/casimir/frigoligo/compare/v0.7.0...v0.7.1
[v0.7.0]: https://github.com/casimir/frigoligo/compare/v0.6.4...v0.7.0
[v0.6.4]: https://github.com/casimir/frigoligo/compare/v0.6.3...v0.6.4
[v0.6.3]: https://github.com/casimir/frigoligo/compare/v0.6.2...v0.6.3
[v0.6.2]: https://github.com/casimir/frigoligo/compare/v0.6.1...v0.6.2
[v0.6.1]: https://github.com/casimir/frigoligo/compare/v0.6.0...v0.6.1
[v0.6.0]: https://github.com/casimir/frigoligo/compare/v0.5.1...v0.6.0
[v0.5.1]: https://github.com/casimir/frigoligo/compare/v0.5.0...v0.5.1
[v0.5.0]: https://github.com/casimir/frigoligo/compare/v0.4.1...v0.5.0
[v0.4.1]: https://github.com/casimir/frigoligo/compare/v0.4.0...v0.4.1
[v0.4.0]: https://github.com/casimir/frigoligo/compare/v0.3.2...v0.4.0
[v0.3.2]: https://github.com/casimir/frigoligo/compare/v0.3.1...v0.3.2
[v0.3.1]: https://github.com/casimir/frigoligo/compare/v0.3.0...v0.3.1
[v0.3.0]: https://github.com/casimir/frigoligo/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/casimir/frigoligo/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/casimir/frigoligo/tree/v0.1.0

<!-- Generated by https://github.com/rhysd/changelog-from-release v3.7.2 -->
