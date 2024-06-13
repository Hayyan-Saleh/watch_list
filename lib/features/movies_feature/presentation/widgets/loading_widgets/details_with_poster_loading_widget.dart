import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watch_list/core/theme/app_theme.dart';

class DetailsWithPosterLoadingWidget extends StatelessWidget {
  const DetailsWithPosterLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double containerWidth = 0.9 * deviceWidth;
    final double containerHeight = 0.35 * deviceHeight;
    final double horizontalMargin = 0.025 * deviceWidth;
    final double verticalMargin = 0.025 * deviceHeight;
    final double horizontalPadding = 0.005 * deviceWidth;
    final double verticalPadding = 0.025 * deviceHeight;
    final double pictureWidth = 0.2 * deviceWidth;
    final double pictureHeight = 0.3 * deviceHeight;
    final double textPlaceWidth = 0.5 * deviceWidth;
    final double textPlaceHeight = pictureHeight;

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(blurRadius: 7, color: primaryColor, spreadRadius: 3)
          ]),
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTextSpace(textPlaceHeight, textPlaceWidth),
          SizedBox(
            width: horizontalPadding,
          ),
          _buildPosterSpace(pictureHeight, pictureWidth),
        ],
      ),
    );
  }

  Widget _buildTextSpace(double height, double width) {
    return Container(
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height: height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: ListView(children: [
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.5 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: const Text("nothing"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.1 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              width: 0.8 * width,
              child: const Text("nothing"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.3 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              width: 0.6 * width,
              child: const Text("nothing"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.2 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              width: 0.7 * width,
              child: const Text('nothing'),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.5 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: const Text("nothing"),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.03 * width,
                  right: 0.2 * width,
                  top: 0.05 * width,
                  bottom: 0.05 * width),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: const Text("nothing"),
            ),
          ]),
        ));
  }

  Widget _buildPosterSpace(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        color: Colors.amber,
        child: const Text("nothing"),
      ),
    );
  }
}
