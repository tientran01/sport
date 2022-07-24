import 'package:sport_app/component/button.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class CustomShowProfile extends StatelessWidget {
  final String? photoURL;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final VoidCallback? onPressed;
  const CustomShowProfile({
    Key? key,
    this.photoURL,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.size30),
      child: Center(
        child: Column(
          children: [
            photoURL != null
                ? ClipOval(
                    child: Material(
                      color: AppColor.hDDDDDD.withOpacity(0.3),
                      child: Image.network(
                        "$photoURL",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: AppColor.hDDDDDD.withOpacity(0.3),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColor.hDDDDDD,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: Constants.size30),
            Text(
              displayName ?? "",
              style: AppStyle.darkText(
                fontSize: Constants.headerFontSize,
              ),
            ),
            SizedBox(height: Constants.size10),
            Text(
              email ?? "",
              style: AppStyle.darkText(
                fontSize: Constants.titleFontSize
              ),
            ),
            SizedBox(height: Constants.size10),
            Text(
              phoneNumber ?? "",
              style: AppStyle.darkText(),
            ),
            Button(
              text: AppStrings.signOut,
              bgColor: AppColor.h413F42,
              onTap: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
