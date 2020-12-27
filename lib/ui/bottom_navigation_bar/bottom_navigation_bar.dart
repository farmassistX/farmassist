import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/bottom_navigation_bar/tab_clipper.dart';
import 'package:farmassist/ui/bottom_navigation_bar/tab_icon.dart';
import 'package:farmassist/ui/bottom_navigation_bar/tab_icon_data.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key, this.tabIconsList, this.onTap})
      : super(key: key);

  final Function(int index) onTap;
  final List<TabIconData> tabIconsList;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: PhysicalShape(
                color: AppTheme.white,
                elevation: 16.0,
                clipper: TabClipper(
                    radius: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: animationController,
                                curve: Curves.fastOutSlowIn))
                            .value *
                        38.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: Row(
                          children: <Widget>[
                            for (int i = 0; i < 4; ++i) _buildTabIcon(i)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Expanded _buildTabIcon(int i) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: TabIcons(
                tabIconData: widget.tabIconsList[i],
                removeAllSelect: () {
                  setRemoveAllSelection(widget.tabIconsList[i]);
                  widget.onTap(i);
                }),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.tabIconsList[i].label,
              style: AppTheme.textTheme.caption,
            ),
          )
        ],
      ),
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}
