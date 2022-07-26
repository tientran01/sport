import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/pages/article/article_screen.dart';
import 'package:sport_app/pages/your_article/your_article_screen.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.gainsboro,
              offset: Offset(0, 0),
              blurRadius: 40,
            )
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColor.viridianGreen,
          unselectedItemColor: AppColor.black.withOpacity(0.1),
          type: BottomNavigationBarType.fixed,
          // backgroundColor: AppColor.white,
          currentIndex: selectIndex,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          onTap: _onTapItem,
          items: [
            bottomNavigationBarItem(
              iconPath: AppResource.home,
              index: 0,
              label: S.of(context).home,
            ),
            bottomNavigationBarItem(
              iconPath: AppResource.compass,
              index: 1,
              label: S.of(context).news,
            ),
            bottomNavigationBarItem(
              iconPath: AppResource.create,
              index: 2,
              label: S.of(context).createNewArticle,
            ),
            bottomNavigationBarItem(
              iconPath: AppResource.setting,
              index: 3,
              label: S.of(context).setting,
            ),
          ],
        ),
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
              ? AppColor.viridianGreen
              : AppColor.black.withOpacity(0.1),
        ),
        label: label ?? "",
      );

  void _onTapItem(int index) {
    setState(
      () => selectIndex = index,
    );
  }
}
