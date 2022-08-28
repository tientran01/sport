import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const CupertinoActivityIndicator();
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) =>
      _getIndicatorWidget(Theme.of(context).platform);
}
