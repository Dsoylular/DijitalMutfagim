import 'package:ai_app_jam/recipePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'appColors.dart';
import 'globalVariables.dart';

Widget buildTariflerimPage() {
  return Scaffold(
    body: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/family_cooking.jpg',
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
                            // print('Tapped on: ${tarifList[index]}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tarif(name: tarifList[index]),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListTile(
                                title: Text(
                                  tarifList[index].toString(),
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.deepPurple,
                                  size: 16,
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                          ),
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


Future<List<String>> getTariflerim() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('tarifler')
        .doc('tarifPromtları')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        List<String> filteredKeys = [];
        data.forEach((key, value) {
          if (value is Map<String, dynamic>
            && (value['isLactose'] || !isLactoseFree)
            && (value['isDiary'] || !isDairyFree)
            && (value['isVegan'] || !isVegan)
            && (value['isGluten'] || !isGlutenFree)
          ) {
            filteredKeys.add(key);
          }
        });

        return filteredKeys;
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

