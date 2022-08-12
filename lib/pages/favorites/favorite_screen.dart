import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_event.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

import '../../bloc/favorite/bloc/favorite_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<FavoriteBloc>().add(GetListFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.favorites,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        bloc: getIt.get<FavoriteBloc>(),
        builder: (context, favoriteState) {
          if (favoriteState is FavoriteLoading) {
            return const CircularLoading();
          }
          if (favoriteState is FavoriteLoader) {
            if (favoriteState.videos == null) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.size20),
                child: ListView.builder(
                  itemCount: favoriteState.videos?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        NavigationService.navigatorKey.currentState?.pushNamed(
                          AppRouteName.videoPlayer,
                          arguments: favoriteState.videos?.elementAt(index),
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: Constants.size15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(right: Constants.size10),
                                  child: CustomImage(
                                    imageUrl: favoriteState.videos
                                        ?.elementAt(index)
                                        ?.thumbnailUrl,
                                    width: Constants.size120,
                                    height: Constants.size100,
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: Constants.size10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: favoriteState.videos
                                          ?.elementAt(index)
                                          ?.name,
                                      fontSize: Constants.size17,
                                      fontWeight: FontWeight.w700,
                                      textColor: AppColor.arsenic,
                                      lineNumber: 2,
                                    ),
                                    SizedBox(
                                      height: Constants.size5,
                                    ),
                                    TextView(
                                      text: favoriteState.videos
                                          ?.elementAt(index)
                                          ?.description,
                                      textColor:
                                          AppColor.darkSilver.withOpacity(.5),
                                      fontSize: Constants.size10,
                                      fontWeight: FontWeight.w600,
                                      lineNumber: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
          return Center(
            child: Image.asset(AppResource.empty),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.black,
        onPressed: () {},
        label: const TextView(
          text: AppStrings.removeAll,
          textColor: AppColor.white,
        ),
        icon: Image.asset(
          AppResource.delete,
          width: Constants.size40,
          color: AppColor.white,
        ),
      ),
    );
  }
}
