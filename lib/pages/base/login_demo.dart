import 'package:flutter/material.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/resource/resource.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> with BaseView {
  @override
  String? get titleAppBar => AppStrings.addFavorite;
  @override
  bool? get isPop => true;
  @override
  Widget? get body => const Center(
    child: Text(AppStrings.areYouSureDelete),
  );
}