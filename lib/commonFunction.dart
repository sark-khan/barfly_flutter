import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  // Parse the timestamp to DateTime
  DateTime dateTime = DateTime.parse(timestamp);

  // Format the DateTime to the desired format
  String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

  return formattedDate;
}

String formatTime(String timestamp) {
  // Parse the timestamp to DateTime
  DateTime dateTime = DateTime.parse(timestamp);

  // Format the DateTime to the desired time format
  String formattedTime = DateFormat('HH.mm').format(dateTime);

  return formattedTime;
}
