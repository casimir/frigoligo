# Changelog

All notable changes to this project will be documented in this file.

See [changelogs](https://github.com/casimir/frigoligo/tree/main/fastlane/metadata/android/en-US/changelogs) for a more high level list of changes.

## [unreleased]


### 🚀 Features

- *(reading)* Rework the arrangement of the toolbars ([#338](https://github.com/casimir/frigoligo/pull/338)) ([df32078](https://github.com/casimir/frigoligo/commit/df32078cc20021d8e9f3cd48e9a0ae0d2d8d06cd))
- *(iOS)* Use native-like modal sheet for article details ([27929d1](https://github.com/casimir/frigoligo/commit/27929d128fc2310e826d8ea92173f5ae13ac6182))
- *(dev)* Allow to deploy the web app in profile mode by hand ([ed2783c](https://github.com/casimir/frigoligo/commit/ed2783c0b899d241d8f240681a2d6a9bdd8394f6))
- *(i18n)* Add ar in settings + display languages in the device locale ([4c7a4fd](https://github.com/casimir/frigoligo/commit/4c7a4fd747ce3015051a342e4b39c9ed045d7d46))
- Support more elements type when rendering web content natively ([11389e3](https://github.com/casimir/frigoligo/commit/11389e33d6daab383740da129577a7debb8c88e4))
- *(ios/logconsole)* Use Cupertino widgets for the page structure ([f8276e8](https://github.com/casimir/frigoligo/commit/f8276e8ce5501d338652ccbd2daaeb3eb709de93))
- *(logconsole)* Allow to choose what to export when sharing as file ([df910df](https://github.com/casimir/frigoligo/commit/df910df620c3b7364511486fbb746c6f7aa2ce2b))
- Update app icons and logos ([4658d6b](https://github.com/casimir/frigoligo/commit/4658d6bc8b9bfa08c6821d7b6270fb79abbecccc))
- *(data/services/platform)* Add an URL launcher service ([#417](https://github.com/casimir/frigoligo/pull/417)) ([3953ab1](https://github.com/casimir/frigoligo/commit/3953ab1ac5a2b59a3ce17addb76d81725cab3e0b))
- *(ui)* Add shared ui/core infrastructure layer ([#421](https://github.com/casimir/frigoligo/pull/421)) ([558a1a0](https://github.com/casimir/frigoligo/commit/558a1a0bedf44ace321c5fe6e99f65e630a555a2))

### 🐛 Bug Fixes

- Bump cadanse to get the fix for the navbar issue ([ac8bb6e](https://github.com/casimir/frigoligo/commit/ac8bb6e78674146fb5cf09ddcfdd7015b61f384a))
- Prevent a race condition on listing initialization ([2176265](https://github.com/casimir/frigoligo/commit/2176265301fa24e972871c5df9bcf3c68e393a89))
- Bump cadanse to get the fix for the navbar issue (bis) ([41fc6ce](https://github.com/casimir/frigoligo/commit/41fc6ce48b5b0753c2adea41513a80e6d24819a4))
- *(iOS)* Remove translucent navigation bar when saving an article ([dad58a1](https://github.com/casimir/frigoligo/commit/dad58a1d781e9273c879f64924b0719fb02b89b4))
- *(deps)* Update dependency shared_preferences to v2.5.3 ([#321](https://github.com/casimir/frigoligo/pull/321)) ([6adb005](https://github.com/casimir/frigoligo/commit/6adb0050f3c870633b5c0c8830d178b830c195e2))
- Avoid crash on web when loading the app ([344ad88](https://github.com/casimir/frigoligo/commit/344ad88848ffe062220966f57ff695d2d003a813))
- *(web)* Re-add and update missing assets ([766aa2d](https://github.com/casimir/frigoligo/commit/766aa2df374b8cec57c64c5f697121e718562e49))
- *(freon)* Migrate to a standard Bearer Token authentication ([53895fb](https://github.com/casimir/frigoligo/commit/53895fb18d5d70691ade4648fbe9eee2c0f81ca4))
- *(android)* Don't restrict JVM memory when building ([e46f096](https://github.com/casimir/frigoligo/commit/e46f096c0b71cf509b316d2723d63dbc93c453e6))
- *(android)* Allocate more memory to the JVM when building ([cbeca1c](https://github.com/casimir/frigoligo/commit/cbeca1cbf506ba30023ce9ddf7eb251d9318f2e3))
- ArticleSheet tweaks for iOS ([21b0fce](https://github.com/casimir/frigoligo/commit/21b0fcee50613ae1ddac09ec59f941a6f974e12c))
- *(dev)* Use sed linux syntax ([f67dffa](https://github.com/casimir/frigoligo/commit/f67dffaac275b58a1acb3dea8ff308d6a8122c7e))
- *(dev)* Change source maps root ([f0f93cf](https://github.com/casimir/frigoligo/commit/f0f93cf4d07c85ecbaf14c43207c5ffce478fe0f))
- *(dev)* Last attempt at source maps ([4ef6800](https://github.com/casimir/frigoligo/commit/4ef6800364c8d06a3a12dfe09ccb7eb598646a4b))
- Source maps generation just doesn't work... ([c777380](https://github.com/casimir/frigoligo/commit/c777380ecdcb7df5417f3173d8fe675d251c881f))
- *(deps)* Update dependency go_router to v15.1.3 ([#366](https://github.com/casimir/frigoligo/pull/366)) ([6a7e1bc](https://github.com/casimir/frigoligo/commit/6a7e1bcb379ec660890a2414dca3ddcd1b264f9d))
- *(ios/share)* Handle application sharing the URL in plain text ([#377](https://github.com/casimir/frigoligo/pull/377)) ([56fb7ea](https://github.com/casimir/frigoligo/commit/56fb7eac7b7ae8cbd44da7c02c134daa9057ac96))
- Allow to save URLs with a fragment part ([b87773a](https://github.com/casimir/frigoligo/commit/b87773ac968864683a1e776527c7a209a6153b96))
- *(UI)* Avoid unreadable text in dark mode for some Cupertino widgets ([4c7fbda](https://github.com/casimir/frigoligo/commit/4c7fbda77cb4c37961cbad2d17188314be334a8d))
- *(search)* Handle '.' in search terms ([ffcb017](https://github.com/casimir/frigoligo/commit/ffcb017b53e32f863f2329d79cf45a25913f270a))
- *(deps)* Update flutter packages (non-major) ([#374](https://github.com/casimir/frigoligo/pull/374)) ([6b772d5](https://github.com/casimir/frigoligo/commit/6b772d55be0834ede011c2755cda13c7e9376f52))
- *(sync/wallabag)* Refactor external deletion detection ([79f9251](https://github.com/casimir/frigoligo/commit/79f92510cc40af44da9b83fb83811700e1a56966))
- Repair the licenses page ([084753c](https://github.com/casimir/frigoligo/commit/084753c12b03a33896d75c28cfc8021591da2f26))
- *(UX)* Pop screen to the article list when changing the article state ([2e387e9](https://github.com/casimir/frigoligo/commit/2e387e901744311edfc9cd4f86e997ab89a46cc2))
- *(logconsole)* Avoid special characters in exported file name ([da3cdbd](https://github.com/casimir/frigoligo/commit/da3cdbd1c059bf760fae6f5e440f498da8465f5d))
- *(logconsole)* Fix unreadable log lines in dark mode ([bccc8a5](https://github.com/casimir/frigoligo/commit/bccc8a5d4b05be66502156b4e7707cd1726b6ec4))
- *(iOS)* Handle a casing issue in AppIcon files ([cf153b0](https://github.com/casimir/frigoligo/commit/cf153b033c6694b1ae1644d7e9b7f9aa9693f92c))
- Add a missing import ([095fb57](https://github.com/casimir/frigoligo/commit/095fb5703aeaac2a960da08cf46d9e4b55651c86))
- *(ios/share)* Prevent a crash when sharing an URL from the sheet ([0995d26](https://github.com/casimir/frigoligo/commit/0995d26b8002c3b18b92667a5378bd0c14b4d3de))
- *(codegen)* Make code generation compatible with formatting rules ([126275c](https://github.com/casimir/frigoligo/commit/126275c0d8554147f7be0e6e2596da74e67e2009))
- *(ui)* Prevent keyboard shortcuts from swallowing text input ([#422](https://github.com/casimir/frigoligo/pull/422)) ([d594a09](https://github.com/casimir/frigoligo/commit/d594a09198ca8fe26addd49c2e65b3a1db6e704f))
- Bring back the pull to refresh indicator ([3688d84](https://github.com/casimir/frigoligo/commit/3688d84e461d8dfb42a42dd724572c41d9022fde))
- *(deps)* Update dependency get_it to v9 ([#414](https://github.com/casimir/frigoligo/pull/414)) ([c541668](https://github.com/casimir/frigoligo/commit/c541668d51e88bc9f12b24c11077e0672e4c5f50))
- Bring back opening an article using a deeplink ([#424](https://github.com/casimir/frigoligo/pull/424)) ([58b0104](https://github.com/casimir/frigoligo/commit/58b010437bd916cc3596be85b987811d8b7ed6c5))
- Android build min versions ([fff78f2](https://github.com/casimir/frigoligo/commit/fff78f2c12e07896a1a56ec361adefe9727cdd5e))
- *(deps)* Update dependency go_router to v17 ([#415](https://github.com/casimir/frigoligo/pull/415)) ([462c28e](https://github.com/casimir/frigoligo/commit/462c28e0a8f55bb4a768f7e3a7665988eb18c06b))
- *(deps)* Regen podfiles ([7bdd65c](https://github.com/casimir/frigoligo/commit/7bdd65c50e0a14e59d0590de8918a75e80ca3306))

### 🚜 Refactor

- *(UI)* Replace the dynamic layout with a cleaner narrow layout ([#347](https://github.com/casimir/frigoligo/pull/347)) ([351449d](https://github.com/casimir/frigoligo/commit/351449dd0dd84b86322a2dbf1289ae858fac23a0))
- *(wallabag)* Uncouple the wallabag module from flutter ([4d67a67](https://github.com/casimir/frigoligo/commit/4d67a6769b0b2b77c89a3ff2cbc7f8e4e4f51a0f))
- Remove unused widget key ([eed4d1d](https://github.com/casimir/frigoligo/commit/eed4d1dc404f62049379e8184d995b05e11c65cf))
- *(sync)* Rework actions serialization to support code mangling ([#363](https://github.com/casimir/frigoligo/pull/363)) ([41715f6](https://github.com/casimir/frigoligo/commit/41715f6182aefb26b3b95d55c984d06a240929b9))
- *(clients)* Rewrite and reorganize existing API clients ([#376](https://github.com/casimir/frigoligo/pull/376)) ([2f9bdff](https://github.com/casimir/frigoligo/commit/2f9bdff7f69348e5219412867a8e0f8814eb471b))
- Use flutter's own adpative share icon ([434d36f](https://github.com/casimir/frigoligo/commit/434d36f2e02763624d52f2b3ac64fee3a277effa))
- Rework logging management ([#410](https://github.com/casimir/frigoligo/pull/410)) ([2eb2de5](https://github.com/casimir/frigoligo/commit/2eb2de504372acbe039c850bcc94234399470069))
- *(ui)* Introduce NavigationSplitView in preparation for the home layout rework ([#401](https://github.com/casimir/frigoligo/pull/401)) ([7169d4b](https://github.com/casimir/frigoligo/commit/7169d4bcde5f8c90e4389a8c7896f4c61982f516))
- Change generated source convention (moved into a _g/ dir) ([a0f5ddf](https://github.com/casimir/frigoligo/commit/a0f5ddf2ffffb62a4ded07c5b1fdc910b3dda756))
- *(core)* Add another async loader for AsyncValue ([f7e220e](https://github.com/casimir/frigoligo/commit/f7e220ed540f4a0f7367006cbe08448d55e48050))
- Introduce more data repositories ([#411](https://github.com/casimir/frigoligo/pull/411)) ([2f56c07](https://github.com/casimir/frigoligo/commit/2f56c071d726e54dd41cbd6585c72b31af2a2ce9))
- *(core/ui)* Consolidate "copyable text" widgets ([f8a349e](https://github.com/casimir/frigoligo/commit/f8a349e46bcaebbc4a398c823938807559b8f0ed))
- *(data)* Make a cleaner reading progress implementation ([#419](https://github.com/casimir/frigoligo/pull/419)) ([5237765](https://github.com/casimir/frigoligo/commit/5237765402deae2014111afd160de906ed2b8b1a))
- *(ui/home)* Cleaner home screen with test coverage ([#412](https://github.com/casimir/frigoligo/pull/412)) ([ad627eb](https://github.com/casimir/frigoligo/commit/ad627ebf3ed82efcf674205a9ccb9d8ea53449d6))

### 📚 Documentation

- Assume the situation about automated testing ([3f0a206](https://github.com/casimir/frigoligo/commit/3f0a206edc5175d9f66271b68081e38f22e301af))

### ⚡ Performance

- *(sync)* Avoid duplicate refresh actions on session change ([3e0ae22](https://github.com/casimir/frigoligo/commit/3e0ae22fcd2007d7057d6baf981c1ca6e1b9b5c3))

### 🧪 Testing

- *(logging)* Use a real (in memory) database for in tests ([7434744](https://github.com/casimir/frigoligo/commit/74347449727f12db8f0ec5b05eeb0527e1046b21))
- Avoid using flutter_test when not needed ([c244f0a](https://github.com/casimir/frigoligo/commit/c244f0a37ff2a3f4936281f8f0c57f738ed559d3))

### 🌐 Translations

- Update translations: Estonian
 ([a4ab6d9](https://github.com/casimir/frigoligo/commit/a4ab6d9cf3d0191257655902918d8520c9578ee9))
- Update translations: Dutch
 ([663d720](https://github.com/casimir/frigoligo/commit/663d720e7d7846b55cbec6bf6799f82e968f8929))
- Update translations: French
 ([738b5f7](https://github.com/casimir/frigoligo/commit/738b5f7798fd9448fc45a4b1fc60717b661062a6))
- Update translations: Galician
 ([cfefc66](https://github.com/casimir/frigoligo/commit/cfefc66bd95c88a35909540325a4f3225278b6dc))
- Update translations: German
 ([bd253d9](https://github.com/casimir/frigoligo/commit/bd253d93ae4365f09373e9b48a8284efe2c64d79))
- Update translations: Italian
 ([f1065c3](https://github.com/casimir/frigoligo/commit/f1065c3b5abf6961bbd0d092dbb04b1a2d66bd69))
- Update translations: Portuguese (Portugal)
 ([ffcc491](https://github.com/casimir/frigoligo/commit/ffcc491446c285e83d676d9702aa87444b2d34d4))
- Update translations: Portuguese (Brazil)
 ([94108a5](https://github.com/casimir/frigoligo/commit/94108a5cbee2ac6696d56d242f5abd9bd21f4187))
- Update translations: Russian
 ([d253d8d](https://github.com/casimir/frigoligo/commit/d253d8d6b34772d22f6bb23abb77027291b9dfa0))
- Update translations: Spanish
 ([dd58354](https://github.com/casimir/frigoligo/commit/dd58354c850fb7f7ca4d7903b2edc62e56ed6301))
- Update translations: Chinese (Simplified Han script)
 ([fca7a70](https://github.com/casimir/frigoligo/commit/fca7a70e4b0f924b038363ef6538cb3a38475cc8))
- Update translations: Portuguese
 ([2577b5d](https://github.com/casimir/frigoligo/commit/2577b5d9cb9d9f3ba79b2bf91836379a7d539f94))
- Update translations: Tamil
 ([f4e8982](https://github.com/casimir/frigoligo/commit/f4e89826f9069f8f19f4cc0df792e709c62ac7c0))
- Update translations: Catalan
 ([b990cde](https://github.com/casimir/frigoligo/commit/b990cde52f3c1cf935ca8b94570e63d057bb171f))
- Update translations: Arabic
 ([8677705](https://github.com/casimir/frigoligo/commit/867770534b6ea68c9b7c3b0093955aedc8d5867e))

### ⚙️ Miscellaneous Tasks

- *(fastlane)* Add missing metadata for Italian ([969597f](https://github.com/casimir/frigoligo/commit/969597fbcf41bb52bc3f3a71f6ce2df7d9b43db2))
- *(i18n)* Adjust some translations ([65654ce](https://github.com/casimir/frigoligo/commit/65654ce6d8943bcabb62e225a3f5457465516b75))
- *(i18n)* Add newly translated languages ([a176a0b](https://github.com/casimir/frigoligo/commit/a176a0be2c623d30426547e2449c626850857e7a))
- *(dev)* Upload source maps too on GH Pages ([1e5a873](https://github.com/casimir/frigoligo/commit/1e5a873538d36e718f7db6cda299229612658cb2))
- *(dev)* Also expose the source files on GH pages ([3acf4dd](https://github.com/casimir/frigoligo/commit/3acf4dd9bc7cc5fcb0eae88d0f4acb91bf7ac71b))
- *(dev)* Patch the source maps root ([9aa03e3](https://github.com/casimir/frigoligo/commit/9aa03e3e2356ae5d072a9d8e195bb1d5a8254726))
- *(i18n)* Update dependency for localized language labels ([6d7e380](https://github.com/casimir/frigoligo/commit/6d7e380c4c228d53c26f0021a7e452ed753853fd))
- Bump flutter deps ([6fcd762](https://github.com/casimir/frigoligo/commit/6fcd7622e6d750054f18dfc46e58edb2bb2d9a1f))
- Add GH issue templates ([#397](https://github.com/casimir/frigoligo/pull/397)) ([078a67c](https://github.com/casimir/frigoligo/commit/078a67c8e93304a9ac76b1baab9a507c66ce48d3))
- Remove redundant issue template entries ([0585aac](https://github.com/casimir/frigoligo/commit/0585aacfb1c3c0e53f45cbf2d9cb7f16a848b652))
- Cleanup ios assets duplicates and names ([2a403ca](https://github.com/casimir/frigoligo/commit/2a403caa59477ffd4d3aab6842832d6d8f2665e3))
- Change macos icon shape ([c32bb17](https://github.com/casimir/frigoligo/commit/c32bb17d90cb0776fb86a717c39c690f8b9dadb9))
- Generalize test runs ([ac7395b](https://github.com/casimir/frigoligo/commit/ac7395bff2134265e14c1234c48ebbac3047a17f))
- Hide generated code in GH diff interface ([bb6e2c1](https://github.com/casimir/frigoligo/commit/bb6e2c18d79f956991d907d700e0110145ba53d0))
- Setup sonarqube ([#404](https://github.com/casimir/frigoligo/pull/404)) ([010a5cb](https://github.com/casimir/frigoligo/commit/010a5cb68ae05b5b94d9ecb6fd9cac8318053ee1))
- *(analysis)* Include test/ in the sources ([ce10e1b](https://github.com/casimir/frigoligo/commit/ce10e1bf024964b66e09f10fa32b14ea1a5c4bb3))
- Backport sonarqube settings changes ([7efaf0e](https://github.com/casimir/frigoligo/commit/7efaf0ed76c46ed050365fc6c60320a91344e895))
- *(tests)* Ignore generated code when calculating coverage ([ab51417](https://github.com/casimir/frigoligo/commit/ab51417e5b25c6619cd17b23aae5eb16209f7b4d))
- Don't run sonarqube scan without the secret + avoid double linux run ([7632406](https://github.com/casimir/frigoligo/commit/76324061f507d64e8a75f2ffc989d081e9649265))
- *(flutter)* Upgrade to 3.35.7 ([819ee50](https://github.com/casimir/frigoligo/commit/819ee50caaa19ecd2fc3e022e6c494e13c6e4073))
- Reformat everything with 3.8 formatting rules ([0c56a6c](https://github.com/casimir/frigoligo/commit/0c56a6c691f68c17f7e8afae9cb12a4c6d641e7b))
- Introduce a Makefile and enforce lint in CI ([#416](https://github.com/casimir/frigoligo/pull/416)) ([1ccb0af](https://github.com/casimir/frigoligo/commit/1ccb0af7f73348e158019606df8739daf8a5e9e8))
- Batch of various small fixes ([#420](https://github.com/casimir/frigoligo/pull/420)) ([1a33e14](https://github.com/casimir/frigoligo/commit/1a33e1410fb379a6bff251365e38944d72748530))
- *(coverage)* Sonarqube doesn't follow in file instructions ([318331f](https://github.com/casimir/frigoligo/commit/318331f2ad49fb210441af8b13f799dd26c5ed10))

### I18n

- Adjust a wording ([86222a5](https://github.com/casimir/frigoligo/commit/86222a5f179fb455d7ed9086f3a7d78e7b87de8d))

### Security

- *(GHA)* Update SonarQube scan action to version 6 ([40202ae](https://github.com/casimir/frigoligo/commit/40202aecca59b7268bd235f6106b24849bede1d6))

**Full Changelog**: [v2.4.0..HEAD](https://github.com/casimir/frigoligo/compare/v2.4.0..HEAD)


## [2.4.0] - 2025-03-14


### 🚀 Features

- *(i18n)* Integrate Italian and Dutch ([9732ec0](https://github.com/casimir/frigoligo/commit/9732ec0e9997d635f96e81dd04325ecc6478f5d9))

### 🐛 Bug Fixes

- *(ci)* Update xcode cloud builds ([#335](https://github.com/casimir/frigoligo/pull/335)) ([c3f3002](https://github.com/casimir/frigoligo/commit/c3f3002da0c71a4777d70f659c0d52f518a1064f))

### 🌐 Translations

- Update translations: Galician
 ([9008784](https://github.com/casimir/frigoligo/commit/9008784e3c059aace828c27f56de25b2c5d39bb5))
- Update translations: Estonian
 ([5bca83e](https://github.com/casimir/frigoligo/commit/5bca83ef4a9816d9f530acc235c2fd5cea625cc0))
- Update translations: Dutch
 ([c2cbd18](https://github.com/casimir/frigoligo/commit/c2cbd1855388ec70681f1d03d5d7cc7aef94af7a))
- Update translations: Spanish
 ([d7e831a](https://github.com/casimir/frigoligo/commit/d7e831a3b010931b198d70ad3b9b433cf37cf7c9))
- Update translations: Italian
 ([0c67b1c](https://github.com/casimir/frigoligo/commit/0c67b1c9e6249718b4f40b70d8783a6918892aeb))
- Update translations: French
 ([7f73fde](https://github.com/casimir/frigoligo/commit/7f73fdec9a7f3c6251e94dcd2c7e1a48210ba97a))

### ⚙️ Miscellaneous Tasks

- Configure fvm ([9b81678](https://github.com/casimir/frigoligo/commit/9b81678853b33654b698f7958e86f2f862a78ef5))
- *(renovate)* More groups of dependencies ([5b89cbe](https://github.com/casimir/frigoligo/commit/5b89cbe82804cd7d145df1fb47c9948ba5052437))
- *(ci)* Pin flutter using .fvmrc instead of .flutter-version ([3955226](https://github.com/casimir/frigoligo/commit/39552268e7a516151596d45d50ff952c86cabc30))
- *(ci)* Avoid using pipe with jq ([ca31e9c](https://github.com/casimir/frigoligo/commit/ca31e9c5f6c223d60a2b019280ccef6cb9367e6a))
- *(ci)* Run command with GITHUB_OUTPUT with bash even on windows ([847b6aa](https://github.com/casimir/frigoligo/commit/847b6aab5e7709abb33dc4a73a6fd5a85a465804))
- *(flutter)* Bump to 3.27.4 ([a420b76](https://github.com/casimir/frigoligo/commit/a420b76d97d03d6db51b3f31287a45d2d3ea47b7))

**Full Changelog**: [v2.3.1..v2.4.0](https://github.com/casimir/frigoligo/compare/v2.3.1..v2.4.0)


## [2.3.1] - 2025-02-17


### 🐛 Bug Fixes

- *(iOS)* Systematically use appGroup for settings ([0105efa](https://github.com/casimir/frigoligo/commit/0105efab275ae412e7706e38f511672bc381b6ea))
- *(database)* Avoid deleting the database on launch ([ec7e34b](https://github.com/casimir/frigoligo/commit/ec7e34be9e1bc58777009e4d2014b2e82d133eb9))

### 📚 Documentation

- *(changelog)* Regen file ([a3dc724](https://github.com/casimir/frigoligo/commit/a3dc72427106bdb822f2ec41bb4628f8d9f3b1f5))

**Full Changelog**: [v2.3.0..v2.3.1](https://github.com/casimir/frigoligo/compare/v2.3.0..v2.3.1)


## [2.3.0] - 2025-02-09


### 🚀 Features

- *(web)* Allow to download log files ([919f6ab](https://github.com/casimir/frigoligo/commit/919f6ab0d3dfdf10a4fe928612a197e82a52ec4a))
- Make saving articles possible when offline ([#320](https://github.com/casimir/frigoligo/pull/320)) ([0dbf99f](https://github.com/casimir/frigoligo/commit/0dbf99ff23457ccb8bd4dd9f337b12094b2aa455))
- *(i18n)* Enable Brazilian Portuguese thanks to new translations ([e5f98c3](https://github.com/casimir/frigoligo/commit/e5f98c309a19b93d699cc2eec0ddcc09c1491739))
- *(article sheet)* Make text fields copiable ([8246974](https://github.com/casimir/frigoligo/commit/824697469c093a4d8c354915bdf3f1c5c2ef3cf2))
- *(article)* Add a button to ask the server to re-fetch the content ([afd1d25](https://github.com/casimir/frigoligo/commit/afd1d25911714a90af9c645e4b39bec4e6e0f601))

### 🐛 Bug Fixes

- Login keyboard navigation ([#314](https://github.com/casimir/frigoligo/pull/314)) ([d25a88a](https://github.com/casimir/frigoligo/commit/d25a88a7c74ba56937b4b7feb3c8291ccfd0e7c4))

### 🚜 Refactor

- *(syncer)* Aggregate actions optional result for later use ([3fd69e6](https://github.com/casimir/frigoligo/commit/3fd69e605f2eb8c9640cc5950345ef681f1c1118))
- Don't assume that loading an article is instantaneous ([25fc582](https://github.com/casimir/frigoligo/commit/25fc58274d06a542de7cb3d548da955df23113ce))
- Move fwfh specific widget in a dedicated file ([c317a00](https://github.com/casimir/frigoligo/commit/c317a00db375231162a20b566af8bed15895d941))

### 📚 Documentation

- Start the changelog for the next release + regen metainfo ([034a6f2](https://github.com/casimir/frigoligo/commit/034a6f2e351baed31332a21e9152bd432f5009ec))
- *(flathub)* Mark the app as explicitly adapted to mobile ([489cd9f](https://github.com/casimir/frigoligo/commit/489cd9fbad4951f4b11ce3f580fd7cf9e6976d90))

### 🌐 Translations

- Update translations: Portuguese (Brazil)
 ([c44bf96](https://github.com/casimir/frigoligo/commit/c44bf96753d100e6de046a0b84f77eede5fe8d5c))
- Update translations: German
 ([1187dad](https://github.com/casimir/frigoligo/commit/1187daddd23fc7f8976397bf57bf29e84774d7e9))
- Update translations: Chinese (Traditional Han script)
 ([94dde16](https://github.com/casimir/frigoligo/commit/94dde16a81b8b43473d373ff6b94a42af9e2268c))
- Update translations: Chinese (Simplified Han script)
 ([983380f](https://github.com/casimir/frigoligo/commit/983380fffc84526363086614a9c115b545fe1b19))
- Update translations: Galician
 ([a5014ac](https://github.com/casimir/frigoligo/commit/a5014ac09005dfbb142f539e685e91dcbd3bfeb9))
- Update translations: Tamil
 ([a4a9f69](https://github.com/casimir/frigoligo/commit/a4a9f6919a35d47f0862a91fa6b289b9b067bb89))
- Update translations: Estonian
 ([593a115](https://github.com/casimir/frigoligo/commit/593a11593300efd24dc5fee6a7e346486cbfbd36))
- Update translations: Spanish
 ([261b46c](https://github.com/casimir/frigoligo/commit/261b46c9c2fe39197a24ff30538b1cdb1e0868b0))
- Update translations: French
 ([797c426](https://github.com/casimir/frigoligo/commit/797c426b7317bb8c2c559792f7461e23dedf5ae8))
- Update translations: Portuguese (Portugal)
 ([a832a14](https://github.com/casimir/frigoligo/commit/a832a14a7419367a1ecaf491f7b7358061203c0f))

### ⚙️ Miscellaneous Tasks

- *(flathub)* Reverse release order ([049a835](https://github.com/casimir/frigoligo/commit/049a83530809f4fc8248cb952c29ca9a3d09f544))
- *(fastlane)* Bump copyright year ([5cad63b](https://github.com/casimir/frigoligo/commit/5cad63b195cf36f87fd4dfa92a2dd323e67b3987))
- Change how renovate groups dependencies update ([fd3f34f](https://github.com/casimir/frigoligo/commit/fd3f34fb40b4c8de1044e35719da01fe1b9b5b2b))
- Setup automated updates for other changelogs ([8284bfd](https://github.com/casimir/frigoligo/commit/8284bfd02665f88276f2db2292d42fa8bd064dea))
- Cleanup wrong file versioning and prevent it in the future ([fe94c5e](https://github.com/casimir/frigoligo/commit/fe94c5e33143617303c98de04e655a6142439c70))

**Full Changelog**: [v2.2.0..v2.3.0](https://github.com/casimir/frigoligo/compare/v2.2.0..v2.3.0)


## [2.2.0] - 2025-01-12


### 🚀 Features

- *(multiselect)* Keep selections at the top of the list ([31fb21b](https://github.com/casimir/frigoligo/commit/31fb21b4d019ce18785f35c4fb35a4a2ab945f93))
- Allow to create new tags when editing the tags of an article ([89419cf](https://github.com/casimir/frigoligo/commit/89419cfb3aef564a0b0a0d49f22749688c6916ff))
- *(sync)* Don't bother the user for network issues, the FAB is enough ([1aea3c5](https://github.com/casimir/frigoligo/commit/1aea3c5f83e0bcbecfb5d35cc7b1f4f790a7c2ad))
- *(i18n)* Add Tamil + reactivate Russian ([3ec0c5e](https://github.com/casimir/frigoligo/commit/3ec0c5ed80be6458a2989bdd5392fcbbc26c84d9))

### 🐛 Bug Fixes

- *(reading)* Make the scroll indicator start at 0% instead of 100% ([701f93b](https://github.com/casimir/frigoligo/commit/701f93be415d0bceba915f2f9935533e4c959c65))
- *(reading)* Avoid race condition when saving reading progress ([d9d312d](https://github.com/casimir/frigoligo/commit/d9d312db331b78992e0be3b21ca4a7fd9a1f3000))
- *(wasm)* Make the app work with a wasm build ([b7aaaa3](https://github.com/casimir/frigoligo/commit/b7aaaa3ff712c21ea7a7835f6456122203d9edd5))
- *(network)* Allow to use a server address in http:// ([fb3b648](https://github.com/casimir/frigoligo/commit/fb3b6487762dc8dea2019143c4701c704ae60024))
- *(reading)* Avoid duplicate loading when changing article ([f8244e1](https://github.com/casimir/frigoligo/commit/f8244e14941249af3a6c49bfa1bd746c8f81443e))
- *(UI/dynamic)* Stop reopening article list drawer every time ([2a48bdf](https://github.com/casimir/frigoligo/commit/2a48bdfc6ba724a62e8c3ec9d49f73748ffe0518))
- *(UI/dynamic)* Ensure that an article is selected when filling the DB ([e90de91](https://github.com/casimir/frigoligo/commit/e90de916aadab0f11324d4237f0815259d843646))

### 📚 Documentation

- *(reamde)* Add a link to flathub ([f32b19b](https://github.com/casimir/frigoligo/commit/f32b19bb99d571bb10be04a921f4457d28b7b372))
- Update desktop screenshot ([3db1e0f](https://github.com/casimir/frigoligo/commit/3db1e0f3f1401d93c93f954a1f8bf09affb44dbf))
- *(changelogs)* Start the changelog for the next release ([46896ae](https://github.com/casimir/frigoligo/commit/46896ae54c26cb89646eb06d7eb59a0824fa0ad1))
- Fix a typo ([c1310b9](https://github.com/casimir/frigoligo/commit/c1310b909d1149c59516fa0d6a3e78df59f6bb7c))

### 🌐 Translations

- Update translations: Galician
 ([ce1f66a](https://github.com/casimir/frigoligo/commit/ce1f66a754d8983e843644d5a12bfea6fea4388a))
- Update translations: Tamil
 ([e14da07](https://github.com/casimir/frigoligo/commit/e14da07d3a0388da2c89ae2c1057aae15732cb4d))
- Update translations: Esperanto
 ([3ed3c6f](https://github.com/casimir/frigoligo/commit/3ed3c6fe85ceb13a9c84ebeac50db89cc5ee1ca0))
- Update translations: Estonian
 ([a609057](https://github.com/casimir/frigoligo/commit/a609057e1b85444eff0cd1ee3535fde3c3660ed3))
- Update translations: Spanish
 ([6c5f6ed](https://github.com/casimir/frigoligo/commit/6c5f6ed9e4761610b68b428ffdf1f5797e27d0ee))
- Update translations: Russian
 ([6d0f6d4](https://github.com/casimir/frigoligo/commit/6d0f6d422934597c0ebd3b28a2ade3c2f990190f))
- Update translations: Chinese (Simplified Han script)
 ([2789513](https://github.com/casimir/frigoligo/commit/27895137377c4873ba954e70add0f16d30d1a25d))
- Update translations: French
 ([ae105c5](https://github.com/casimir/frigoligo/commit/ae105c54d92a51a1ffbf84bdf591fced539d637f))

### ⚙️ Miscellaneous Tasks

- Start new dev cycle ([0963ddf](https://github.com/casimir/frigoligo/commit/0963ddfd8751733ef27b0a0ad860e595af73d45d))
- Regen build_runner files ([94ab2a7](https://github.com/casimir/frigoligo/commit/94ab2a7cb782e120663bc901086860feb0c5c65d))
- *(macos)* Bump lockfile ([4f8dd2e](https://github.com/casimir/frigoligo/commit/4f8dd2e84958530ac06e7731fd3e6b6d5b4a0258))
- Remove unused ruby files ([7c06032](https://github.com/casimir/frigoligo/commit/7c0603255051c189615881fe9977f6f008d5e5f4))
- *(flathub)* Automate MetaInfo generation ([95726de](https://github.com/casimir/frigoligo/commit/95726de6cec55436363063508f5c661b67738209))
- *(flathub)* Temporary screenshot tweak ([3fcb1e9](https://github.com/casimir/frigoligo/commit/3fcb1e91cc92f706e41e4042713e6e22bbb5624a))
- *(flathub)* Add more translations and a more fitting icon ([c726e5c](https://github.com/casimir/frigoligo/commit/c726e5c0b1b13b9f8eead63afb9e006fdcaad850))
- *(tooling)* Include flathub refresh in the release script ([aca9709](https://github.com/casimir/frigoligo/commit/aca970993f8d90d6210d40030ba636cde442605f))

**Full Changelog**: [v2.1.3..v2.2.0](https://github.com/casimir/frigoligo/compare/v2.1.3..v2.2.0)


## [2.1.3] - 2024-12-15


### ⚙️ Miscellaneous Tasks

- *(flathub)* Move the metadata in the repo ([dea8f03](https://github.com/casimir/frigoligo/commit/dea8f0394836c70f4a166ee10abe682f505a2090))

**Full Changelog**: [v2.1.2..v2.1.3](https://github.com/casimir/frigoligo/compare/v2.1.2..v2.1.3)


## [2.1.2] - 2024-12-15


### ⚙️ Miscellaneous Tasks

- *(flathub)* Fix a typo in a filename ([6c0e65e](https://github.com/casimir/frigoligo/commit/6c0e65eae0db2cc6e7b556f6b41ba82d86fe1a79))

**Full Changelog**: [v2.1.1..v2.1.2](https://github.com/casimir/frigoligo/compare/v2.1.1..v2.1.2)


## [2.1.1] - 2024-12-15


### ⚙️ Miscellaneous Tasks

- Quick release to update the .desktop files ([f664b63](https://github.com/casimir/frigoligo/commit/f664b635ac8fd1587e051d25d0dc1b9bc824d269))

**Full Changelog**: [v2.1.0..v2.1.1](https://github.com/casimir/frigoligo/compare/v2.1.0..v2.1.1)


## [2.1.0] - 2024-12-15


### 🚀 Features

- *(i18n)* Reorganize languages ([4513a35](https://github.com/casimir/frigoligo/commit/4513a359a37015074ff3adc01a5a357083438b14))
- *(i18n)* Add ES translations and screenshots ([732c7a0](https://github.com/casimir/frigoligo/commit/732c7a0abca529fea97e62987d6828f2079b11c3))
- Build the app for linux arm64 ([#274](https://github.com/casimir/frigoligo/pull/274)) ([98cabe2](https://github.com/casimir/frigoligo/commit/98cabe234458021c3ed347c7c88e80dd03208f80))
- *(i18n)* Add ET translations in the settings ([9949fd9](https://github.com/casimir/frigoligo/commit/9949fd930f6cd6883f4a9c46c56b3219b2b4cbe7))
- *(reading)* Enhance text readability ([6a1139a](https://github.com/casimir/frigoligo/commit/6a1139ad90e1ba83a8858cb7b161a7b83ab63a5f))
- *(freon)* Add support in the iOS share extension ([29b38fe](https://github.com/casimir/frigoligo/commit/29b38feb82074a866d597c5b38e4ca1c606596d1))
- *(UI/UX)* Add a divider between panes on wide screens ([80e655a](https://github.com/casimir/frigoligo/commit/80e655a8cd0b9204b023e406d708328c3f93b072))
- *(UI/UX)* Declutter the search interface ([14c07db](https://github.com/casimir/frigoligo/commit/14c07db947e1dc15dcce7da31be691d73a8bd270))
- *(reading)* Add a control to toggle text justification ([22a6b11](https://github.com/casimir/frigoligo/commit/22a6b1195c1d3d82e5bbc50c51385512adc245fe))
- *(web)* Replace placeholder title ([941ed8a](https://github.com/casimir/frigoligo/commit/941ed8aea366d57dd7b565b5361f161a4cda61d9))

### 🐛 Bug Fixes

- *(web)* Change logos and icons ([b08a515](https://github.com/casimir/frigoligo/commit/b08a51577cebe3046a5773cf78b7c067b6b30828))
- *(reading)* Keep the scrollbar on the far right on large screens ([cfea627](https://github.com/casimir/frigoligo/commit/cfea627ec1e73df660bef3cfc2f6d6f534308427))
- *(UI/UX)* Put back an outline to the search field for consistency ([9c881f9](https://github.com/casimir/frigoligo/commit/9c881f91141b39d0d2fb1921421742b563483b03))
- *(UI/UX)* Remove some spacing ([9907545](https://github.com/casimir/frigoligo/commit/9907545c113ffe22e9386f1fdd7082b11e5899a9))
- *(reading)* Truncate title to avoid vertical clipping ([d37056a](https://github.com/casimir/frigoligo/commit/d37056a7d25637d7a9083b7e37a3b1bdb02c9dde))
- *(iOS)* Attach the share popover to the button that triggered it ([1b865f4](https://github.com/casimir/frigoligo/commit/1b865f4a53a31b7fd2432d564c670f285efdf1bb))
- Add a temporary workaround for l10n_esperanto ([971308f](https://github.com/casimir/frigoligo/commit/971308f03a8b5fc459bba47a7cd5e9c23f05f548))
- *(deeplinks)* Handle `/` correctly (sent startup on web) ([fbf6d02](https://github.com/casimir/frigoligo/commit/fbf6d02bff65ce5413bffb45f1532df4a15a9851))
- *(web)* Unbroke eveything by updating sqlite and forcing html renderer ([0528605](https://github.com/casimir/frigoligo/commit/052860541c0a8ca249daa0ae718a093b6e613497))
- *(reading)* Allow text selection again ([aac0a15](https://github.com/casimir/frigoligo/commit/aac0a150dbbe588f13dfa13c2bb40cc4d4a86b14))
- *(release)* Fix tag message generation ([23c2c22](https://github.com/casimir/frigoligo/commit/23c2c2227fa79df27711ea07c1dbda5e52d656a6))

### 🚜 Refactor

- *(settings)* Change how enum values are handled ([#277](https://github.com/casimir/frigoligo/pull/277)) ([2c8078a](https://github.com/casimir/frigoligo/commit/2c8078ab530732347947abe2937762ef8df5c8cb))
- *(reading settings)* Use cadanse instead of hard coded values ([1f7c5cb](https://github.com/casimir/frigoligo/commit/1f7c5cb239f6be2f6aa179013a53a918b3644ee1))
- Simplify currentArticleProvider ([78a3ac7](https://github.com/casimir/frigoligo/commit/78a3ac7697c8ff968b777f32fee37526d93b4239))
- *(deps)* Pin everything ([a84f817](https://github.com/casimir/frigoligo/commit/a84f81773b85db73a941a5dab4e1441ab2eebebc))

### 📚 Documentation

- *(readme)* Mention the web app (with a link). ([6fb3f3e](https://github.com/casimir/frigoligo/commit/6fb3f3e7eaeca1e29ee74ff03f3e1f16288e022c))
- Fix grammar errors in the readme ([#285](https://github.com/casimir/frigoligo/pull/285)) ([dca4712](https://github.com/casimir/frigoligo/commit/dca471292ea23f93794bc00b7bc659b57969edd0))
- Reduce translation minimum completeness to align with weblate ([b27b290](https://github.com/casimir/frigoligo/commit/b27b290e8b3cfdba193d1a64bdf1775ba1299ee5))
- *(changelogs)* Start the changelog for the next release ([71a3fa9](https://github.com/casimir/frigoligo/commit/71a3fa9d07189fbb135fd1c2acb84b527a793752))

### ⚡ Performance

- *(ios)* Avoid a volley of rebuilds when using the keyboard ([a7e5d49](https://github.com/casimir/frigoligo/commit/a7e5d497b9dc54282ab8e28fc8e4369dfcc2ee65))

### 🌐 Translations

- Update translations: Spanish
 ([b8d070a](https://github.com/casimir/frigoligo/commit/b8d070ad9af87025e6990836362dfae8dd1e56da))
- Update translations: Portuguese (Portugal)
 ([f5cf33c](https://github.com/casimir/frigoligo/commit/f5cf33c2a754f1d3e4550a758e42f0e74f8f3c32))
- Update translations: Portuguese (Brazil)
 ([ed9b432](https://github.com/casimir/frigoligo/commit/ed9b432d755aea88f5511bf82c4809f59a8aaf05))
- Update translations: Estonian
 ([37e755a](https://github.com/casimir/frigoligo/commit/37e755a8c48133503850a3dc115d5126f4185c5d))
- Update translations: Russian
 ([a5d7cc8](https://github.com/casimir/frigoligo/commit/a5d7cc8be7b670d41bc2bea73f25cae531ef566d))
- Update translations: Chinese (Traditional Han script)
 ([673ef3c](https://github.com/casimir/frigoligo/commit/673ef3c4cd6b1af1318a6ea9da78565023d08fdc))
- Update translations: French
 ([f6f4735](https://github.com/casimir/frigoligo/commit/f6f4735f5547ef4fb8eb9c2b13e04cc0ff02ba46))
- Update translations: Galician
 ([723e8b9](https://github.com/casimir/frigoligo/commit/723e8b94a801b5bf78f4cc000f67eda7c0a5476c))

### ⚙️ Miscellaneous Tasks

- *(release)* Prepare the new dev cycle ([8724d5d](https://github.com/casimir/frigoligo/commit/8724d5da03f7e112f80f374ec946cca7d68aea35))
- Bump version name ([9bf66d0](https://github.com/casimir/frigoligo/commit/9bf66d024802db36eecce2c430e6cecf9aa09786))
- Bump CocoaPods lockfiles ([5e44a74](https://github.com/casimir/frigoligo/commit/5e44a74bc8dcef74c0edd086e4309f44c72651d4))
- Setup automated changelog update every day ([627adcf](https://github.com/casimir/frigoligo/commit/627adcf6c661517d3f2f6e4826563b9d06450ae9))
- *(screenshots)* Add ET to the list of locales ([9cbdcc9](https://github.com/casimir/frigoligo/commit/9cbdcc95dc8f34f02e781658c31e6e30c2c83816))
- Update flutter and flutter dependencies ([bd44dfc](https://github.com/casimir/frigoligo/commit/bd44dfcddfa165e6ab7aa22f7cb7cf7d75f41dc6))
- Group renovate updates ([a2d2d32](https://github.com/casimir/frigoligo/commit/a2d2d329030c53a5b440146e60e58529059d5654))
- *(config)* Migrate config renovate.json ([#300](https://github.com/casimir/frigoligo/pull/300)) ([5fb33ec](https://github.com/casimir/frigoligo/commit/5fb33ec1d6a4bc883442d9d71d98632ec577b715))
- Remove l10n_esperanto workaround as it has been fixed upstream ([f3f2526](https://github.com/casimir/frigoligo/commit/f3f25268c8f323bb8a414232154f874fea63dc95))
- *(renovate)* Change a constraint to fix PR generation ([b6456ad](https://github.com/casimir/frigoligo/commit/b6456ad8d188c50ee02ab851eee0f4e06aff99c1))
- *(fastlane)* Regen metadata ([e0dee03](https://github.com/casimir/frigoligo/commit/e0dee03459ad4f30402033ab52cde9c2adb0f6eb))
- *(fastlane)* Few teaks before the release ([d9ea07e](https://github.com/casimir/frigoligo/commit/d9ea07e7b48d07e96bfb84ba14044e74b13f8f1d))

**Full Changelog**: [v2.0.0..v2.1.0](https://github.com/casimir/frigoligo/compare/v2.0.0..v2.1.0)


## [2.0.0] - 2024-11-07


### 🚀 Features

- *(search)* Filters revamp & search by text ([#252](https://github.com/casimir/frigoligo/pull/252)) ([2c5a76e](https://github.com/casimir/frigoligo/commit/2c5a76ea9514b632478ab5551036d9e17776f6b2))
- *(reading)* Rework the article screen ([#261](https://github.com/casimir/frigoligo/pull/261)) ([0a319b7](https://github.com/casimir/frigoligo/commit/0a319b77a881a940c2e28fe0e062107041606278))
- *(UI/UX)* Use a more sensible width for the listing in narrow layout ([f7685c0](https://github.com/casimir/frigoligo/commit/f7685c060e7a6620b6917dba6c0a925b0e46c606))
- *(UI/UX)* Always keep the bottom sheet action button visible ([092cd30](https://github.com/casimir/frigoligo/commit/092cd30e90ba8f0736f1b194d83e61b42ea18726))

### 🐛 Bug Fixes

- Fix new metadata languages ([aa99590](https://github.com/casimir/frigoligo/commit/aa99590708a87d2b955cfa84a4e04ac8982619a8))
- Fix json encoding in wallabag client ([38fc2e8](https://github.com/casimir/frigoligo/commit/38fc2e8e7dce3e21e9a8af4bea0d5bfdac465d0a))
- Fix upsert ([e966be3](https://github.com/casimir/frigoligo/commit/e966be3ab93fee70682cb2a03abb121d9600869d))
- Fix wallabag PATCH queries ([68427b1](https://github.com/casimir/frigoligo/commit/68427b13722e8fdf7901a90db73c7b4cd057ee0f))
- Fix sql conflict on article update ([47ff5b1](https://github.com/casimir/frigoligo/commit/47ff5b14a5e855b9d41561f02ba1b89f3e9d3c25))
- *(wallabag)* Don't try to use the old token when reconnecting ([b8dfb9e](https://github.com/casimir/frigoligo/commit/b8dfb9e7ecb1590c300dd4c7d79af7e8ded49ad6))
- Text search mode filter was not selected in default state ([459f60e](https://github.com/casimir/frigoligo/commit/459f60ed5bdd847ed0536015485725ce408c585e))
- *(UI/UX)* Reduce jumpiness when displaying the sync indicator ([9dbcdfb](https://github.com/casimir/frigoligo/commit/9dbcdfbbbf297e405bd5683260ec7dd87d1f30d8))
- *(UI/UX)* Ensure drawer open on start when using dynamic layout ([3035eb5](https://github.com/casimir/frigoligo/commit/3035eb51aaf2c9dc2cd2a3308aacfdc1f01354a4))
- *(wallabag)* Allow null values in non-null published_by field ([#268](https://github.com/casimir/frigoligo/pull/268)) ([60aa3d8](https://github.com/casimir/frigoligo/commit/60aa3d8f2d503bf30f246a07eb8dcc297cc46fad))
- *(UI/UX)* More precise jump to selected article ([570ff70](https://github.com/casimir/frigoligo/commit/570ff707bea2d54e647d88909e0f35ca9a9b55d9))
- *(UI/UX)* Use Ink for selected article and taps in the listing ([44d4b58](https://github.com/casimir/frigoligo/commit/44d4b583622bb314000eb8f9a33b9a6a5cd12f6b))

### 🚜 Refactor

- *(database)* Change code generation strategy ([#255](https://github.com/casimir/frigoligo/pull/255)) ([43486a7](https://github.com/casimir/frigoligo/commit/43486a729720c39080a14d0c74783a9fb2fe30ad))
- *(home page)* Change how scrolling works for a nicer UX ([#263](https://github.com/casimir/frigoligo/pull/263)) ([b9999f3](https://github.com/casimir/frigoligo/commit/b9999f34cc994f243f23151560c5ae8b05f59322))

### ⚡ Performance

- *(listing)* Prevent an infinite rendering loop ([a69bfcd](https://github.com/casimir/frigoligo/commit/a69bfcd7809a2464d5bcaa0ea350bf6f612165a0))

### 🌐 Translations

- Update translations: Esperanto
 ([c811d3d](https://github.com/casimir/frigoligo/commit/c811d3d706d284a2434ea8322e0e5e35231d9db5))
- Update translations: Galician
 ([84b938e](https://github.com/casimir/frigoligo/commit/84b938eb45794bd6f966b811e56e6e42b3b7b232))
- Update translations: French
 ([90593f8](https://github.com/casimir/frigoligo/commit/90593f8ac74e17ea2b6b5f88f7f208064d648bb1))
- Update translations: Portuguese (Portugal)
 ([97385bd](https://github.com/casimir/frigoligo/commit/97385bd0a37df65fe89d134e315e14fce2dc2406))
- Update translations: German
 ([94899cd](https://github.com/casimir/frigoligo/commit/94899cde20a49c47da1cdda8c53ac5c19ba42bbf))

### ⚙️ Miscellaneous Tasks

- *(deps)* Upgrade flutter dependencies ([#253](https://github.com/casimir/frigoligo/pull/253)) ([c292e37](https://github.com/casimir/frigoligo/commit/c292e37567e84a276edcf2118c6b15f31e2e2c5b))
- *(fastlane)* Update latest changelog with latest changes ([0979276](https://github.com/casimir/frigoligo/commit/0979276f569f3bae93850ec07aff5a33d792244e))
- [**breaking**] Modernize Android build scripts and config ([e4e9cbf](https://github.com/casimir/frigoligo/commit/e4e9cbf7935ca99fa348d9d95f57a1ece800aa4c))
- *(tooling)* Remove old and unused devices for screenshots ([6202c2a](https://github.com/casimir/frigoligo/commit/6202c2ae6d2cfaf65d5158ebd1c20cc1aaf5fe33))
- *(screenshots)* Rename dekstop.png to desktop.png ([5b02377](https://github.com/casimir/frigoligo/commit/5b023778c9be60a0df9f46580e1c3e6558002f76))
- *(tooling)* Enable the drift extension in devtools ([8045a46](https://github.com/casimir/frigoligo/commit/8045a46bf5546c2fb42ba559b4cc5b64961fe76b))
- Update the changelog with the last batch of changes ([52db92b](https://github.com/casimir/frigoligo/commit/52db92b9d1ac58a78ddfb89164e0ad3c3485f150))
- *(tooling)* Script most of the release process ([29b6926](https://github.com/casimir/frigoligo/commit/29b6926cbc144a9cc5f7b23e3698ee5102d732ec))

**Full Changelog**: [v1.2.0..v2.0.0](https://github.com/casimir/frigoligo/compare/v1.2.0..v2.0.0)


## [1.2.0] - 2024-07-30


### 🐛 Bug Fixes

- Fix wallabag client headers ([4c1f448](https://github.com/casimir/frigoligo/commit/4c1f448483ad5c8880fb8bcbb0cdc80260ef8e3b))
- Fix wallabag refresh token update ([#226](https://github.com/casimir/frigoligo/pull/226))

Most of the time the access token was invalid for the request where the refresh happened. ([75630fb](https://github.com/casimir/frigoligo/commit/75630fbbdc590580c3ad6d092290aa512503dfc6))
- Fix a few translation keys ([5b67b40](https://github.com/casimir/frigoligo/commit/5b67b4002677233d1d510bf37332fa3554b1ed9f))
- Fix typo in language label (DE) ([#234](https://github.com/casimir/frigoligo/pull/234)) ([bdc0533](https://github.com/casimir/frigoligo/commit/bdc05332f55f1be8fe14967990579a2e19c2d6b9))

### 🌐 Translations

- Update translations: German
 ([b0058b0](https://github.com/casimir/frigoligo/commit/b0058b05e30aed8a73336d4b82afcb8be1f8a024))
- Update translations: English
 ([6a5a88f](https://github.com/casimir/frigoligo/commit/6a5a88fe42929b58d6fb6878b8026824759f5b0e))
- Update translations: Portuguese
 ([bd25db5](https://github.com/casimir/frigoligo/commit/bd25db596809e82a3758738f96571c23968bcf71))
- Update translations: French
 ([19bbd20](https://github.com/casimir/frigoligo/commit/19bbd20d98f59ace23c9a7aa66574c2e214bb539))

**Full Changelog**: [v1.1.1..v1.2.0](https://github.com/casimir/frigoligo/compare/v1.1.1..v1.2.0)


## [1.1.1] - 2024-06-27


### 🐛 Bug Fixes

- Fix variable name ([b23699d](https://github.com/casimir/frigoligo/commit/b23699d4a74d254441c5ebb4dd814dc35ec4cdb5))
- Fix small lint warning ([210244a](https://github.com/casimir/frigoligo/commit/210244a0b62f174c6c7598d6d62ff43d3579cd31))
- Fix editorconfig split config ([4a2a063](https://github.com/casimir/frigoligo/commit/4a2a063f7f15824fc0778a4bf6d8a1dd7353672f))

### 🌐 Translations

- Update translations: Galician
 ([230bc75](https://github.com/casimir/frigoligo/commit/230bc75560c6b8b8a5dce97524d0faecd0c758a7))

**Full Changelog**: [v1.1.0..v1.1.1](https://github.com/casimir/frigoligo/compare/v1.1.0..v1.1.1)


## [1.1.0] - 2024-06-02


### 🐛 Bug Fixes

- Fix DB initialization on some android devices ([#199](https://github.com/casimir/frigoligo/pull/199)) ([1414b74](https://github.com/casimir/frigoligo/commit/1414b7446c06249821de5d92fbeca52f076c0951))

### 🌐 Translations

- Update translations: Portuguese (Brazil)
 ([9420a85](https://github.com/casimir/frigoligo/commit/9420a8537f8f45e25840cfc18fa7a9919a2f5798))
- Update translations: Chinese (Simplified)
 ([da44ad3](https://github.com/casimir/frigoligo/commit/da44ad30c98f950ff2b12b5ad934ff064b5bb64f))

**Full Changelog**: [v1.0.10..v1.1.0](https://github.com/casimir/frigoligo/compare/v1.0.10..v1.1.0)


## [1.0.10] - 2024-05-14


**Full Changelog**: [v1.0.9..v1.0.10](https://github.com/casimir/frigoligo/compare/v1.0.9..v1.0.10)


## [1.0.9] - 2024-05-06


**Full Changelog**: [v1.0.8..v1.0.9](https://github.com/casimir/frigoligo/compare/v1.0.8..v1.0.9)


## [1.0.8] - 2024-05-06


**Full Changelog**: [v1.0.7..v1.0.8](https://github.com/casimir/frigoligo/compare/v1.0.7..v1.0.8)


## [1.0.7] - 2024-05-05


**Full Changelog**: [v1.0.6..v1.0.7](https://github.com/casimir/frigoligo/compare/v1.0.6..v1.0.7)


## [1.0.6] - 2024-05-05


**Full Changelog**: [v1.0.5..v1.0.6](https://github.com/casimir/frigoligo/compare/v1.0.5..v1.0.6)


## [1.0.5] - 2024-04-28


### 🐛 Bug Fixes

- Fix versions number and name ([b2c2d12](https://github.com/casimir/frigoligo/commit/b2c2d129357129749e52c20382a14e7b9be851fb))

**Full Changelog**: [v1.0.4..v1.0.5](https://github.com/casimir/frigoligo/compare/v1.0.4..v1.0.5)


## [1.0.4] - 2024-04-28


**Full Changelog**: [v1.0.3..v1.0.4](https://github.com/casimir/frigoligo/compare/v1.0.3..v1.0.4)


## [1.0.3] - 2024-04-28


**Full Changelog**: [v1.0.2..v1.0.3](https://github.com/casimir/frigoligo/compare/v1.0.2..v1.0.3)


## [1.0.2] - 2024-04-28


**Full Changelog**: [v1.0.1..v1.0.2](https://github.com/casimir/frigoligo/compare/v1.0.1..v1.0.2)


## [1.0.1] - 2024-04-27


### 🐛 Bug Fixes

- Fix dart warning ([300cecb](https://github.com/casimir/frigoligo/commit/300cecbc0194f641edf218545c29116e9360b667))

**Full Changelog**: [v1.0.0..v1.0.1](https://github.com/casimir/frigoligo/compare/v1.0.0..v1.0.1)


## [1.0.0] - 2024-04-17


### 🌐 Translations

- Update translations: French
 ([cc1ca1d](https://github.com/casimir/frigoligo/commit/cc1ca1d8ff949227d9cd3ce856c7bcd03b771b8f))

**Full Changelog**: [v0.8.1..v1.0.0](https://github.com/casimir/frigoligo/compare/v0.8.1..v1.0.0)


## [0.8.1] - 2024-03-22


### 🌐 Translations

- Update translations: French
 ([6161a21](https://github.com/casimir/frigoligo/commit/6161a21d6d3481d3367c81c7d5a59aa35ec2cd49))

**Full Changelog**: [v0.8.0..v0.8.1](https://github.com/casimir/frigoligo/compare/v0.8.0..v0.8.1)


## [0.8.0] - 2024-03-19


### 🌐 Translations

- Update translations: French
 ([5fcc3a8](https://github.com/casimir/frigoligo/commit/5fcc3a855de74ef9eb46725e5776d458de8872ab))

**Full Changelog**: [v0.7.2..v0.8.0](https://github.com/casimir/frigoligo/compare/v0.7.2..v0.8.0)


## [0.7.2] - 2024-01-19


**Full Changelog**: [v0.7.1..v0.7.2](https://github.com/casimir/frigoligo/compare/v0.7.1..v0.7.2)


## [0.7.1] - 2024-01-18


### 🐛 Bug Fixes

- Fix version numbers ([375cf8c](https://github.com/casimir/frigoligo/commit/375cf8c44836ecf1ea2c0b51f52064df4ef104aa))

### 🌐 Translations

- Update translations: German
 ([f80f054](https://github.com/casimir/frigoligo/commit/f80f05449e2cde6d29217f5bbbb6b25c56bcb483))

**Full Changelog**: [v0.7.0..v0.7.1](https://github.com/casimir/frigoligo/compare/v0.7.0..v0.7.1)


## [0.7.0] - 2024-01-10


### 🌐 Translations

- Update translations: French
 ([7995866](https://github.com/casimir/frigoligo/commit/799586605f4a2da9bf2b1fbd4355132128a4405f))
- Update translations: German
 ([3e73b11](https://github.com/casimir/frigoligo/commit/3e73b11d985e15784617281a11b7072cbba2422b))

**Full Changelog**: [v0.6.4..v0.7.0](https://github.com/casimir/frigoligo/compare/v0.6.4..v0.7.0)


## [0.6.4] - 2024-01-03


**Full Changelog**: [v0.6.3..v0.6.4](https://github.com/casimir/frigoligo/compare/v0.6.3..v0.6.4)


## [0.6.3] - 2023-12-26


**Full Changelog**: [v0.6.2..v0.6.3](https://github.com/casimir/frigoligo/compare/v0.6.2..v0.6.3)


## [0.6.2] - 2023-11-20


**Full Changelog**: [v0.6.1..v0.6.2](https://github.com/casimir/frigoligo/compare/v0.6.1..v0.6.2)


## [0.6.1] - 2023-11-18


### 🐛 Bug Fixes

- Fix a few simple warnings ([325dd7f](https://github.com/casimir/frigoligo/commit/325dd7fdfc2fd8f9e894acee4bbdc7df04e3b050))

**Full Changelog**: [v0.6.0..v0.6.1](https://github.com/casimir/frigoligo/compare/v0.6.0..v0.6.1)


## [0.6.0] - 2023-11-03


### 🐛 Bug Fixes

- Fix build phase order for xcode 15+ ([24373e1](https://github.com/casimir/frigoligo/commit/24373e1642762a7f61f617c427502568bb24da40))

**Full Changelog**: [v0.5.1..v0.6.0](https://github.com/casimir/frigoligo/compare/v0.5.1..v0.6.0)


## [0.5.1] - 2023-09-28


**Full Changelog**: [v0.5.0..v0.5.1](https://github.com/casimir/frigoligo/compare/v0.5.0..v0.5.1)


## [0.5.0] - 2023-09-21


### 🐛 Bug Fixes

- Fix index lookup ([8d01f9f](https://github.com/casimir/frigoligo/commit/8d01f9f3921512dfd1d26c97f21640944cc2e5d8))

**Full Changelog**: [v0.4.1..v0.5.0](https://github.com/casimir/frigoligo/compare/v0.4.1..v0.5.0)


## [0.4.1] - 2023-08-14


**Full Changelog**: [v0.4.0..v0.4.1](https://github.com/casimir/frigoligo/compare/v0.4.0..v0.4.1)


## [0.4.0] - 2023-08-08


### 🐛 Bug Fixes

- Fix session detail copy ([e8533db](https://github.com/casimir/frigoligo/commit/e8533db3ccf9299177bc1d1cefca906aeb94424a))

**Full Changelog**: [v0.3.2..v0.4.0](https://github.com/casimir/frigoligo/compare/v0.3.2..v0.4.0)


## [0.3.2] - 2023-08-04


### 🐛 Bug Fixes

- Fix a few non-important warnings ([9d41d49](https://github.com/casimir/frigoligo/commit/9d41d494a09694f2f41891a6c3d57a34a1c1d74a))

**Full Changelog**: [v0.3.1..v0.3.2](https://github.com/casimir/frigoligo/compare/v0.3.1..v0.3.2)


## [0.3.1] - 2023-08-02


### 🐛 Bug Fixes

- Fix main branch reference ([d8c1bd9](https://github.com/casimir/frigoligo/commit/d8c1bd9462ff32f5c23ec4afdde7de2edbcd4f88))
- Fix release link + add a link for missing features ([eb3c462](https://github.com/casimir/frigoligo/commit/eb3c462170ec329824df3a189506ef97509441d4))
- Fix initialization order for PackageInfo ([0feccd9](https://github.com/casimir/frigoligo/commit/0feccd96d4b5e3f94e39a3f9d26edfe296067508))
- Fix release script rights and artifacts links in the README ([76555f1](https://github.com/casimir/frigoligo/commit/76555f16ef6dd0fe3143f9cdd481d1087314a42e))

**Full Changelog**: [v0.3.0..v0.3.1](https://github.com/casimir/frigoligo/compare/v0.3.0..v0.3.1)


## [0.3.0] - 2023-07-27


### 🐛 Bug Fixes

- Fix form display with native keyboard (and small screens) ([#8](https://github.com/casimir/frigoligo/pull/8)) ([adbdf80](https://github.com/casimir/frigoligo/commit/adbdf80923c82e97d216c82b8a292627841d7d51))

**Full Changelog**: [v0.2.0..v0.3.0](https://github.com/casimir/frigoligo/compare/v0.2.0..v0.3.0)


## [0.2.0] - 2023-07-25


### 🐛 Bug Fixes

- Fix global key collision ([3450aef](https://github.com/casimir/frigoligo/commit/3450aef1eacf2a32dcce9363bb846132be42bd1a))

**Full Changelog**: [v0.1.0..v0.2.0](https://github.com/casimir/frigoligo/compare/v0.1.0..v0.2.0)


## [0.1.0] - 2023-07-19


### 🐛 Bug Fixes

- Fix storyboard file for iPad ([27604e3](https://github.com/casimir/frigoligo/commit/27604e3e9c05022864398adb7d47f485db6f6e2a))

### 🚜 Refactor

- Refactor server connection data and prepare server chooser dialog ([4456917](https://github.com/casimir/frigoligo/commit/4456917e651ecca9aed4e90d2370adfd2d11fd49))
<!-- generated by git-cliff -->
