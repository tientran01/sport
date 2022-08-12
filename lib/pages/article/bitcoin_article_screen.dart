import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class BitcoinArticleScreen extends StatefulWidget {
  const BitcoinArticleScreen({Key? key}) : super(key: key);

  @override
  State<BitcoinArticleScreen> createState() => _BitcoinArticleScreenState();
}

class _BitcoinArticleScreenState extends State<BitcoinArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<ArticleBloc>().add(
          const GetEverythingEvent(
            nameCategory: Application.bitcoinParamValue,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: getIt.get<ArticleBloc>(),
      builder: (context, state) {
        if (state is ArticleLoading) {
          return const CircularLoading();
        }
        if (state is ArticleLoader) {
          if (state.articles == null) {
            return Center(
              child: Image.asset(AppResource.empty),
            );
          } else {
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
          }
        }
        return Center(
          child: TextView(
            text: AppStrings.error,
            fontSize: Constants.size15,
            fontWeight: FontWeight.w700,
          ),
        );
      },
    );
  }
}
