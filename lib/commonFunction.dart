import 'package:flutter/material.dart';
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

String formatDateString(String isoDateString) {
  try {
    // Parse the ISO 8601 date string
    DateTime dateTime = DateTime.parse(isoDateString);

    // Format the date into "dd.MM.yyyy"
    return DateFormat('dd.MM.yyyy').format(dateTime);
  } catch (e) {
    // Handle parsing error
    print('Error parsing date: $e');
    return 'Invalid date';
  }
}

Map<String, String> createDateTimeObjects(
    String fromDate, String fromTimeStr, String toTimeStr, String endDate) {
  try {
    String fromDateTime = "${fromDate}T$fromTimeStr:00.000Z";
    String toDateTime = "${endDate}T$toTimeStr:00.000Z";
    // Parse the date strings into DateTime objects
    // DateTime fromdate = DateTime.parse(fromDate);
    // DateTime endate = DateTime.parse(endDate);

    // // Remove all non-printable and non-ASCII characters from time strings
    // fromTimeStr = fromTimeStr.replaceAll(RegExp(r'[^\x20-\x7E]'), '').trim();
    // toTimeStr = toTimeStr.replaceAll(RegExp(r'[^\x20-\x7E]'), '').trim();

    // print(
    //     "$fromDate fromDate $endDate endDate '$fromTimeStr' fromTime '$toTimeStr' toTimeString");

    // // Parse the time strings into TimeOfDay objects
    // TimeOfDay fromTime =
    //     TimeOfDay.fromDateTime(DateFormat.jm().parse(fromTimeStr));
    // TimeOfDay toTime = TimeOfDay.fromDateTime(DateFormat.jm().parse(toTimeStr));

    // // Combine the date and time to create DateTime objects
    // DateTime fromDateTime = DateTime(fromdate.year, fromdate.month,
    //     fromdate.day, fromTime.hour, fromTime.minute);
    // DateTime toDateTime = DateTime(
    //     endate.year, endate.month, endate.day, toTime.hour, toTime.minute);

    return {
      'fromDateTime': fromDateTime,
      'toDateTime': toDateTime,
    };
  } catch (e) {
    print('Error: $e');
    return {};
  }
}
