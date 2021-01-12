import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/farm/planting/form_storePlanting.dart';
import 'package:farmassist/ui/farm/planting/planting_list.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:page_transition/page_transition.dart';

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
            leading: GFIconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              type: GFButtonType.transparent,
            ),
            title: Text(
              "Manage Planting",
              style: TextStyle(
                color: AppTheme.nearlyWhite,
              ),
            ),
            backgroundColor: AppTheme.pastelGreen,
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: formStorePlanting()));
                      },
                      child: GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('assets/images/planting_create.jpg'),
                        title: GFListTile(
                          titleText: 'Create Planting',
                          subtitle: Text("Record a new planting activity."),
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRightWithFade,
                                child: PlantingList()));
                      },
                      child: GFCard(
                        boxFit: BoxFit.cover,
                        image: Image.asset('assets/images/planting_view.jpg'),
                        title: GFListTile(
                          titleText: 'View Planting',
                          subtitle:
                              Text("Take a look at all your previous records."),
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
