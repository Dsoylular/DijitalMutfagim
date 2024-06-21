import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/foodAnimation.json',
        width: 100,
        height: 100,
      ),
    );
  }
}
