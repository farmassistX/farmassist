import 'package:flutter/material.dart';

class FarmManagementPage extends StatefulWidget {
  @override
  _FarmManagementPageState createState() => _FarmManagementPageState();
}

class _FarmManagementPageState extends State<FarmManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text("Home"),
      ),
    );
  }
}
