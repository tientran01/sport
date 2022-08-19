import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/pages/base/base_screen.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final List<Category> categories = AppStrings.categories;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        appBar: AppBar(
          toolbarHeight: Constants.size80,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: CustomTextField(
            prefix: IconButton(
              onPressed: () {
                NavigationService.navigatorKey.currentState?.pop();
              },
              icon: Image.asset(
                AppResource.leftArrow,
                width: Constants.size20,
              ),
            ),
            hintText: AppStrings.searchInput,
            onChanged: (String searchText) {
              getIt.get<SearchBloc>().add(
                    SearchArticleEvent(
                      searchText: searchText,
                    ),
                  );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Constants.size15),
          child: BlocBuilder<SearchBloc, SearchState>(
            bloc: getIt.get<SearchBloc>(),
            builder: (context, state) {
              if (state is SearchLoading) {
                return Container();
              }
              if (state is SearchLoader) {
                if (state.results == null) {
                  return Center(
                    child: Image.asset(AppResource.empty),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ArticleItem(
                        article: state.results?.elementAt(index),
                        onTap: () {
                          NavigationService.navigatorKey.currentState
                              ?.pushNamed(
                            AppRouteName.detailArticle,
                            arguments: state.results?.elementAt(index),
                          );
                        },
                      );
                    },
                  );
                }
              }
              return Center(
                child: TextView(
                  text: AppStrings.error,
                  fontSize: Constants.size15,
                ),
              );
            },
          ),
        ),
    );
  }
}
