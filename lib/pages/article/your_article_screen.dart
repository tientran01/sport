import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation offset;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    offset = Tween(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.yourArticle,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState
              ?.pushNamed(AppRouteName.main);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.black,
        onPressed: () {
          NavigationService.navigatorKey.currentState
              ?.pushNamed(AppRouteName.createNewArticle);
        },
        child: Image.asset(
          AppResource.create,
          width: Constants.size27,
          color: AppColor.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size15,
          vertical: Constants.size20,
        ),
        child: Container(
          padding: EdgeInsets.all(Constants.size5),
          width: size.width,
          height: Constants.size120,
          decoration: BoxDecoration(
            color: AppColor.gainsboro.withOpacity(0.4),
            borderRadius: BorderRadius.all(
              Radius.circular(Constants.size15),
            ),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  CustomImage(
                    imageUrl: AppNetwork.carouselImage_1,
                    width: Constants.size100,
                    height: Constants.size100,
                  ),
                  SizedBox(
                    width: Constants.size15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: AppStrings.channelDescription,
                        textColor: AppColor.black,
                        fontWeight: FontWeight.w700,
                        fontSize: Constants.size17,
                      ),
                      TextView(
                        text: AppStrings.requestInputOTP,
                        textColor: AppColor.darkSilver,
                        fontSize: Constants.size10,
                      ),
                      SizedBox(
                        height: Constants.size5,
                      ),
                      Row(
                        children: [
                          Container(
                            width: Constants.size30,
                            height: Constants.size30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.gainsboro,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: AppNetwork.imageAvatar,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.white,
                                    width: Constants.size5,
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Image.asset(
                                  AppResource.profile,
                                  width: Constants.size27,
                                  height: Constants.size27,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Constants.size10,
                          ),
                          TextView(
                            text: AppStrings.channelDescription,
                            fontSize: Constants.size10,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(Constants.size5),
                  child: Image.asset(
                    AppResource.delete,
                    width: Constants.size30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
