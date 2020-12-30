import 'package:farmassist/app_theme.dart';
import 'package:farmassist/bloc/authentication/authentication.dart';
import 'package:farmassist/data/authentication/authentication_repository.dart';
import 'package:farmassist/data/farm/resources/repository.dart';
import 'package:farmassist/ui/farm/news/bloc/nBloc.dart';
import 'package:farmassist/ui/farm/news/bloc/nEvent.dart';
import 'package:farmassist/ui/farm/news_details/bloc/dBloc.dart';
import 'package:farmassist/ui/home_page.dart';
import 'package:farmassist/ui/login/login_page.dart';
import 'package:farmassist/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                authenticationRepository: _authenticationRepository,
              );
            },
          ),
          BlocProvider<NewsBloc>(
            create: (context) {
              return NewsBloc(
                repository: Repository(),
              )..add(Fetch(type: 'Science'));
            },
          ),
          BlocProvider<DetailBloc>(
            create: (context) {
              return DetailBloc(null);
            },
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<AuthenticationRepository>.value(
              value: _authenticationRepository,
            ),
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmassist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.nearlyGreen,
        appBarTheme: AppTheme.appBarTheme,
        scaffoldBackgroundColor: AppTheme.background,
        textTheme: AppTheme.textTheme,
        inputDecorationTheme: AppTheme.inputDecorationTheme,
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
