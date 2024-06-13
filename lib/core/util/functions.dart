import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// convert from json to list<String>

List<String> stringListFromJson(Map<String, dynamic> jsonMap, String key) {
  final List<dynamic> jsonList = jsonMap[key];
  return jsonList.map<String>((jsonInnerMap) => jsonInnerMap['name']).toList();
}

// get random value from a to b

int getRandomIntFromRange(int start, int end) {
  final random = Random();
  return start + random.nextInt(end - start);
}

// get random background path

String getRandomBackground() {
  int randomVal = getRandomIntFromRange(1, 15);
  // return 'assets/pngs/backgrounds/background$randomVal.jpg';
  return 'assets/pngs/backgrounds/background$randomVal.jpg';
}

// format number from 10000 to 10,000
String format(int number) {
  NumberFormat formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return formatter.format(number);
}

// show snack bar

void showSnackBar(String message, BuildContext context, bool success) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: success ? Colors.green : Colors.red,
    duration: const Duration(seconds: 3),
  ));
}

void showSnackBarCustomColor(
    String message, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.grey[800]),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
  ));
}

// get hours from minutes

String getHoursFormat(int minutes) {
  return '${(minutes / 60).toStringAsFixed(0)} Hours and ${minutes % 60} Minutes';
}
