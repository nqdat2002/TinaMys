import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';
import 'package:tinamys/repository/user/user_repository.dart';
import 'app.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/navigation/navigation_bloc.dart';
import 'bloc/signup/signup_bloc.dart';
import 'bloc/theme/theme_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'TinaMYS',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
  //       useMaterial3: true,
  //     ),
  //     onGenerateRoute: (settings) => generateRoute(settings),
  //     home: RepositoryProvider(
  //       create: (context) => AuthenticationRepository(),
  //       child: const LoginPage(),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(
                  authenticationRepository: _authenticationRepository,
                  userRepository: _userRepository,
                ),
          ),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
          BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(authRepository: _authenticationRepository),
          ),
          BlocProvider<SignupBloc>(
            create: (context) =>
                SignupBloc(authRepository: _authenticationRepository),
          )
        ],
        child: const AppView(),
      ),
    );
  }
}
