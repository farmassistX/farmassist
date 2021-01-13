import 'package:farmassist/ui/farm/statistics/statistics_page1.dart';
import 'package:farmassist/ui/farm/statistics/statistics_page2.dart';
import 'package:farmassist/ui/farm/weather/statistics_weatherHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../../../app_theme.dart';

ValueNotifier valueNotifier;

class StatisticsHome extends StatefulWidget {
  @override
  _StatisticsHomeState createState() => _StatisticsHomeState();
}

class _StatisticsHomeState extends State<StatisticsHome> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page);
    });
    super.initState();
  }

  Widget _pageViewIndicator(int location) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6),
      child: Icon(Icons.lens,
          size: 14,
          color: location - 1 <= _currentPage && _currentPage < location
              ? Colors.blue[900]
              : Colors.grey[600]),
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    return Scaffold(
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
            "View Statistics",
            style: TextStyle(
              color: AppTheme.nearlyWhite,
            ),
          ),
          backgroundColor: AppTheme.pastelGreen,
        ),
        body: Column(
          children: [
            new Expanded(
              child: PageView(
                pageSnapping: true,
                controller: _pageController,
                children: [
                  StatisticsPageOne(),
                  StatisticsPage2(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _pageViewIndicator(1),
                  _pageViewIndicator(2),
                ],
              ),
            ),
          ],
        ));
  }
}
