import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/show_alert_dialog.dart';
import 'package:sport_app/component/slide_route/slide_bottom_route.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/timeago_helper.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/your_article/create_new_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen> {
  String? selection;
  @override
  void initState() {
    super.initState();
    getIt.get<YourArticleBloc>().add(SortYourArticleByDateEvent());
  }

  void selectionPopMenuItem(String value) {
    setState(() {
      selection = value;
    });
    switch (selection) {
      case '1':
        getIt.get<YourArticleBloc>().add(SortYourArticleByAlphabetEvent());
        break;
      case '2':
        getIt.get<YourArticleBloc>().add(FilterYourArticleByDateEvent());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: local.yourArticle,
        isPop: false,
        rightIconPath: AppResource.more,
        onSelected: (String value) {
          selectionPopMenuItem(value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.viridianGreen,
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
          if (state is YourArticleLoading) {
            return const CircularLoading();
          }
          if (state is YourArticleLoader) {
            if (state.yourArticles == null ||
                state.yourArticles?.isEmpty == true) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            } else {
              return ListView.builder(
                itemCount: state.yourArticles?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      NavigationService.navigatorKey.currentState?.pushNamed(
                        AppRouteName.editYourArticle,
                        arguments: state.yourArticles?.elementAt(index),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.size10,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(Constants.size10),
                        margin:
                            EdgeInsets.symmetric(vertical: Constants.size10),
                        decoration: BoxDecoration(
                          color: AppColor.viridianGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Constants.size10),
                        ),
                        child: Dismissible(
                          background: Container(
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: AppColor.bangladeshGreen.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(
                                Constants.size10,
                              ),
                            ),
                            child: SizedBox(
                              child: Image.asset(
                                AppResource.delete,
                                width: Constants.size40,
                              ),
                            ),
                          ),
                          key: ValueKey(index),
                          confirmDismiss: (DismissDirection direction) async {
                            return await ShowAlertDialog.showAlertDialog(
                              context: context,
                              title: local.areYouSureDelete,
                              defaultActionText: local.deleteNow,
                              onPressed: () {
                                getIt.get<YourArticleBloc>().add(
                                      DeleteYourArticleEvent(
                                        id: state.yourArticles
                                            ?.elementAt(index)
                                            .id,
                                      ),
                                    );
                                NavigationService.navigatorKey.currentState
                                    ?.pop();
                              },
                            );
                          },
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomImage(
                                        imageUrl: AppNetwork.imageAvatar,
                                        width: Constants.size100,
                                        height: Constants.size100,
                                      ),
                                      SizedBox(
                                        height: Constants.size10,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.all(Constants.size5),
                                        decoration: BoxDecoration(
                                          color: AppColor.bangladeshGreen
                                              .withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(
                                              Constants.size10),
                                        ),
                                        child: TextView(
                                          text: TimeagoHelper.parseDatetime(
                                            state.yourArticles
                                                ?.elementAt(index)
                                                .publishedAt
                                                .toString(),
                                          ),
                                          fontSize: Constants.size10,
                                          textColor: AppColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Constants.size10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextView(
                                        text: state.yourArticles
                                            ?.elementAt(index)
                                            .title,
                                        fontSize: Constants.size17,
                                        fontWeight: FontWeight.w700,
                                        lineNumber: 2,
                                      ),
                                      SizedBox(
                                        height: Constants.size5,
                                      ),
                                      TextView(
                                        text: state.yourArticles
                                            ?.elementAt(index)
                                            .describe,
                                        fontSize: Constants.size15,
                                        textColor: AppColor.darkSilver,
                                        lineNumber: 3,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SizedBox(
                                        height: Constants.size10,
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            TextView(
                                              text: local.author,
                                              textColor: AppColor.darkSilver,
                                              fontSize: Constants.size12,
                                            ),
                                            SizedBox(
                                              width: Constants.size5,
                                            ),
                                            SizedBox(
                                              width: Constants.size150,
                                              child: TextView(
                                                text: state.yourArticles
                                                    ?.elementAt(index)
                                                    .author,
                                                textColor: AppColor.arsenic,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Constants.size10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
