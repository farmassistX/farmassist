import 'package:farmassist/app_theme.dart';
import 'package:farmassist/data/user/repositories/user_repository.dart';
import 'package:farmassist/ui/IoT/IoT_monitoring_page.dart';
import 'package:farmassist/ui/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:farmassist/ui/bottom_navigation_bar/tab_icon_data.dart';
import 'package:farmassist/ui/diseases/disease_detection_page.dart';
import 'package:farmassist/ui/farm/farm_management_page.dart';
import 'package:farmassist/ui/profile/user_profile_page.dart';
import 'package:farmassist/utils/message_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRepository _userRepository = UserRepository();
  MessageHandler _messageHandler;
  List<TabIconData> _tabIconsList = TabIconData.tabIconsList;
  List<Widget> _tabList = [
    FarmManagementPage(pageTitle: 'Farm Management'),
    IoTMonitoringPage(pageTitle: 'IoT Monitoring'),
    DiseaseDetectionPage(pageTitle: 'Disease Detection'),
    UserProfilePage(pageTitle: 'My Profile'),
  ];
  PageController _pageController = PageController();

  @override
  void initState() {
    _messageHandler = MessageHandler(_userRepository)..generateToken();
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(
          value: _userRepository,
        ),
        RepositoryProvider<MessageHandler>.value(
          value: _messageHandler,
        ),
      ],
      child: Container(
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
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
