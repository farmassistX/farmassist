import 'package:farmassist/app_theme.dart';
import 'package:flutter/material.dart';

class TabAppBar extends StatefulWidget {
  const TabAppBar({Key key, this.scrollController, this.title})
      : super(key: key);

  final ScrollController scrollController;
  final String title;

  @override
  _TabAppBarState createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar> {
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset >= 24) {
        if (_appBarOpacity != 1.0) {
          setState(() {
            _appBarOpacity = 1.0;
          });
        }
      } else if (widget.scrollController.offset >= 0 &&
          widget.scrollController.offset <= 24) {
        if (_appBarOpacity != widget.scrollController.offset / 24) {
          setState(() {
            _appBarOpacity = widget.scrollController.offset / 24;
          });
        }
      } else if (widget.scrollController.offset <= 0) {
        if (_appBarOpacity != 0.0) {
          setState(() {
            _appBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white.withOpacity(_appBarOpacity),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.4 * _appBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * _appBarOpacity,
                    bottom: 12 - 8.0 * _appBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * _appBarOpacity,
                            letterSpacing: 1.2,
                            color: AppTheme.darkerText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
