import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const FloatingButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.arsenic,
      onPressed: onPressed,
      child: Image.asset(
        AppResource.add,
        width: Constants.size25,
        color: AppColor.white,
      ),
    );
  }
}
