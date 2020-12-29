import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/farm/news/bloc/nBloc.dart';
import 'package:farmassist/ui/farm/news/bloc/nEvent.dart';
import 'package:farmassist/ui/farm/news_details/bloc/dBloc.dart';
import 'package:farmassist/ui/home_page.dart';
import 'package:farmassist/ui/login/login_page.dart';
import 'package:farmassist/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/bloc/authentication_bloc.dart';
import 'data/authentication/repositories/authentication_repository.dart';
import 'data/farm/resources/repository.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) =>
              NewsBloc(repository: Repository())..add(Fetch(type: 'Science')),
        ),
        BlocProvider<DetailBloc>(create: (context) => DetailBloc(null)),
      ],
      child: RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
          ),
          child: AppView(),
        ),
      ),
    );
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
        primarySwatch: Colors.green,
        textTheme: AppTheme.textTheme,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
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
