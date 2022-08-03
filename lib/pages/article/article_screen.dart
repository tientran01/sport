import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/pages/article/articles.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.animation!.addListener(() {
      setState(() {
        selectIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: TextView(
          text: AppStrings.news,
          fontSize: Constants.size17,
        ),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: AppColor.black,
          tabs: [
            _buildTabBarItem(text: Application.appleParamValue, index: 0),
            _buildTabBarItem(text: Application.bitcoinParamValue, index: 1),
            _buildTabBarItem(text: Application.teslaParamValue, index: 2),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          BlocProvider<ArticleBloc>(
            create: (context) => ArticleBloc()
              ..add(
                GetEverythingEvent(
                  nameCategory: Application.appleParamValue,
                ),
              ),
            child: const Articles(),
          ),
          BlocProvider<ArticleBloc>(
            create: (context) => ArticleBloc()
              ..add(
                GetEverythingEvent(
                  nameCategory: Application.bitcoinParamValue,
                ),
              ),
            child: const Articles(),
          ),
          BlocProvider<ArticleBloc>(
            create: (context) => ArticleBloc()
              ..add(
                GetEverythingEvent(
                  nameCategory: Application.teslaParamValue,
                ),
              ),
            child: const Articles(),
          ),
        ],
      ),
    );
  }

  Tab _buildTabBarItem({required String text, required int index}) {
    return Tab(
      child: TextView(
        text: text,
        textColor: selectIndex == index ? AppColor.arsenic : AppColor.gainsboro,
      ),
    );
  }
}
