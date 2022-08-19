import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  const BaseScreen({
    Key? key,
    required this.body,
    this.appBar,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocus(context);
      },
      child: Scaffold(
        appBar: widget.appBar,
        body: widget.body,
      ),
    );
  }
}
