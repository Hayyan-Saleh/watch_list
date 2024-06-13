import 'package:flutter/material.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/movie_details_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/favourite_button.dart';

class HorizontalListViewWidget extends StatelessWidget {
  final List<Movie> movies;
  final List<Movie> userMovies;
  final double height;
  const HorizontalListViewWidget(
      {required this.height,
      required this.userMovies,
      required this.movies,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return AspectRatio(
            aspectRatio: 3 / 4,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(movieId: movie.id)));
              },
              child: _buildPosterWidget(
                movie,
              ),
            ));
      },
    );
  }

  Widget _buildPosterWidget(Movie movie) {
    return Column(
      children: [
        _buildPoster(height, movie),
        _buildDetails(height, movie),
      ],
    );
  }

  Widget _buildDetails(double height, Movie movie) {
    return Stack(children: [
      Container(
          width: 0.5 * height,
          height: 0.3 * height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.grey, Colors.black]),
            border: const Border(
              left: BorderSide(color: Colors.grey, width: 2),
              right: BorderSide(color: Colors.grey, width: 2),
            ),
            color: Colors.grey.withAlpha(130),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTwoText("Title : ", movie.originalTitle),
              _buildTwoText("Release Date : ", movie.releaseDate),
              _buildTwoText("Adult : ", movie.isAdult ? 'Yes' : 'No'),
              _buildTwoText(
                  "Vote Average : ", movie.voteAverage.toStringAsFixed(1)),
            ],
          )),
      Positioned(
          bottom: 0,
          right: 0,
          child: FavouriteButton(
            isFavourite: _checkIfFavourite(movie),
            movie: movie,
          ))
    ]);
  }

  Widget _buildPoster(double height, Movie movie) {
    return Container(
      height: 0.7 * height,
      width: 0.5 * height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.grey]),
        border: const Border(
          left: BorderSide(color: Colors.grey, width: 2),
          right: BorderSide(color: Colors.grey, width: 2),
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/original/${movie.posterPath}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTwoText(String firstText, String secondText) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0.03 * height),
          child: Text(
            firstText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: secondaryColor, fontSize: 0.03 * height),
          ),
        ),
        Expanded(
          child: Text(
            secondText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 0.03 * height),
          ),
        )
      ],
    );
  }

  bool _checkIfFavourite(Movie movie) {
    bool isFavourite = false;
    for (var userMovie in userMovies) {
      if (userMovie.id == movie.id) {
        isFavourite = true;
      }
    }
    return isFavourite;
  }
}
