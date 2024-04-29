This is a opinionated fork of [fluffychat](https://github.com/krille-chan/fluffychat/) for self use.

Like all Google products, Dart is a failure. Therefore, this project will not be worked on unless it has to be used.

<img alt="Screenshot" src="https://github.com/iacore/fluffychat/blob/main/assets/screenshot.png" height="512" />

# How to build

You must use Java 17. (or higher, which I haven't tried). Run `git clean -idx` to reset the repo if you have tried using another Java version to build this project, because gradle doesn't know what is cache invalidation.

(Optional. a public signing key (`android/key.jks`) is provided with the password 123456) Generate a key. Set a simple password (i hate security hype).

```
mkdir -p android
keytool -genkey -v -keystore android/key.jks -alias key -keyalg RSA -keysize 2048 -validity 10000
```

Set build key file

```
env FDROID_KEY_PASS=the_simple_password_you_just_set scripts/prepare-android-release-simple.sh
```

Build

```
flutter build apk
```

If you like complication, read [the official build instructions](https://github.com/krille-chan/fluffychat/wiki/How-To-Build).

