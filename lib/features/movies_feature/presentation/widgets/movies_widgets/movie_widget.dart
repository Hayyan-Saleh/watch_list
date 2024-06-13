import 'package:flutter/material.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/movie_details_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/favourite_button.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  final double width, height;
  final bool isFavourite;
  const MovieWidget(
      {required this.width,
      required this.isFavourite,
      required this.height,
      required this.movie,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(movieId: movie.id)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_buildPoster(context, movie.id), _buildDetails()],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: FavouriteButton(
                  isFavourite: isFavourite,
                  movie: movie,
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context, int movieId) {
    return Container(
      height: height,
      width: 0.4 * width,
      decoration: BoxDecoration(
        border: const Border(
            bottom: BorderSide(color: Colors.grey),
            top: BorderSide(color: Colors.grey)),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Stack(children: [
      Container(
          width: 0.6 * width,
          height: height,
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.black, Colors.transparent]),
            border: Border(
                bottom: BorderSide(color: Colors.grey),
                top: BorderSide(color: Colors.grey)),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildOneText("Title : ", 1),
              _buildOneText(movie.originalTitle, 2),
              _buildOneText("Release Date : ", 1),
              _buildOneText(movie.releaseDate, 2),
              _buildOneText("Adult : ", 1),
              _buildOneText(movie.isAdult ? "Yes " : "No ", 2),
              _buildOneText("Vote Average", 1),
              _buildOneText(movie.voteAverage.toStringAsFixed(1), 2)
            ],
          )),
    ]);
  }

  Widget _buildOneText(String firstText, int color) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 0.03 * width),
            child: Text(
              firstText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: color == 1 ? secondaryColor : Colors.white,
                  fontSize: 0.05 * width),
            ),
          ),
        ),
      ],
    );
  }
}
