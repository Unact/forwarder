import 'package:intl/intl.dart';

class Format {
  static String numberStr(double number) {
    return NumberFormat("#,##0.00", "ru_RU").format(number);
  }

  static String dateStr(DateTime date) {
    return DateFormat.yMd('ru').format(date);
  }
}
