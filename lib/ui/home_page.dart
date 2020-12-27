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
  List<TabIconData> _tabIconsList = TabIconData.tabIconsList;
  List<Widget> _tabList = [
    FarmManagementPage(pageTitle: 'Farm Management'),
    IoTMonitoringPage(pageTitle: 'IoT Monitoring'),
    DiseaseDetectionPage(pageTitle: 'Plant Disease Detection'),
    UserProfilePage(pageTitle: 'My Profile'),
  ];
  PageController _pageController = PageController();

  @override
  void initState() {
    _tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    _tabIconsList[0].isSelected = true;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _tabList,
            ),
            Column(
              children: <Widget>[
                const Expanded(
                  child: SizedBox(),
                ),
                BottomNavBar(
                    tabIconsList: _tabIconsList,
                    onTap: (int i) {
                      _pageController.jumpToPage(i);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
