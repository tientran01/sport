import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/hot_news/cubit/hot_news_cubit.dart';
import 'package:sport_app/cubit/news/hot_news/cubit/hot_news_state.dart';
import 'package:sport_app/cubit/news/most_interested_news/cubit/most_interested_news_cubit.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class ArticleSortByName extends StatefulWidget {
  const ArticleSortByName({Key? key}) : super(key: key);

  @override
  State<ArticleSortByName> createState() => _ArticleSortByNameState();
}

class _ArticleSortByNameState extends State<ArticleSortByName> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? nameArticle = ModalRoute.of(context)?.settings.arguments as String;
    switch (nameArticle) {
      case AppStrings.hotNews:
        nameArticle = S.of(context).hotNews;
        setState(() {
          getIt.get<HotNewsCubit>().getHotNewsApi();
        });
        break;
      case AppStrings.mostInterested:
        nameArticle = S.of(context).mostInterested;
        setState(() {
          getIt.get<MostInterestedNewsCubit>().getMostInterestedNewsApi();
        });
        break;

      default:
        break;
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: nameArticle,
      ),
      body: BlocBuilder<HotNewsCubit, HotNewsState>(
        bloc: getIt.get<HotNewsCubit>(),
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
          return Center(
            child: TextView(
              text: S.of(context).error,
              fontSize: Constants.size15,
            ),
          );
        },
      ),
    );
  }
}
