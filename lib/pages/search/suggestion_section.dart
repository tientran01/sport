import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';

class SuggestionSection extends StatefulWidget {
  final String? searchText;
  const SuggestionSection({Key? key, this.searchText}) : super(key: key);

  @override
  State<SuggestionSection> createState() => _SuggestionSectionState();
}

class _SuggestionSectionState extends State<SuggestionSection> {
  @override
  void initState() {
    super.initState();
    getIt.get<SearchBloc>().add(const SearchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        bloc: getIt.get<SearchBloc>(),
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size10,
            ),
            child: ListView.builder(
              itemCount: state.results?.length,
              itemBuilder: (context, index) {
              return ArticleItem(
                article: state.results?.elementAt(index),
              );
            }),
          );
        },
      ),
    );
  }
}
