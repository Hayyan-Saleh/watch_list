import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/loading_widgets/details_with_poster_loading_widget.dart';

class CarouselLoadingWidget extends StatelessWidget {
  const CarouselLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return const DetailsWithPosterLoadingWidget();
        },
        options: CarouselOptions(
            autoPlay: true, autoPlayInterval: const Duration(seconds: 5)));
  }
}
