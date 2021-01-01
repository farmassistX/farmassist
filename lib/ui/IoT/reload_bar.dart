import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/IoT/reload_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReloadBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 24.0, right: 24.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Icon(
                Icons.autorenew,
                color: AppTheme.darkText,
                size: 28,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _buildReloadTime(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _buildReloadTime(BuildContext context) {
    String time = context.watch<ReloadTime>().reloadTime;

    return Text(
      time == null ? 'No update' : 'Last update: $time',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: AppTheme.fontName,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.5,
        color: AppTheme.lightText,
      ),
    );
  }
}
