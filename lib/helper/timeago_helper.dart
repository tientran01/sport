import 'package:timeago/timeago.dart' as timeago;

class TimeagoHelper {
  TimeagoHelper._();
  static String parseDatetime(String? datetime) {
    return timeago.format(DateTime.parse(datetime ?? DateTime.now().toString()));
  }
}
