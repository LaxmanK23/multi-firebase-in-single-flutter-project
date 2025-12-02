import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_options_second.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(
    name: 'secondary',
    options: SecondFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Page')),
      body: ListView(
        children: [
          FilledButton(
            onPressed: () async {
              try {
                // Write to FIRST Firebase project
                await FirebaseFirestore.instance.collection('demo').add({
                  'source': 'PRIMARY',
                  'timestamp': FieldValue.serverTimestamp(),
                });
              } catch (e) {
                print('Error adding document to PRIMARY: $e');
              }
            },
            child: Text('Write to PRIMARY Firebase'),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: () async {
              try {
                // Get SECONDARY Firestore
                final secondaryFirestore = FirebaseFirestore.instanceFor(
                  app: Firebase.app('secondary'),
                );

                // Write to SECOND Firebase project
                await secondaryFirestore.collection('demo').add({
                  'source': 'SECONDARY',
                  'timestamp': FieldValue.serverTimestamp(),
                });
              } catch (e) {
                print('Error adding document to SECONDARY: $e');
              }
            },
            child: Text('Write to SECONDARY Firebase'),
          ),
        ],
      ),
    );
  }
}
