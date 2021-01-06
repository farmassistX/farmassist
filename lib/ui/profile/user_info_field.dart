import 'package:farmassist/app_theme.dart';
import 'package:farmassist/data/user/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoField extends StatelessWidget {
  const UserInfoField({Key key, this.name, this.icon, this.field})
      : super(key: key);

  final String name;
  final IconData icon;
  final String field;

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
                    Expanded(child: _buildFieldValue(context, field)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildFieldValue(BuildContext context, String field) {
    if (field == 'displayName') {
      return Text(
        RepositoryProvider.of<UserRepository>(
          context,
          listen: false,
        ).displayName,
        style: AppTheme.headline6,
      );
    } else {
      return Text(
        RepositoryProvider.of<UserRepository>(
          context,
          listen: false,
        ).email,
        style: AppTheme.headline6,
      );
    }
  }
}
