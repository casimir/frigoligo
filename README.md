# Frigoligo [![Chat on Matrix](https://matrix.to/img/matrix-badge.svg)](https://matrix.to/#/#frigoligo:one.ems.host)

Frigoligo is an universal [wallabag](https://wallabag.org/) client made with [Flutter](https://flutter.dev/).
It is made to be _a lot of super-cool marketing things_ but for now it is just made with love and that's something.

## Installation

| Platform        | Link                                                                                |
|-----------------|-------------------------------------------------------------------------------------|
| iOS             | [Testflight](https://testflight.apple.com/join/nYnbySd8)                            |
| Android (store) | [PlayStore](https://play.google.com/store/apps/details?id=net.casimirlab.frigoligo) |
| Android (apk)   | [see latest release](https://github.com/casimir/frigoligo/releases/latest)          |
| macOS           | [Testflight](https://testflight.apple.com/join/nYnbySd8)                            |
| Linux           | [see latest release](https://github.com/casimir/frigoligo/releases/latest)          |
| AppImage        | [see latest release](https://github.com/casimir/frigoligo/releases/latest)          |
| Windows         | [see latest release](https://github.com/casimir/frigoligo/releases/latest)          |

## Features

Missing but planned feature are tracked in the [issues](https://github.com/casimir/frigoligo/issues?q=is%3Aissue+is%3Aopen+label%3A"missing+feature").

A full history of changes is available in [CHANGELOG.md](./CHANGELOG.md).

## Screenshots

|                            Mobile                             |                         Desktop                         |                              Mobile (dark)                              |
|:-------------------------------------------------------------:|:-------------------------------------------------------:|:-----------------------------------------------------------------------:|
| ![android screenshot](./assets/screenshots/android_light.png) | ![desktop screenshot](./assets/screenshots/desktop.png) | ![android dark theme screenshot](./assets/screenshots/android_dark.png) |

## Deeplinks

Frigoligo supports a few deeplinks that allows it to be integrated in external workflows. All platforms except Linux are supported.

### Links format

Deeplinks are based on a custom scheme, the URI path is used to determine the action to perform.

The follow link will open the app and perform the `action` action with the given parameters `param1` (`hello`) and `param2` (`Günther`). Note that the host `x` is just here for readability and is ignored.

```
frigoligo://x/action?param1=hello&param2=G%C3%BCnther
```

### Actions

#### `/articles/:articleId`

Open the article with the given ID respecting the correct app navigation mode.

| Parameter   | Description                             | Required |
|-------------|-----------------------------------------|----------|
| `articleId` | The wallabag ID of the article to open. | Yes      |

#### `/login`

Open the login page and prefills the given credentials. Be aware that such link in the wild weakens the security of your account.

| Parameter      | Description                  | Required |
|----------------|------------------------------|----------|
| `server`       | Your wallabag server URL.    | No       |
| `clientId`     | Your wallabag client ID.     | No       |
| `clientSecret` | Your wallabag client secret. | No       |
| `username`     | Your wallabag username.      | No       |
| `password`     | Your wallabag password.      | No       |

#### `/save`

Save a new article. This is super useful to integrate article saving from an external workflow.

| Parameter | Description                     | Required |
|-----------|---------------------------------|----------|
| `url`     | The URL of the article to save. | Yes      |

## License

Licensed under the MIT. See [LICENSE](./LICENSE) for details.

## Translations

Translations are managed on [Weblate](https://hosted.weblate.org/projects/frigoligo/flutter/). Feel free to help!
