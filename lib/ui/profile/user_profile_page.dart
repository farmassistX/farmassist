import 'package:farmassist/app_theme.dart';
import 'package:farmassist/bloc/authentication/authentication.dart';
import 'package:farmassist/ui/profile/avatar.dart';
import 'package:farmassist/ui/profile/user_info_field.dart';
import 'package:farmassist/ui/widgets/tab_page.dart';
import 'package:farmassist/utils/message_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends TabPage {
  const UserProfilePage({Key key, @required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _UserProfilePagePageState createState() => _UserProfilePagePageState();
}

class _UserProfilePagePageState extends TabPageState<UserProfilePage> {
  @override
  void initState() {
    tabListView.add(Avatar());
    tabListView.add(UserInfoField(
      name: 'Name',
      icon: Icons.account_circle,
      field: 'displayName',
    ));
    tabListView.add(UserInfoField(
      name: 'Email',
      icon: Icons.email,
      field: 'email',
    ));
    tabListView.add(_LogOutButton());
    super.initState();
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: SizedBox(
          height: 45,
          width: 200,
          child: RaisedButton(
            child: const Text(
              'LOG OUT',
              style: AppTheme.bodyText1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: const Color(0xFFFFD600),
            onPressed: () async {
              await context.read<MessageHandler>().deleteToken();
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ),
      ),
    );
  }
}
