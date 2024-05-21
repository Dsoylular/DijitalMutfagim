import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addPage.dart';
import 'appColors.dart';
import 'filterPage.dart';
import 'tarifPage.dart';

const apiKey = 'AIzaSyBQig-uH6FnwL-9H8RkxLSuaTCqDs0xnX0';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _selectedIndex = 1;
  final TextEditingController _textFieldController = TextEditingController();
  List<String> malzemeler = [];
  bool isLactoseFree = false;
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isDairyFree = false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 20),
            Text(
              "Dijital Mutfağım",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? buildFilterPage()
          : _selectedIndex == 1
          ? buildTariflerimPage()
          : buildNewTarifPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filtre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Tarifler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Yeni Tarif',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildNewTarifPage() {
    return Stack(
      children: [
        SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange),
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
                            text: ', hadi beraber\nbir tarif oluşturalım!',
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
                          child: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              hintText: 'Malzemeleri giriniz...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final text = _textFieldController.text;
                          print('Text Field Content: $text');
                          _textFieldController.clear();
                          setState(() {
                            malzemeler.add(text);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ekle',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: malzemeler.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          title: Text(
                            malzemeler[index].toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                malzemeler.removeAt(index);
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          dense: true,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Switch(
                              value: isLactoseFree,
                              onChanged: (value) {
                                setState(() {
                                  isLactoseFree = value;
                                });
                              },
                            ),
                            const Text("Laktozsuz"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Switch(
                              value: isGlutenFree,
                              onChanged: (value) {
                                setState(() {
                                  isGlutenFree = value;
                                });
                              },
                            ),
                            const Text("Glutensiz"),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Switch(
                              value: isVegan,
                              onChanged: (value) {
                                setState(() {
                                  isVegan = value;
                                });
                              },
                            ),
                            const Text("Vegan      "),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Switch(
                              value: isDairyFree,
                              onChanged: (value) {
                                setState(() {
                                  isDairyFree = value;
                                });
                              },
                            ),
                            const Text("Dairy-free"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isProcessing = true;
                    });
                    List<String> limitler = [
                      isLactoseFree ? "laktozsuz" : "",
                      isGlutenFree ? "glutensiz" : "",
                      isVegan ? "vegan" : "",
                      isDairyFree ? "dairy-free" : ""
                    ];

                    final response = await talkWithGemini(malzemeler, limitler);

                    setState(() {
                      _isProcessing = false;
                    });
                    if (response != null) {
                      List<String> responseWords = response.toString().split('**');
                      String documentName = responseWords.length > 1
                          ? '${responseWords[0]} ${responseWords[1]}'
                          : responseWords[0];

                      await FirebaseFirestore.instance
                          .collection('tarifler')
                          .doc('tarifPromtları')
                          .set({
                        documentName: response,
                      }, SetOptions(merge: true));

                      setState(() {
                        malzemeler.clear();
                        isLactoseFree = false;
                        isGlutenFree = false;
                        isVegan = false;
                        isDairyFree = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarif başarıyla oluşturuldu!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarif oluşturulamadı, lütfen tekrar deneyin.'),
                          backgroundColor: Colors.red,
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
                  child: const Text(
                    'Oluştur',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        Visibility(
          visible: _isProcessing,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ]
    );
  }
}
