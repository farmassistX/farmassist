import 'package:farmassist/src/views/ui/page2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:farmassist/src/views/ui/homePage.dart';
import 'package:farmassist/src/business_logic/firebase/fireStore/storeData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppLayout());
}

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 1;
  final List pages = [
    CameraPage(),
    HomeScreen(),
    null
  ];

  void _onItemTapped(int index){
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
        )
    );
  }
}
