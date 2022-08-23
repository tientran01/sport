import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sport_app/resource/resource.dart';

class Loading {
  Loading._();
  static void show() {
    EasyLoading.show(
      status: AppStrings.loading,
    );
  }

  static void showSuccess({String? msg}) {
    EasyLoading.showSuccess(msg ?? AppStrings.success);
  }

  static void showError({String? msg}) {
    EasyLoading.showError(msg ?? AppStrings.error);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
