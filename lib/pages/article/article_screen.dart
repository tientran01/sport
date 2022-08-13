import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/pages/article/apple_article_screen.dart';
import 'package:sport_app/pages/article/bitcoin_article_screen.dart';
import 'package:sport_app/pages/article/tesla_article_screen.dart';
import 'package:sport_app/pages/article/top_article_screen.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PageController? pageController;
  

  int selectIndex = 0;
  List<Category> categories = AppStrings.categories;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    tabController =
        TabController(length: categories.length, vsync: this, initialIndex: 0);
    tabController?.addListener(
      () {
        setState(() => selectIndex = tabController?.index ?? 0);
        pageController?.animateToPage(
          selectIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: TextView(
          text: AppStrings.news,
          fontSize: Constants.size17,
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.transparent,
          isScrollable: true,
          tabs: [
            _buildTabBarItem(category: categories.elementAt(0), index: 0),
            _buildTabBarItem(category: categories.elementAt(1), index: 1),
            _buildTabBarItem(category: categories.elementAt(2), index: 2),
            _buildTabBarItem(category: categories.elementAt(3), index: 3),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            selectIndex = index;
          });
        },
        children: const [
          TopArticleScreen(),
          AppleArticleScreen(),
          BitcoinArticleScreen(),
          TeslaArticleScreen(),
        ],
      ),
    );
  }

  Tab _buildTabBarItem({required Category category, required int index}) {
    return Tab(
      child: TextView(
        text: category.text,
        textColor: selectIndex == index ? AppColor.arsenic : AppColor.gainsboro,
      ),
    );
  }
}
