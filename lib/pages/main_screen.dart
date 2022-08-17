import 'package:sport_app/pages/article/article_screen.dart';
import 'package:sport_app/pages/your_article/your_article_screen.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const ArticleScreen(),
    const YourArticleScreen(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.gainsboro.withOpacity(0.3),
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        backgroundColor: AppColor.black,
        currentIndex: selectIndex,
        onTap: _onTapItem,
        items: [
          bottomNavigationBarItem(
            iconPath: AppResource.home,
            index: 0,
            label: AppStrings.home,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.compass,
            index: 1,
            label: AppStrings.news,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.create,
            index: 2,
            label: AppStrings.createNewArticle,
          ),
          bottomNavigationBarItem(
            iconPath: AppResource.setting,
            index: 3,
            label: AppStrings.setting,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem({
    required String iconPath,
    required int index,
    String? label,
  }) =>
      BottomNavigationBarItem(
        icon: Image.asset(
          iconPath,
          width: Constants.size27,
          color: selectIndex == index
              ? AppColor.white
              : AppColor.gainsboro.withOpacity(0.3),
        ),
        label: label ?? "",
      );

  void _onTapItem(int index) {
    setState(
      () => selectIndex = index,
    );
  }
}
