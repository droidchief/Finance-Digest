import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM y').format(date);
}