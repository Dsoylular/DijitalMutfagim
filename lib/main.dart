import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loadingPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'APIKEY',
        appId: 'APPID',
        messagingSenderId: 'sendid',
        projectId: 'aiappjamteam88',
        storageBucket: 'myapp-b9yt18.appspot.com',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dijital Mutfağım',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen(),
    );
  }
}
