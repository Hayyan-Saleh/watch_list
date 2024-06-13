import 'package:flutter/material.dart';
import 'package:watch_list/core/constants/strings.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: AssetImage(
                  LOADING2_PATH,
                ),
                fit: BoxFit.scaleDown)),
      ),
    );
  }
}
