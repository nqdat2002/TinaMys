import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinamys/bloc/login/login_bloc.dart';
import 'package:tinamys/features/login/widgets/login_form.dart';
import 'package:tinamys/repository/auth/auth_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TinaMys"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(authRepository: context.read<AuthenticationRepository>());
          },
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Mapping your success",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const LoginForm(),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Hoặc",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print("tap to login with google");
                      }
                    },
                    child: Image.asset(
                      "assets/images/google_PNG19635.png",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                          text: "Bạn chưa có tài khoản? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              color: Colors.black)),
                      TextSpan(
                          text: "Đăng kí",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed("/signup");
                            },
                          style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              color: Colors.blueAccent))
                    ]),
                    textAlign: TextAlign.left),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/intro');
                  },
                  child: const Text(
                    'Được cung cấp bởi Tinasoft',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "v1.6.0",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
