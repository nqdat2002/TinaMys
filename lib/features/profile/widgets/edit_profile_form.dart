import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
  final Map<dynamic, dynamic> profile;
  const EditProfileForm({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final bool _editable = false;

  // Map<String, dynamic>? _profile;
  // late UserServices userServices;

  // Future<void> fetchData() async {
  //   dynamic response = await userServices.getUserProfile();
  //   setState(() {
  //     _profile = response['data'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    if (widget.profile['name']!= null){
      nameController.text = widget.profile['name'];
    }

    
    // userServices = UserServices();
    // fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            widget.profile['avatar']!,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png?20200919003010",
                width: 60.0,
                height: 60.0,
              );
            },
            width: 60.0,
            height: 60.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
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
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Họ và tên"),
            onChanged: (data) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
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
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Tên tài khoản"),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: const Text(
            "Số Điện thoại",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
            controller: phoneNumberController,
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Số điện thoại"),
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
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Email"),
          ),
        ),
      ]),
    );
  }
}
