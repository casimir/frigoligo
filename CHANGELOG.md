# Changelog

All notable changes to this project will be documented in this file.

See [changelogs](https://github.com/casimir/frigoligo/tree/main/fastlane/metadata/android/en-US/changelogs) for a more high level list of changes.

## [unreleased]


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

### 🐛 Bug Fixes

- *(web)* Change logos and icons ([b08a515](https://github.com/casimir/frigoligo/commit/b08a51577cebe3046a5773cf78b7c067b6b30828))
- *(reading)* Keep the scrollbar on the far right on large screens ([cfea627](https://github.com/casimir/frigoligo/commit/cfea627ec1e73df660bef3cfc2f6d6f534308427))
- *(UI/UX)* Put back an outline to the search field for consistency ([9c881f9](https://github.com/casimir/frigoligo/commit/9c881f91141b39d0d2fb1921421742b563483b03))
- *(UI/UX)* Remove some spacing ([9907545](https://github.com/casimir/frigoligo/commit/9907545c113ffe22e9386f1fdd7082b11e5899a9))
- *(reading)* Truncate title to avoid vertical clipping ([d37056a](https://github.com/casimir/frigoligo/commit/d37056a7d25637d7a9083b7e37a3b1bdb02c9dde))
- *(iOS)* Attach the share popover to the button that triggered it ([1b865f4](https://github.com/casimir/frigoligo/commit/1b865f4a53a31b7fd2432d564c670f285efdf1bb))
- Add a temporary workaround for l10n_esperanto ([971308f](https://github.com/casimir/frigoligo/commit/971308f03a8b5fc459bba47a7cd5e9c23f05f548))

### 🚜 Refactor

- *(settings)* Change how enum values are handled ([#277](https://github.com/casimir/frigoligo/pull/277)) ([2c8078a](https://github.com/casimir/frigoligo/commit/2c8078ab530732347947abe2937762ef8df5c8cb))
- *(reading settings)* Use cadanse instead of hard coded values ([1f7c5cb](https://github.com/casimir/frigoligo/commit/1f7c5cb239f6be2f6aa179013a53a918b3644ee1))
- Simplify currentArticleProvider ([78a3ac7](https://github.com/casimir/frigoligo/commit/78a3ac7697c8ff968b777f32fee37526d93b4239))

### 📚 Documentation

- *(readme)* Mention the web app (with a link). ([6fb3f3e](https://github.com/casimir/frigoligo/commit/6fb3f3e7eaeca1e29ee74ff03f3e1f16288e022c))
- Fix grammar errors in the readme ([#285](https://github.com/casimir/frigoligo/pull/285)) ([dca4712](https://github.com/casimir/frigoligo/commit/dca471292ea23f93794bc00b7bc659b57969edd0))
- Reduce translation minimum completeness to align with weblate ([b27b290](https://github.com/casimir/frigoligo/commit/b27b290e8b3cfdba193d1a64bdf1775ba1299ee5))
- *(changelogs)* Start the changelog for the next release ([71a3fa9](https://github.com/casimir/frigoligo/commit/71a3fa9d07189fbb135fd1c2acb84b527a793752))

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

### ⚙️ Miscellaneous Tasks

- *(release)* Prepare the new dev cycle ([8724d5d](https://github.com/casimir/frigoligo/commit/8724d5da03f7e112f80f374ec946cca7d68aea35))
- Bump version name ([9bf66d0](https://github.com/casimir/frigoligo/commit/9bf66d024802db36eecce2c430e6cecf9aa09786))
- Bump CocoaPods lockfiles ([5e44a74](https://github.com/casimir/frigoligo/commit/5e44a74bc8dcef74c0edd086e4309f44c72651d4))
- Setup automated changelog update every day ([627adcf](https://github.com/casimir/frigoligo/commit/627adcf6c661517d3f2f6e4826563b9d06450ae9))
- *(screenshots)* Add ET to the list of locales ([9cbdcc9](https://github.com/casimir/frigoligo/commit/9cbdcc95dc8f34f02e781658c31e6e30c2c83816))
- Update flutter and flutter dependencies ([bd44dfc](https://github.com/casimir/frigoligo/commit/bd44dfcddfa165e6ab7aa22f7cb7cf7d75f41dc6))

**Full Changelog**: [v2.0.0..HEAD](https://github.com/casimir/frigoligo/compare/v2.0.0..HEAD)


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
