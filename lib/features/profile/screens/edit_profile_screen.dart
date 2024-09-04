import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _editable = false;

  @override
  void initState() {
    _editable = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map profile = ModalRoute.of(context)!.settings.arguments as Map;
      nameController.text = profile['fullName'];
      usernameController.text = profile['username'];
      phoneNumberController.text = "0948669343"; 
      emailController.text = profile['email'];
    });
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
    final Map profile = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Thông tin cá nhân", style: TextStyle(color: Theme.of(context).colorScheme.onBackground),),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // _editable ? 
          Padding(
            padding: const EdgeInsets.all(10.0), 
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent,), 
              onPressed: (){
                setState(() {
                  _editable = !_editable;
                });
              }
            )
          )
          // : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: editProfileForm(context, profile, nameController, usernameController, emailController, phoneNumberController),
      )
    );
  }

  // fill to form that can edit or not. Can be editable if you checked to edit icon!
  Form editProfileForm(BuildContext context, Map<dynamic, dynamic> profile, 
    TextEditingController nController,
    TextEditingController uController,
    TextEditingController eController,
    TextEditingController pController
  ){
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            profile['avatar']!,
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
            // initialValue: profile['fullName']!,
            controller: nController,
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Họ và tên"),
            onChanged: (data) {
              // if (_editable){
              //   nameController.text = data;
              // }
              setState(() {

              });
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
            // initialValue: profile['username']!,
            controller: uController,
            enabled: false,
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
            // initialValue: "0948669343",
            controller: pController,
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
            // initialValue: profile['email'],
            controller: eController,
            enabled: _editable,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: "Email"),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          alignment: Alignment.centerLeft,
          child: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/forgot-password');
              },
              child: const Text(
                'Quên mật khẩu',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],) 
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Lưu',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )
          )
        ),
      ]),
    );
  }
}