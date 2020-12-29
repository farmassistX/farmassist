import 'package:flutter/material.dart';
import 'package:farmassist/app_theme.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class PlantingMenu extends StatefulWidget {
  @override
  _PlantingMenuState createState() => _PlantingMenuState();
}

class _PlantingMenuState extends State<PlantingMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        appBar: GFAppBar(
          leading:  GFIconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          title: Text("Manage Planting"),
          backgroundColor: AppTheme.dark_grey,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Choose an option:"),
            ],
          )
        )
      ),
    );
  }
}
