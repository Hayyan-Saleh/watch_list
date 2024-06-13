import 'package:flutter/material.dart';
import 'package:watch_list/core/constants/strings.dart';

class CinemaLoadingWidget extends StatelessWidget {
  final double height, width;
  const CinemaLoadingWidget(
      {required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
      height: height,
      width: width,
      child: SizedBox(
        height: height / 5,
        width: width / 3,
        child: Image.asset(LOADING2_PATH, fit: BoxFit.scaleDown),
      ),
    );
  }
}
