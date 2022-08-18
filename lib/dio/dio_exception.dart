import 'package:dio/dio.dart';
import 'package:sport_app/dio/dio_error_type.dart';

class DioException implements Exception {
  late String errorMsg;
  DioException.getDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMsg = DioErrorTypeString.cancel;
        break;
      case DioErrorType.connectTimeout:
        errorMsg = DioErrorTypeString.connectTimeout;
        break;
      case DioErrorType.receiveTimeout:
        errorMsg = DioErrorTypeString.receiveTimeout;
        break;
      case DioErrorType.sendTimeout:
        errorMsg = DioErrorTypeString.sendTimeout;
        break;
      case DioErrorType.response:
        errorMsg = handleStatusCode(dioError.response?.statusCode);
        break;
      default:
    }
  }

  String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'err_400';
      case 401:
        return 'err_401';
      case 403:
        return 'err_403';
      case 404:
        return 'err_404';
      case 405:
        return 'err_405';
      case 415:
        return 'err_415';
      case 422:
        return 'err_422';
      case 429:
        return DioErrorTypeString.error429;
      case 500:
        return 'err_500';
      default:
        return 'err_other3';
    }
  }
}
