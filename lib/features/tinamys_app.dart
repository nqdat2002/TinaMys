import 'package:flutter/material.dart';
import 'package:tinamys/common/widgets/bottomNavigationBar.dart';
import 'package:tinamys/features/calendar/screens/calendar_screen.dart';
import 'package:tinamys/features/company/screens/company_screen.dart';
import 'package:tinamys/features/home/screens/home_screen.dart';
import 'package:tinamys/features/personal/screens/personal_screen.dart';
import 'package:tinamys/features/profile/screens/profile_screen.dart';

class TinaMysApp extends StatefulWidget{
  const TinaMysApp({Key? key}): super(key: key);

  @override
  State<TinaMysApp> createState() => _TinaMysAppState();
}

class _TinaMysAppState extends State<TinaMysApp>{
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(controller: _controller,),
      body: PageView(
        controller: _controller,
        children: const <Widget>[
            HomePage(),
            CompanyPage(),
            CalendarPage(),
            PersonalPage(),
            ProfilePage(),
        ],
      )
    );
  }
}