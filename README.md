# A basic example using reflectable in Flutter.

This is a completely minimal example, just enough to check that
it is possible to use reflectable to generate code for obtaining
reflection support, also in the context of Flutter.

Commands used to get started (unfortunately we have to rename the directory,
because the repo name was chosen before I knew that the dash creates problems
with some tools):

```console
git clone https://github.com/eernstg/reflectable-flutter
mv reflectable-flutter reflectable_flutter
cd reflectable_flutter
flutter doctor # just checking
flutter pub get
flutter pub run build_runner build
flutter create .
flutter run
```
