import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinamys/bloc/navigation/navigation_event.dart';

import '../../bloc/navigation/navigation_bloc.dart';
import '../../bloc/navigation/navigation_state.dart';

class BottomNavigationBarWidget extends StatelessWidget{
  final PageController controller;

  const BottomNavigationBarWidget({Key? key, required this.controller}):
      super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state){
        if (state is Opened){
          return BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: state.pageIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            // unselectedItemColor: Theme.of(context).disabledColor,
            onTap: (pageIndex){
              BlocProvider.of<NavigationBloc>(context).add(Navigate(pageIndex: pageIndex));
              controller.animateToPage(pageIndex, duration: const Duration(microseconds: 300), curve: Curves.linear);

            },
            items: <BottomNavigationBarItem>[
              _buildBottomNavigationBarItem("home", state.pageIndex == 0),
              _buildBottomNavigationBarItem("company", state.pageIndex == 1),
              _buildBottomNavigationBarItem("calendar", state.pageIndex == 2),
              _buildBottomNavigationBarItem("personal", state.pageIndex == 3),
              _buildBottomNavigationBarItem("profile", state.pageIndex == 4),
            ],
            elevation: 5,
          );
        }
        return const SizedBox();
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem (String iconName, bool isSelected){
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/navbar/$iconName.svg',
        color: isSelected ? Colors.blue : Colors.grey,
      ),
      label: _getLabel(iconName),
    );
  }

  String _getLabel(String iconName){
    switch (iconName) {
      case "home":
        return "Trang chủ";
      case "company":
        return "Công Ty";
      case "calendar":
        return "Lịch";
      case "personal":
        return "Cá nhân";
      case "profile":
        return "Tài khoản";
      default:
        return "";
    }
  }

}