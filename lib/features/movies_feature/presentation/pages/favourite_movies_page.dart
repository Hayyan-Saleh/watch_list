import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/error_widgets/connection_error_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/movie_widget.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';

class FavouriteMoviesPage extends StatelessWidget {
  const FavouriteMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            if (state.user.userFavouriteMovies.isNotEmpty) {
              return Stack(children: [
                _buildBackground(
                    height, width, state.user.userFavouriteMovies.first),
                _buildFilter(),
                ListView.builder(
                  itemCount: state.user.userFavouriteMovies.length + 1,
                  itemBuilder: (context, index) {
                    if (index != 0) {
                      return Padding(
                        padding: EdgeInsets.all(0.05 * width),
                        child: MovieWidget(
                            isFavourite: true,
                            width: width - 0.1 * width,
                            height: 0.4 * height,
                            movie: state.user.userFavouriteMovies[index - 1]),
                      );
                    } else {
                      return _buildGreeting(state.user.userName);
                    }
                  },
                ),
              ]);
            } else {
              return const ConnectionErrorWidget(
                  message: EMPTY_CACHE_FAILURE_MESSAGE);
            }
          }

          return const ConnectionErrorWidget(message: "There is a Fatal Error");
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: const Text(
        "Your Favourite Movies",
        style: TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
    );
  }

  Widget _buildGreeting(String userName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
      child: Text(
        'Welcome $userName ! \nHere are your favourite Movies ',
        style: const TextStyle(color: primaryColor, fontSize: 20),
      ),
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

  Widget _buildBackground(double height, double width, Movie movie) {
    return SizedBox(
      width: width,
      height: height * 3 + height / 3,
      child: Image.network(
        MOVIE_PICTURE_BASE_URL + movie.posterPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
