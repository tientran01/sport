import 'package:flutter/material.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/pages/category/components/category_item.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  var categories = Category.categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.category,
        rightIconPath: AppResource.rightArrow,
        onPressedRight: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: Constants.size5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.6),
          crossAxisCount: 2,
          crossAxisSpacing: Constants.size5,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: CategoryItem(
              category: categories.elementAt(index),
              onTap: () {
                getIt.get<ArticleBloc>().add(
                      GetCategoryNameEvent(
                        nameCategory: categories.elementAt(index).text,
                      ),
                    );
                NavigationService.navigatorKey.currentState?.pushNamed(
                  AppRouteName.article,
                  arguments: categories.elementAt(index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
