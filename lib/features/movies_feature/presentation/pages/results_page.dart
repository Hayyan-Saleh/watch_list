import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/movies_lists_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/error_widgets/connection_error_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/movie_widget.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';

class ResultsPage extends StatelessWidget {
  final String movieName;
  final List<Movie> searchedMovies;
  const ResultsPage({
    required this.searchedMovies,
    required this.movieName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            _buildBackground(height, width),
            _buildFilter(),
            _buildBody(height, width),
          ],
        ));
  }

  Widget _buildBody(double height, double width) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          final List<Movie> userMovies = state.user.userFavouriteMovies;
          return ListView.builder(
            itemCount: searchedMovies.length + 1,
            itemBuilder: (context, index) {
              if (searchedMovies.isNotEmpty) {
                if (index != 0) {
                  final Movie movie = searchedMovies[index - 1];
                  return Padding(
                    padding: EdgeInsets.all(0.05 * width),
                    child: MovieWidget(
                        isFavourite: _checkIfFavourite(userMovies, movie),
                        width: width - 0.1 * width,
                        height: 0.4 * height,
                        movie: movie),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 0.05 * height,
                        left: 0.06 * width,
                        bottom: 0.01 * height),
                    child: _buildExplainerText(
                        'Search Results For \' $movieName \''),
                  );
                }
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.2 * width, vertical: height / 3),
                  child: _buildExplainerText(
                      'There is No Search Results For \' $movieName \''),
                );
              }
            },
          );
        } else {
          return const ConnectionErrorWidget(
              message: "There is a Fatal Error ... please try again later");
        }
      },
    );
  }

  bool _checkIfFavourite(List<Movie> movies, Movie movie) {
    bool isFavourite = false;
    for (Movie userMovie in movies) {
      if (movie.id == userMovie.id) {
        isFavourite = true;
        break;
      }
    }
    return isFavourite;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MoviesListsPage()),
              (route) => false);
        },
      ),
      title: const Text(
        'Search Results ',
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }

  Widget _buildExplainerText(String string) {
    return Text(
      string,
      style: const TextStyle(
          fontSize: 20, color: primaryColor, fontWeight: FontWeight.w500),
    );
  }

  Container _buildFilter() {
    return Container(
      decoration: BoxDecoration(
          color: secondaryColor,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(230),
                Colors.black.withAlpha(150),
              ])),
    );
  }

  Widget _buildBackground(double height, double width) {
    String imagePath = 'not available';
    if (searchedMovies.isNotEmpty) {
      Movie movie = searchedMovies
          .elementAt(getRandomIntFromRange(0, searchedMovies.length - 1));
      if (movie.posterPath != 'not available') {
        imagePath = movie.posterPath;
      } else if (movie.backdropPath != 'not available') {
        imagePath = movie.backdropPath;
      }
    }
    return SizedBox(
      width: width,
      height: height * 3 + height / 3,
      child: imagePath == 'not available'
          ? null
          : Image.network(
              MOVIE_PICTURE_BASE_URL + imagePath,
              fit: BoxFit.cover,
            ),
    );
  }
}
