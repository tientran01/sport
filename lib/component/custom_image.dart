

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

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
        borderRadius: BorderRadius.circular(Constants.size10),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.size10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              scale: 1.0,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: AppColor.gainsboro,
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Image.asset(
            AppResource.error,
            width: Constants.size27,
            color: AppColor.gainsboro,
          ),
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
    this.iconPath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEdit == true
        ? Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.viridianGreen,
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? AppNetwork.imageAvatarPlaceholder,
                  imageBuilder: (context, imageProvider) {
                    return Container(
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
                    );
                  },
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.ghostWhite,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Container(
                      padding: EdgeInsets.all(Constants.size10),
                      decoration: const BoxDecoration(
                        color: AppColor.gainsboro,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          AppResource.profile,
                          fit: BoxFit.fill,
                          width: Constants.size60,
                        ),
                      ),
                    );
                  },
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
                      color: AppColor.arsenic,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.white,
                        width: Constants.size5,
                      ),
                    ),
                    child: Image.asset(
                      iconPath ?? AppResource.edit,
                      color: AppColor.white,
                      width: Constants.size20,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.gainsboro,
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              imageBuilder: (context, imageProvider) {
                return Container(
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
                );
              },
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) {
                return Container(
                  padding: EdgeInsets.all(Constants.size10),
                  decoration: const BoxDecoration(
                    color: AppColor.gainsboro,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppResource.profile,
                      fit: BoxFit.fill,
                      width: Constants.size60,
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class ImageLocal extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  const ImageLocal({Key? key, this.imagePath, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? Constants.size180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.size9),
        image: DecorationImage(
          image: AssetImage(imagePath ?? AppResource.background),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
