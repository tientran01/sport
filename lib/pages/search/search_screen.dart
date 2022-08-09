import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Constants.size80,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: CustomTextField(
          hintText: AppStrings.searchInput,
          onChanged: (String searchText) {
            getIt.get<SearchBloc>().add(
                  SearchArticleEvent(
                    searchText: searchText,
                  ),
                );
          },
        ),
        leading: IconButton(
          onPressed: () {
            NavigationService.navigatorKey.currentState?.pop();
          },
          icon: Image.asset(
            AppResource.leftArrow,
            width: Constants.size30,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.size10),
        child: BlocBuilder<SearchBloc, SearchState>(
            bloc: getIt.get<SearchBloc>(),
            builder: (context, state) {
              if (state.results == null) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Constants.size15),
                      width: MediaQuery.of(context).size.width,
                      height: Constants.size120,
                      decoration: BoxDecoration(
                        color: AppColor.gainsboro.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(Constants.size10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: AppStrings.suggestionSearch.toUpperCase(),
                            fontSize: Constants.size12,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: state.results?.length,
                itemBuilder: (context, index) {
                  return ArticleItem(
                    article: state.results?.elementAt(index),
                    onTap: () {
                      NavigationService.navigatorKey.currentState?.pushNamed(
                        AppRouteName.detailArticle,
                        arguments: state.results?.elementAt(index),
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
