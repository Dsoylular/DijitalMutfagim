import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'appColors.dart';

class MyTarif extends StatefulWidget {
  const MyTarif({super.key});

  @override
  State<MyTarif> createState() => _MyTarifState();
}

class _MyTarifState extends State<MyTarif> {
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController textFieldController2 = TextEditingController();
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/grandma_cooking.jpg',
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
                          text: ', hadi bir\n tarif paylaş!',
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
              const SizedBox(height: 35),
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
                        height: 75,
                        child: TextField(
                          controller: textFieldController2,
                          decoration: InputDecoration(
                            hintText: 'Tarifin ismini giriniz...',
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
              const SizedBox(height: 10),
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
                          controller: textFieldController,
                          decoration: InputDecoration(
                            hintText: 'Tarifi buraya girin...',
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
                onPressed: () async {
                  final promt = textFieldController.text;
                  if (promt.isNotEmpty) {
                    // print(promt);
                    await FirebaseFirestore.instance
                        .collection('tarifler')
                        .doc('tarifPromtları')
                        .update({
                      textFieldController2.text: {
                        'tarif': promt,
                        'isDiary': false,
                        'isVegan': false,
                        'isLactose': false,
                        'isGluten': false,
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tarif oluşturuldu!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
