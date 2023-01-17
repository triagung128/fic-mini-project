import 'package:intl/intl.dart';

extension PointExtension on int {
  String get pointFormatter {
    return NumberFormat('#,##0', 'id_ID').format(this);
  }
}
