import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loadingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCMP0i-V-fldxXHKzqqjzTfT7SRd_u_T5E',
        appId: '1:999416805479:android:4d16690efbbda958ce7cc2',
        messagingSenderId: 'sendid',
        projectId: 'aiappjamteam88',
        storageBucket: 'myapp-b9yt18.appspot.com',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
