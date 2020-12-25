# Apple Device Information

[![GitHub release](https://img.shields.io/github/release/sersoft-gmbh/apple-device-information.svg?style=flat)](https://github.com/sersoft-gmbh/apple-device-information/releases/latest)
![Tests](https://github.com/sersoft-gmbh/apple-device-information/workflows/Tests/badge.svg)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/929f794d2d28496a8195bf50def99d7e)](https://www.codacy.com/gh/sersoft-gmbh/apple-device-information/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=sersoft-gmbh/apple-device-information&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/sersoft-gmbh/apple-device-information/branch/main/graph/badge.svg?token=CI3ZFQGY7C)](https://codecov.io/gh/sersoft-gmbh/apple-device-information)
[![jazzy](https://raw.githubusercontent.com/sersoft-gmbh/apple-device-information/gh-pages/badge.svg?sanitize=true)](https://sersoft-gmbh.github.io/apple-device-information)

A database of device information which includes a mapping of device model identifiers to names.

## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/apple-device-information.git", from: "1.0.0"),
```

## Usage

### `DeviceInfo`

Simply access `DeviceInfo.current` and you have access to all information this package currently offers.
For a more detailed documentation of the fields, please have a look at the header docs.


## Documentation

The API is documented using header doc. If you prefer to view the documentation as a webpage, there is an [online version](https://sersoft-gmbh.github.io/apple-device-informatino) available for you.

## Contributing

If you find a bug / like to see a new feature in this package there are a few ways of helping out:

-   If you can fix the bug / implement the feature yourself please do and open a PR.
-   If you know how to code (which you probably do), please add a (failing) test and open a PR. We'll try to get your test green ASAP.
-   If you can do neither, then open an issue. While this might be the easiest way, it will likely take the longest for the bug to be fixed / feature to be implemented.

## License

See [LICENSE](./LICENSE) file.
