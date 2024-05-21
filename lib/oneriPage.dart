import 'package:flutter/material.dart';

import 'appColors.dart';

Widget buildOneriPage() {
  final TextEditingController textFieldController = TextEditingController();
  return Stack(
    children: [
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/cooking_man.jpg',
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Merhabalar',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ', hadi biraz\n kendinden bahset!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: cream,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        child: TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: textFieldController,
                          decoration: InputDecoration(
                            hintText: 'Ne tür yemekler seversiniz...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print(textFieldController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.casino_outlined,
                    color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      // Visibility(
      //   visible: _isProcessing,
      //   child: Container(
      //     color: Colors.black.withOpacity(0.5),
      //     child: const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   ),
      // ),
    ],
  );
}