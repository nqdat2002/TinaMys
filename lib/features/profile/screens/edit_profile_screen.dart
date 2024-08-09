import 'package:flutter/material.dart';
import 'package:tinamys/features/profile/widgets/edit_profile_form.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage>{
  
  @override
  Widget build(BuildContext context) {
    final Map my_profile = ModalRoute.of(context)!.settings.arguments as Map;
    
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
          Padding(padding: EdgeInsets.all(10.0), child: Icon(Icons.edit, color: Colors.blueAccent,),)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: EditProfileForm(profile: my_profile),
      )
    );
  }
}