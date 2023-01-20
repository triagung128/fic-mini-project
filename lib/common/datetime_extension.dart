import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dateTimeFormatter {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
}
