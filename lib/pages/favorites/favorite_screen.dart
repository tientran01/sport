import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_bloc.dart';
import 'package:sport_app/component/component.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import '../../bloc/favorite/bloc/favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).favorites,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        bloc: getIt.get<FavoriteBloc>(),
        builder: (context, favoriteState) {
          if (favoriteState is FavoriteLoading) {
            return Center(
              child: Image.asset(AppResource.empty),
            );
          }
          if (favoriteState is FavoriteLoader) {
            if (favoriteState.videos?.isEmpty ??
                favoriteState.videos?.length == null) {
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
                        margin: EdgeInsets.symmetric(
                          vertical: Constants.size15,
                        ),
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
                                ),
                              ),
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
                                          ?.title,
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
                                          ?.describe,
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
    );
  }
}
