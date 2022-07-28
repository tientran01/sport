import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? imageUrl;
  final String? title;
  final VoidCallback? onTap;
  const DetailAppBar({
    Key? key,
    this.imageUrl,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width * 2 / 3,
          padding: EdgeInsets.symmetric(
            horizontal: Constants.size10,
            vertical: Constants.size5,
          ),
          decoration: BoxDecoration(
            color: AppColor.gainsboro.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Constants.size20),
          ),
          child: Row(
            children: [
              Image.asset(
                AppResource.leftArrow,
                width: Constants.size25,
              ),
              Container(
                margin: EdgeInsets.only(left: Constants.size5),
                width: Constants.size180,
                child: const TextView(
                  text: AppStrings.newsTitleDemo,
                ),
              )
            ],
          ),
        ),
      ),
      flexibleSpace: CachedNetworkImage(
        imageUrl: imageUrl ?? AppNetwork.carouselImage_2,
        fit: BoxFit.fill,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.size200);
}
