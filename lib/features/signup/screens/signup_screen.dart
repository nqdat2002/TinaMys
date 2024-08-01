import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tinamys/features/signup/widgets/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const String routeName = "/signup";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

        leading: IconButton(
          icon: Image.asset('assets/images/back.png', height: 20, width: 20,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                "Đăng ký tài khoản",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SignupForm(),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Bạn đã có tài khoản? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            color: Colors.black)),
                    TextSpan(
                        text: "Đăng nhập",
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
                        },
                        style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            color: Colors.blueAccent))
                  ]),
                  textAlign: TextAlign.left),
            ),
            const SizedBox(height: 20,),

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
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
