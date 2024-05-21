import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'appColors.dart';

Widget buildTariflerimPage() {
  return Scaffold(
    body: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/image1_0.jpg',
            ),
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Tarifler",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: getTariflerim(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                List<dynamic> tarifList = snapshot.data!;
                return ListView.builder(
                  itemCount: tarifList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Tapped on: ${tarifList[index]}');
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(
                                tarifList[index].toString(),
                                style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.deepPurple,
                          height: 1,
                          thickness: 2,
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}


Future<List<dynamic>> getTariflerim() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('tarifler')
        .doc('tarifPromtları')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        return data.keys.toList();
      } else {
        print('Data is null');
      }
    } else {
      print('Document does not exist');
    }
  } catch (error) {
    print('Error: $error');
  }
  return [];
}
