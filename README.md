# Expense App (Flutter) — Ready to build APK

This bundle includes the Flutter `lib/` source files and `pubspec.yaml`.  
Follow the steps below to create and build the APK on your machine.

## Requirements
- Install Flutter SDK: https://flutter.dev/docs/get-started/install
- Install Android SDK / Android Studio (for Android toolchain)
- Set up ANDROID_HOME/ANDROID_SDK_ROOT and add platform-tools to PATH
- On your machine run `flutter doctor` and fix any issues.

## Quick steps to prepare project
1. Open a terminal and create a new Flutter project (this creates platform folders):
   ```bash
   flutter create expense_app
   cd expense_app
   ```
2. Replace the generated `pubspec.yaml` with the one from this bundle (or merge dependencies).
3. Replace `lib/main.dart` with provided `lib/main.dart`.
   Create `lib/add_data_screen.dart` and `lib/database.dart` with the provided files.
4. Get packages:
   ```bash
   flutter pub get
   ```

## Build APK (debug or release)
- Debug APK:
  ```bash
  flutter build apk --debug
  ```
  Output: `build/app/outputs/flutter-apk/app-debug.apk`

- Release APK (recommended for distribution):
  ```bash
  flutter build apk --release
  ```
  Output: `build/app/outputs/flutter-apk/app-release.apk`

## (Optional) Signing the release APK
Follow Flutter docs: https://flutter.dev/docs/deployment/android#signing-the-app

Typical steps:
- Generate a keystore:
  ```bash
  keytool -genkey -v -keystore ~/my-release-key.jks -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  ```
- Configure `android/key.properties` and `android/app/build.gradle` for signing.

## (Optional) CI (GitHub Actions) to build APK automatically
Create `.github/workflows/android.yml` with a Flutter setup action and `flutter build apk` step.

## Need help?
If তুমি চাও, আমি তোমার জন্য:
- APK locally build করে দিতাম — কিন্তু এখান থেকে সরাসরি APK তৈরি করা সম্ভব নয় কারণ আমার environment-এ Flutter & Android SDK নেই।
- আমি GitHub Actions রান করে build করার workflow/ফাইল তৈরি করে দিতে পারি — তারপর তুমি GitHub এ push করলে auto-built APK পেয়ে যাবে।
- আরো ফিচার যোগ করতে চাইলে (গ্রাফ, এক্সপোর্ট পিডিএফ, মাসিক রিপোর্ট), বলো — আমি কোড যোগ করে ZIP আপডেট করে দেব।

