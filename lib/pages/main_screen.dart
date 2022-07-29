import 'package:sport_app/pages/article/article_screen.dart';
import 'package:sport_app/pages/article/your_article_screen.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/profile/profile_screen.dart';
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
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          HomeScreen(),
          ArticleScreen(),
          YourArticleScreen(),
          ProfileScreen()
        ],
        onPageChanged: (pageIndex) {
          pageChanged(pageIndex);
          selectIndex = pageIndex;
        },
      ),
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
            iconPath: AppResource.compass,
            index: 1,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.create,
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
          width: Constants.size27,
          color: selectIndex == index ? AppColor.arsenic : AppColor.gainsboro,
        ),
        label: "",
      );

  void _onTapItem(int index) {
    setState(
      () {
        selectIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  void pageChanged(int pageIndex) {
    setState(() {
      selectIndex = pageIndex;
    });
  }
}
