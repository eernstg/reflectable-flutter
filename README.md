# A basic example using reflectable in Flutter.

This is a completely minimal example, just enough to check that
it is possible to use reflectable to generate code for obtaining
reflection support, also in the context of Flutter.

Commands used to get started:

```console
git clone https://github.com/eernstg/reflectable-flutter
cd reflectable-flutter
flutter doctor # just checking
flutter pub get
flutter packages pub run build_runner build test
dart test/reflectable_test.dart
# Also runnable from Android Studio on an Android device.
```
