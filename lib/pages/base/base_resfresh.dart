import 'package:flutter/material.dart';

abstract class BaseRefresh extends StatelessWidget {
  final Widget child;
  const BaseRefresh({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        
      },
    );
  }
}
