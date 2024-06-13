import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/movie_details_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/favourite_button.dart';

class CarouselMoviesWidget extends StatelessWidget {
  final List<Movie> movies;
  final List<Movie> userMovies;
  final int duration;
  const CarouselMoviesWidget(
      {required this.duration,
      required this.userMovies,
      required this.movies,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          final movie = movies[index];

          return Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailsPage(movieId: movie.id)));
                },
                child: Stack(
                  children: [
                    _buildPicture(movie.backdropPath),
                    _buildFilter(),
                    _buildMovieTitle(movie.originalTitle),
                  ],
                ),
              ),
              _buildButton(FavouriteButton(
                  isFavourite: _checkIfFavourite(movie), movie: movie)),
            ],
          );
        },
        options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: duration)));
  }

  Widget _buildButton(Widget button) {
    return Positioned(right: 0, top: 0, child: button);
  }

  Widget _buildFilter() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.transparent, Colors.black])),
    );
  }

  Widget _buildMovieTitle(String title) {
    return Positioned(
      bottom: 15,
      left: 0,
      right: 0,
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _buildPicture(String backdropPath) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/original/$backdropPath',
              ),
              fit: BoxFit.cover)),
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
