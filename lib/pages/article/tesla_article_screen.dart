import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/tesla_news/cubit/tesla_news_state.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class TeslaArticleScreen extends StatefulWidget {
  const TeslaArticleScreen({Key? key}) : super(key: key);

  @override
  State<TeslaArticleScreen> createState() => _TeslaArticleScreenState();
}

class _TeslaArticleScreenState extends State<TeslaArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<TeslaNewsCubit>().getTeslaNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeslaNewsCubit, TeslaNewsState>(
      bloc: getIt.get<TeslaNewsCubit>(),
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
