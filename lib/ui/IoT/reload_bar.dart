import 'package:farmassist/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReloadBar extends StatefulWidget {
  @override
  _ReloadBarState createState() => _ReloadBarState();
}

class _ReloadBarState extends State<ReloadBar> {
  String _now = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Row(
          children: <Widget>[
            InkWell(
              highlightColor: AppTheme.notWhite,
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              onTap: () {
                setState(() {
                  _now = DateFormat.yMd().add_jm().format(DateTime.now());
                });
              },
              child: SizedBox(
                child: Icon(
                  Icons.autorenew,
                  color: AppTheme.darkText,
                  size: 28,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Last update: $_now',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: AppTheme.lightText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
