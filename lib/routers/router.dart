
import 'package:flutter/material.dart';
import 'package:tinamys/features/profile/screens/edit_profile_screen.dart';
import 'package:tinamys/features/signup/screens/signup_screen.dart';
import 'package:tinamys/features/tinamys_app.dart';
import '../features/login/screens/login_screen.dart';
import '../features/splash/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LoginPage()
      );
    case SignupPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupPage()
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

class Routes{
  static Map<String,WidgetBuilder> getRoute(){
    return  <String, WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/login': (_) => const LoginPage(),
      '/signup': (_) => const SignupPage(),
      '/home': (_) => const TinaMysApp(),
      '/edit_profile': (_) => const EditProfilePage(),
    };
  }
}