import 'package:farmassist/ui/home_page.dart';
import 'package:farmassist/ui/page2.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 1;
  final List pages = [CameraPage(), HomeScreen(), null];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Farmassist'),
          ),
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
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
            onTap: _onItemTapped,
            elevation: 1,
          ),
        ));
  }
}
