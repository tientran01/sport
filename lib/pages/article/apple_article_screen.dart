import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/component.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/apple_news/cubit/apple_news_state.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class AppleArticleScreen extends StatefulWidget {
  const AppleArticleScreen({Key? key}) : super(key: key);

  @override
  State<AppleArticleScreen> createState() => _AppleArticleScreenState();
}

class _AppleArticleScreenState extends State<AppleArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<AppleNewsCubit>().getAppleNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppleNewsCubit, AppleNewsState>(
      bloc: getIt.get<AppleNewsCubit>(),
      builder: (context, state) {
        switch (state.status) {
          case NewsStatus.error:
            TextView(
              text: AppStrings.error,
              fontSize: Constants.size20,
              fontWeight: FontWeight.w700,
            );
            break;
          case NewsStatus.success:
            if (state.articles?.isEmpty == true) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            }
            return ListView.builder(
              itemCount: state.articles?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.size15,
                  ),
                  child: ArticleItem(
                    article: state.articles?[index],
                    onTap: () {
                      NavigationService.navigatorKey.currentState?.pushNamed(
                        AppRouteName.detailArticle,
                        arguments: state.articles?[index],
                      );
                    },
                  ),
                );
              },
            );
          default:
        }
        return const CircularLoading();
      },
    );
  }
}
