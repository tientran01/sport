import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/detail_app_bar.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class DetailArticleScreen extends StatelessWidget {
  const DetailArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Article? article = ModalRoute.of(context)?.settings.arguments as Article?;
    return BlocBuilder<ArticleBloc, ArticleState>(
        bloc: getIt.get<ArticleBloc>(),
        builder: (context, state) {
          return Scaffold(
            appBar: DetailAppBar(
              article: article,
              onTap: () {
                NavigationService.navigatorKey.currentState?.pop();
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size30,
                  vertical: Constants.size25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Constants.size10),
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.size10,
                        vertical: Constants.size5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.gainsboro,
                        borderRadius: BorderRadius.circular(Constants.size20),
                      ),
                      child: TextView(
                        text: article?.categories?.first,
                        textColor: AppColor.arsenic,
                        fontSize: Constants.size15,
                      ),
                    ),
                    TextView(
                      text: article?.title,
                      textColor: AppColor.black,
                      fontSize: Constants.size20,
                      fontWeight: FontWeight.w800,
                      isMaxLine: true,
                      lineNumber: 4,
                    ),
                    SizedBox(
                      height: Constants.size25,
                    ),
                    TextView(
                      text: article?.description,
                      textColor: AppColor.darkSilver,
                      fontSize: Constants.size15,
                      isMaxLine: true,
                      lineNumber: 6,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
