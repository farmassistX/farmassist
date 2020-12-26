import 'package:farmassist/ui/diseases/disease_detection_page.dart';
import 'package:farmassist/ui/farm/farm_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final List pages = [DiseaseDetectionPage(), FarmManagementPage(), null];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmassist'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar:SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'Chat',
          )
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFFF9F9FB),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green[800],
        showSelectedLabels: true,
        onTap: _onItemTapped,
        elevation: 1,
      ),
    );
  }
}
