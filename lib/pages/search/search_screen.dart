import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
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
          padding: EdgeInsets.all(Constants.size10),
          child: BlocBuilder<SearchBloc, SearchState>(
            bloc: getIt.get<SearchBloc>(),
            builder: (context, state) {
              if (state is SearchLoading) {
                return const CircularLoading();
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
      ),
    );
  }
}
