import 'package:sport_app/pages/chat/chat_screen.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/profile/profile_screen.dart';
import 'package:sport_app/pages/shopping/shopping_screen.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:flutter/material.dart';
import '../resource/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0;
  List<Widget> bottomTab = [
    const HomeScreen(),
    const ChatScreen(),
    const ShoppingScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomTab.elementAt(selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 0.00,
        backgroundColor: Colors.transparent,
        currentIndex: selectIndex,
        onTap: _onTapItem,
        items: [
          bottomNavigationBarItem(
            iconPath: AppResource.home,
            index: 0,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.chat,
            index: 1,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.shoppingBag,
            index: 2,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.profile,
            index: 3,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem({
    required String iconPath,
    required int index,
  }) =>
      BottomNavigationBarItem(
        icon: Image.asset(
          iconPath,
          width: Constants.sizeIcon,
          color: selectIndex == index ? AppColor.h413F42 : AppColor.hDDDDDD,
        ),
        label: "",
      );

  void _onTapItem(int index) {
    setState(
      () {
        selectIndex = index;
      },
    );
  }
}
