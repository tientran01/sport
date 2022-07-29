import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/pages/article/create_new_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation offset;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    offset = Tween(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.yourArticle,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState
              ?.pushNamed(AppRouteName.main);
        },
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 0,
            child: FloatingActionButton(
              backgroundColor: AppColor.black,
              onPressed: () {
                animationController.reverse();
              },
              child: Image.asset(
                AppResource.create,
                width: Constants.size27,
                color: AppColor.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: offset as Animation<Offset>,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.ghostWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constants.size30),
                    topRight: Radius.circular(Constants.size30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.darkSilver.withOpacity(0.1),
                      blurRadius: Constants.size5,
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size30,
                  vertical: Constants.size25,
                ),
                height: size.height * 2 / 3,
                width: size.width,
                child: CreateNewArticle(
                  onTap: () {
                    animationController.forward();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
