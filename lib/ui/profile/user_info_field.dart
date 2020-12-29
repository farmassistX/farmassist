import 'package:farmassist/app_theme.dart';
import 'package:flutter/material.dart';

class UserInfoField extends StatelessWidget {
  const UserInfoField({Key key, this.name, this.icon, this.value})
      : super(key: key);

  final String name;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  name,
                  style: AppTheme.headline6,
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                      child: Icon(icon),
                    ),
                    Expanded(
                      child: Text(
                        value,
                        style: AppTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
