import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/IoT/IoT_monitoring_page.dart';
import 'package:farmassist/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:farmassist/ui/bottom_navigation_bar/tab_icon_data.dart';
import 'package:farmassist/ui/diseases/disease_detection_page.dart';
import 'package:farmassist/ui/farm/farm_management_page.dart';
import 'package:farmassist/ui/profile/user_profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;
    tabBody = FarmManagementPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomNavBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomNavBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomNavBar(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (!mounted) return;
            switch (index) {
              case 0:
                setState(() {
                  tabBody = FarmManagementPage();
                });
                break;
              case 1:
                setState(() {
                  tabBody = IoTMonitoringPage();
                });
                break;
              case 2:
                setState(() {
                  tabBody = DiseaseDetectionPage();
                });
                break;
              case 3:
                setState(() {
                  tabBody = UserProfilePage();
                });
                break;
              default:
                break;
            }
          },
        ),
      ],
    );
  }
}
