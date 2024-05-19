import 'package:flutter/material.dart';

Widget buildBlankPage() {
  return Container(
    color: Colors.green,
    child: const Center(
      child: Icon(
        Icons.blur_on,
        size: 100,
        color: Colors.black,
      ),
    ),
  );
}