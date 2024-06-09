import 'dart:math';

import 'package:flutter/material.dart';

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

// show snack bar

void showSnackBar(String message, BuildContext context, bool success) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text('message'),
    backgroundColor: success ? Colors.green : Colors.red,
    duration: const Duration(seconds: 3),
  ));
}
