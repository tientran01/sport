import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  Loading._();

  static void show(String msg) {
    EasyLoading.show(status: msg);
  }

  static void showSuccess(String msg) {
    EasyLoading.showSuccess(msg);
  }

  static void showError(String msg) {
    EasyLoading.showError(msg);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
