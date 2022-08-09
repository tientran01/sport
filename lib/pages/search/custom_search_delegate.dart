import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import '../../router/navigation_service.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Category> categories = AppStrings.categories;
  SearchBloc? searchBloc;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Image.asset(
          AppResource.close,
          width: Constants.size25,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Image.asset(
        AppResource.leftArrow,
        width: Constants.size30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc()
        ..add(
          SearchArticleEvent(searchText: query),
        ),
      child: BlocBuilder<SearchBloc, SearchState>(
        bloc: getIt.get<SearchBloc>(),
        builder: (context, state) {
          List<Article>? results = state.results;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleItem(
                article: results?.elementAt(index),
                onTap: () {
                  NavigationService.navigatorKey.currentState?.pushNamed(
                    AppRouteName.detailArticle,
                    arguments: results?.elementAt(index),
                  );
                },
              );
            },
            itemCount: results?.length ?? 0,
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
