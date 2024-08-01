import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  bool _enable = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _enable = false;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              "Họ và tên",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: "Họ và tên"),
              onChanged: (data) {
                if (confirmPasswordController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty || emailController.text.isEmpty) {
                  _enable = false;
                } else {
                  _enable = true;
                }
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Text(
              "Tên tài khoản",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: "Tên tài khoản"),
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Text(
              "Email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: "Email"),
            ),
          ),
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
            child: TextFormField(
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
                if (confirmPasswordController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty || emailController.text.isEmpty) {
                  _enable = false;
                } else {
                  _enable = true;
                }
                setState(() {});
              },
              validator: (data) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                var passNonNullValue = data ?? "";
                if (passNonNullValue.isEmpty) {
                  return ("Vui lòng nhập mật khẩu");
                } else if (passNonNullValue.length < 6) {
                  return ("Mật khẩu tối thiếu 6 ký tự");
                }
                // else if (!regex.hasMatch(passNonNullValue)) {
                //   return ("Mật khẩu yêu cầu các ký tự chữ, ký tự số và ký tự đặc biệt");
                // }
                return null;
              },
            ),
          ),

          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: const Text(
              "Nhập lại Mật Khẩu",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              obscureText: !_confirmPasswordVisible,
              controller: confirmPasswordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),

                hintText: 'Nhập lại Mật khẩu',
                focusColor: Colors.blueAccent,
                suffixIcon: IconButton(
                  icon: Icon(_confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),

              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onChanged: (data) {
                if (confirmPasswordController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty || emailController.text.isEmpty) {
                  _enable = false;
                } else {
                  _enable = true;
                }
                setState(() {});
              },
              validator: (data) {
                var passNonNullValue = data ?? "";
                if (passNonNullValue.isEmpty) {
                  return ("Vui lòng nhập lại mật khẩu");
                } else if (passNonNullValue != passwordController.text) {
                  return ("Mật khẩu nhập lại không khớp");
                }
                // else if (!regex.hasMatch(passNonNullValue)) {
                //   return ("Mật khẩu yêu cầu các ký tự chữ, ký tự số và ký tự đặc biệt");
                // }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                onPressed: _enable
                    ? () {
                  if (_formKey.currentState!.validate()) {
                    // print(nameController.text);
                    // print(usernameController.text);
                    // print(emailController.text);
                    // print(passwordController.text);
                    // print(confirmPasswordController.text);
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
                  'Đăng kí',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              )
          ),
        ],
      ),
    );
  }
}
