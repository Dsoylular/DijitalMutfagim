import 'package:flutter/material.dart';

import 'addPage.dart';
import 'filterPage.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _selectedIndex = 1; // Index of the selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 20),
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
          ? _buildTariflerimPage()
          : buildBlankPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tariflerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on), // You can change this to any other icon
            label: '', // Blank label
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTariflerimPage() {
    // Current design of Tariflerim page
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/image1_0.jpg', // Path to your image asset
        ),
        Positioned(
          bottom: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white, // Changed color to white
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Tariflerim",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
