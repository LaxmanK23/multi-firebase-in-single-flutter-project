# demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources:
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter docs](https://docs.flutter.dev/)

Prerequisites:
- Flutter SDK installed
- Firebase CLI and FlutterFire CLI installed and authenticated

Steps to add two Firebase apps (one default, one named "secondary"):

1. Log in to Firebase
```bash
firebase login
```

2. Verify your Firebase projects
```bash
firebase projects:list
```
Note the project IDs you want to use (the default project and the SECOND_PROJECT_ID).

3. Generate Firebase configuration files
- Generate the default config (this creates lib/firebase_options.dart):
```bash
flutterfire configure
```
- Generate the second project's config (output to lib/firebase_options_second.dart):
```bash
flutterfire configure --project=<SECOND_PROJECT_ID> --out=lib/firebase_options_second.dart
```
Replace <SECOND_PROJECT_ID> with the project ID from step 2.

4. Initialize both Firebase apps in your Flutter app
- Import the generated files and initialize before using Firebase (for example in main.dart):
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // default
import 'firebase_options_second.dart'; // second

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize default app
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize named secondary app
    await Firebase.initializeApp(
        name: 'secondary',
        options: SecondFirebaseOptions.currentPlatform,
    );

    runApp(MyApp());
}
```
Notes:
- Call WidgetsFlutterBinding.ensureInitialized() before Firebase initialization.
- Use the generated option classes (DefaultFirebaseOptions and SecondFirebaseOptions).
- If you need to target a specific platform/config, re-run flutterfire configure with appropriate flags or edit the generated files accordingly.