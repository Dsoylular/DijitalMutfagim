import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tarif extends StatefulWidget {
  final String name;
  const Tarif({required this.name, super.key});

  @override
  State<Tarif> createState() => _TarifState();
}

class _TarifState extends State<Tarif> {
  String get name => widget.name;
  String? recipe;

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  Future<void> fetchRecipe() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('tarifler')
          .doc('tarifPromtları')
          .get();

      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (data.containsKey(name)) {
        setState(() {
          recipe = data[name]['tarif'];
        });
      }
    } catch (e) {
      print("Error fetching recipe: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: recipe == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                children: _parseRecipe(recipe!),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                _currentStep = 1;
                _startRecipe();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Başla', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  int _currentStep = 1;
  int _totalTalimatlar = 0;

  void _startRecipe() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            'Adım $_currentStep',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _getTalimatlar(_currentStep),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentStep > 1)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentStep--;
                        });
                        _startRecipe();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Geri', style: TextStyle(fontSize: 18)),
                    ),
                  const SizedBox(width: 8),
                  if(_currentStep < _totalTalimatlar)
                    ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _currentStep++;
                      });
                      _startRecipe();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Devam', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _getTalimatlar(int step) {
    List<String> parts = recipe!.split('**Talimatlar:**');
    if (parts.length < 2) {
      parts = recipe!.split("**Yapılışı:**");
      if (parts.length < 2){
        parts = recipe!.split("**Hazırlanışı:**");
        if (parts.length < 2){
          return 'Talimatlar not found';
        }
      }
    }

    List<String> instructions = parts[1].split('\n');

    List<String> numberedInstructions = instructions.where((instr) => RegExp(r'^\d+\..*').hasMatch(instr)).toList();

    _totalTalimatlar = numberedInstructions.length;
    if (step > numberedInstructions.length || step <= 0) {
      return 'No instruction found for step $step';
    }
    return numberedInstructions[step - 1];
  }

  List<TextSpan> _parseRecipe(String recipeText) {
    List<TextSpan> children = [];

    List<String> parts = recipeText.split('**');

    for (int i = 0; i < parts.length; i++) {
      if (i.isEven) {
        children.add(TextSpan(text: parts[i]));
      } else {
        children.add(TextSpan(text: parts[i], style: const TextStyle(fontWeight: FontWeight.bold)));
      }
    }

    return children;
  }
}
