import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'geminiCodes.dart';
import 'appColors.dart';
import 'globalVariables.dart';
import 'tariflerPage.dart';

const apiKey = 'AIzaSyBQig-uH6FnwL-9H8RkxLSuaTCqDs0xnX0';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _selectedIndex = 1;
  final TextEditingController _textFieldController = TextEditingController();
  List<String> malzemeler = ["pirinç", "et"];
  // bool isLactoseFree = false;
  // bool isGlutenFree = false;
  // bool isVegan = false;
  // bool isDairyFree = false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Row(
          children: [
            const SizedBox(width: 20),
            const Expanded(
              child: Text(
                "Dijital Mutfağım",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: (_selectedIndex == 1) ? Colors.white : Colors.transparent,
                size: 30,
              ),
              onPressed: () {
                _showFiltersBottomSheet(context);
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? buildOneriPage()
          : _selectedIndex == 1
          ? buildTariflerimPage()
          : buildNewTarifPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'Öner Bana!',
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

  void _showFiltersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: isLactoseFree,
                        onChanged: (value) {
                          setModalState(() {
                            isLactoseFree = value;
                          });
                          setState(() {
                            isLactoseFree = value;
                          });
                        },
                      ),
                      const Text("Laktozsuz"),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: isGlutenFree,
                        onChanged: (value) {
                          setModalState(() {
                            isGlutenFree = value;
                          });
                          setState(() {
                            isGlutenFree = value;
                          });
                        },
                      ),
                      const Text("Glutensiz"),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: isVegan,
                        onChanged: (value) {
                          setModalState(() {
                            isVegan = value;
                          });
                          setState(() {
                            isVegan = value;
                          });
                        },
                      ),
                      const Text("Vegan"),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: isDairyFree,
                        onChanged: (value) {
                          setModalState(() {
                            isDairyFree = value;
                          });
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
            );
          },
        );
      },
    );
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
                                hintText: 'Elinizdeki malzemeleri giriniz...',
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              title: Text(
                                malzemeler[index].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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
                        children:                        [
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
                              const Text("Vegan"),
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
                        if (isLactoseFree) "laktozsuz",
                        if (isGlutenFree) "glutensiz",
                        if (isVegan) "vegan",
                        if (isDairyFree) "dairy-free"
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
                            .update({
                          documentName: {
                            'tarif': response,
                            'isDiary': isDairyFree,
                            'isVegan': isVegan,
                            'isLactose': isLactoseFree,
                            'isGluten': isGlutenFree,
                          }
                        });
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
      ],
    );
  }

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
                            text: ', bugün\n ne yemek istersin?',
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
                          height: 200,
                          child: TextField(
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
                  onPressed: () async {
                    final promt = textFieldController.text;
                    if (promt.isNotEmpty) {
                      print(promt);
                      setState(() {
                        _isProcessing = true;
                      });
                      final response = await proposeToGemini(promt);
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
                            .update({
                          documentName: {
                            'tarif': response,
                            'isDiary': false,
                            'isVegan': false,
                            'isLactose': false,
                            'isGluten': false,
                          }
                        });
                        setState(() {
                          malzemeler.clear();
                          isLactoseFree = false;
                          isGlutenFree = false;
                          isVegan = false;
                          isDairyFree = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('"$documentName" başarıyla oluşturuldu!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tarif oluşturulurken hata!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
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
        Visibility(
          visible: _isProcessing,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

