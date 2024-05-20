import 'dart:async';

import 'package:flutter/material.dart';

import 'EntryPage.dart';
import 'appColors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const EntryScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dijital Mutfağım',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 24,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}