import 'package:ai_app_jam/tarifPage.dart';
import 'package:flutter/material.dart';

import 'addPage.dart';
import 'filterPage.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _selectedIndex = 1; // Index of the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 20),
            Text(
              "AI APP",
              style: TextStyle(
                color: Colors.white,
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
          : buildBlankPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Tarifler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add New', // Blank label
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
}
