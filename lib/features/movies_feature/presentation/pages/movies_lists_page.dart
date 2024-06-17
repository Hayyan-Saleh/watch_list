import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/core/widgets/about_page.dart';
import 'package:watch_list/core/widgets/loading_widget.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/favourite_movies_page.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/search_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/carousel_movies_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/horizontal_list_view_widget.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:watch_list/injection_container.dart' as di;

import '../widgets/error_widgets/connection_error_widget.dart';

class MoviesListsPage extends StatelessWidget {
  const MoviesListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = 0.3 * MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return BlocProvider<MoviesListBloc>(
      create: (context) => di.sl<MoviesListBloc>()..add(GetMoviesListEvent()),
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 49, 49, 49),
          body: BlocBuilder<MoviesListBloc, MoviesListState>(
            builder: (context, state) {
              if (state is LoadedMoviesListState) {
                return SafeArea(
                  child: Stack(children: [
                    _buildBackground(height, width),
                    _buildFilter(),
                    _buildBody(
                        context: context,
                        height: height,
                        todayMostTrendingMovies: state.todayMostTrendingMovies,
                        thisWeekMostTrendingMovies:
                            state.thisWeekMostTrendingMovies,
                        topRatedMovies: state.topRatedMovies,
                        nowPlayingMovies: state.nowPlayingMovies,
                        popularMovies: state.popularMovies,
                        upcomingMovies: state.upcomingMovies),
                  ]),
                );
              } else if (state is LoadingMoviesListState) {
                return const LoadingWidget();
              } else if (state is ErrorMovieState) {
                return ConnectionErrorWidget(message: state.message);
              }
              return const Center(
                child: Text(""),
              );
            },
          )),
    );
  }

  Widget _buildBody(
      {required double height,
      required BuildContext context,
      required List<Movie> todayMostTrendingMovies,
      required List<Movie> thisWeekMostTrendingMovies,
      required List<Movie> upcomingMovies,
      required List<Movie> topRatedMovies,
      required List<Movie> nowPlayingMovies,
      required List<Movie> popularMovies}) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          final List<Movie> userMovies = state.user.userFavouriteMovies;
          return ListView(
            children: [
              FadeInDown(
                  duration: const Duration(seconds: 2),
                  child: _buildAppBar(context)),
              _buildSubTitle("Today's Top Trending Movies"),
              SizedBox(
                height: height,
                child: CarouselMoviesWidget(
                    userMovies: userMovies,
                    duration: 10,
                    movies: todayMostTrendingMovies),
              ),
              _buildSubTitle("This week's Top Trending Movies"),
              SizedBox(
                height: height,
                child: CarouselMoviesWidget(
                    userMovies: userMovies,
                    duration: 15,
                    movies: thisWeekMostTrendingMovies),
              ),
              _buildSubTitle("Upcoming Movies"),
              FadeInLeft(
                duration: const Duration(seconds: 3),
                child: SizedBox(
                    height: 2 * height,
                    child: HorizontalListViewWidget(
                        userMovies: userMovies,
                        height: 2 * height,
                        movies: upcomingMovies)),
              ),
              _buildSubTitle("Top Rated Movies"),
              FadeInLeft(
                duration: const Duration(seconds: 3),
                child: SizedBox(
                    height: 2 * height,
                    child: HorizontalListViewWidget(
                        userMovies: userMovies,
                        height: 2 * height,
                        movies: topRatedMovies)),
              ),
              _buildSubTitle("Now Showing Movies"),
              SizedBox(
                height: 1.5 * height,
                child: HorizontalListViewWidget(
                    userMovies: userMovies,
                    height: 1.5 * height,
                    movies: nowPlayingMovies),
              ),
              _buildSubTitle("Popular Movies"),
              SizedBox(
                  height: 1.5 * height,
                  child: HorizontalListViewWidget(
                      userMovies: userMovies,
                      height: 1.5 * height,
                      movies: popularMovies)),
            ],
          );
        }
        return const ConnectionErrorWidget(message: "There is a Fatal error");
      },
    );
  }

  Widget _buildSubTitle(String text) {
    return FadeInLeft(
      duration: const Duration(seconds: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
        ),
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
                Colors.black.withAlpha(240),
                Colors.black.withAlpha(200),
              ])),
    );
  }

  Widget _buildBackground(double height, double width) {
    final int randomNum = getRandomIntFromRange(1, 15);
    return SizedBox(
      width: width,
      height: height * 3 + height / 3,
      child: Image.asset(
        'assets/pngs/background$randomNum.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavouriteMoviesPage()));
              },
              icon: const Icon(
                Icons.star_rounded,
                size: 30,
                color: secondaryColor,
              )),
          const Text(
            "Watch List",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPage(
                            moviesListBloc: di.sl<MoviesListBloc>())));
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
