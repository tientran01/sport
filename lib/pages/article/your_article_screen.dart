import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/slide_route/slide_bottom_route.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/create_new_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.yourArticle,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.black,
        onPressed: () {
          NavigationService.navigatorKey.currentState?.push(
            SlideBottomRoute(
              page: const CreateNewArticle(),
            ),
          );
        },
        child: Image.asset(
          AppResource.create,
          width: Constants.size27,
          color: AppColor.white,
        ),
      ),
      body: BlocBuilder<YourArticleBloc, YourArticleState>(
        bloc: getIt.get<YourArticleBloc>(),
        builder: (context, state) {
          return Center(
            child: TextView(
              text: state.title,
              fontSize: Constants.size15,
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ),
    );
  }
}
