// ignore_for_file: unnecessary_overrides

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/constants.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final String? imageError;
  const CustomImage({
    Key? key,
    this.imageUrl,
    this.width,
    this.height,
    this.imageError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.size15),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black,
            Colors.black45,
            Colors.black12,
            Colors.black.withOpacity(0),
          ],
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.size15),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
              scale: 1.0,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppResource.error,
          width: Constants.sizeIcon,
          color: AppColor.gainsboro,
        ),
      ),
    );
  }
}



class ImageCircle extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final bool? isEdit;
  final String? iconPath;
  final VoidCallback? onTap;

  const ImageCircle({
    Key? key,
    this.imageUrl,
    this.height,
    this.width,
    this.isEdit,
    this.iconPath, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.gainsboro,
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            imageBuilder: (context, imageProvider) => Container(
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
            errorWidget: (context, url, error) => Image.asset(
              AppResource.profile,
              width: Constants.sizeIcon,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(Constants.size5),
              decoration: BoxDecoration(
                color: AppColor.gainsboro,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.white,
                  width: Constants.size5,
                ),
              ),
              child: Image.asset(
                iconPath ?? AppResource.edit,
                color: AppColor.arsenic,
                width: Constants.size20,
              ),
            ),
          ),
        )
      ],
    );
  }
}


