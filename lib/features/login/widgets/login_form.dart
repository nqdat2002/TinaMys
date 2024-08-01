import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinamys/bloc/form/form_submission_status.dart';
import 'package:tinamys/bloc/login/login_event.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController(text: "superadminn");
  TextEditingController passwordController = TextEditingController(text: "123123");
  bool _passwordVisible = true;
  bool _enable = false;
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          color: Colors.black54,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void _showLoading() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideLoading() {
    _overlayEntry?.remove();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _enable = false;
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Text(
              "Email hoặc Tên tài khoản",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintText: "Nhập Email"),
                    onChanged: (data) {
                      if (usernameController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        _enable = false;
                      } else {
                        _enable = true;
                      }
                      setState(() {});
                      context
                          .read<LoginBloc>()
                          .add(LoginUserNameChanged(username: data));
                    },
                  );
                },
              )),
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Text(
              "Mật Khẩu",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return TextFormField(
                  obscureText: !_passwordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Nhập Mật khẩu',
                    focusColor: Colors.blueAccent,
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (data) {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      _enable = false;
                    } else {
                      _enable = true;
                    }
                    setState(() {});
                    context
                        .read<LoginBloc>()
                        .add(LoginPasswordChanged(password: data));
                  },
                  validator: (data) {
                    // RegExp regex = RegExp(
                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    var passNonNullValue = data ?? "";
                    if (passNonNullValue.isEmpty) {
                      return ("Vui lòng nhập mật khẩu");
                    } else if (passNonNullValue.length < 6) {
                      return ("Mật khẩu tối thiếu 6 ký tự");
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text(
                'Quên mật khẩu',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.formStatus is FormSubmitting
                      ? ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Đăng Nhập',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                      : ElevatedButton(
                          onPressed: _enable
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                        LoginSubmitted(
                                            username: usernameController.text,
                                            password: passwordController.text));
                                    _showLoading();
                                    // Simulate a network request
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    _hideLoading();
                                    // print(usernameController.text);
                                    // print(passwordController.text);
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Đăng Nhập',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        );
                },
              )),
        ],
      ),
    );
  }
}
