import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';
import 'package:tinamys/routers/router.dart';
import 'package:tinamys/theme/theme.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    ThemeData? apptheme;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is SelectedTheme) {
          apptheme = state.themeType != ThemeType.Light
              ? AppTheme.lightTheme
              : AppTheme.darkTheme;
        }
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: apptheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: Routes.getRoute(),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil('/home', (route) => false);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil('/login', (route) => false);
                    break;
                  case AuthenticationStatus.unknown:
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}