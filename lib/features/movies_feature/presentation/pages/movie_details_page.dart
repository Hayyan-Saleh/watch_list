import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/core/widgets/loading_widget.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movie_detailes_bloc/movie_detailes_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/error_widgets/connection_error_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/movies_widgets/trailer_player_widget.dart';
import 'package:watch_list/injection_container.dart' as di;

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider<MovieDetailesBloc>(
        create: (context) => di.sl<MovieDetailesBloc>()
          ..add(GetMovieDetailsEvent(movieId: movieId)),
        child: BlocBuilder<MovieDetailesBloc, MovieDetailesState>(
          builder: (context, state) {
            Widget widget = const Placeholder();
            if (state is LoadedMovieDetailsState) {
              widget = SizedBox(
                height: height,
                width: width,
                child: Stack(children: [
                  _buildBackground(
                      height, width, state.movieDetails.backdropPath),
                  _buildFilter(),
                  _buildBody(height, width, context, state.movieDetails),
                ]),
              );
            } else if (state is LoadingMovieDetailesState) {
              widget = const LoadingWidget();
            } else if (state is ErrorMovieDetailsState) {
              widget = const ConnectionErrorWidget(
                  message: "There is a Fatal Error !");
            }
            return SafeArea(
              child: Scaffold(
                body: widget,
              ),
            );
          },
        ));
  }

  Widget _buildBody(double height, double width, BuildContext context,
      MovieDetails movieDetails) {
    Color textColor = Colors.white;
    return SizedBox(
      height: height,
      child: ListView(
        children: [
          SizedBox(height: 0.07 * height, child: _buildAppBar(context)),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.all(0.03 * height),
              child: Container(
                  decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black)]),
                  child: _buildPoster(movieDetails.posterPath)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.03 * height),
            child: _buildBigText("General Details :", height),
          ),
          _buildText('Movie Title : ', height, width, secondaryColor),
          _buildText(movieDetails.originalTitle, height, width, textColor),
          _buildText('Release Date : ', height, width, secondaryColor),
          _buildText(movieDetails.releaseDate, height, width, Colors.white),
          _buildText('Release Status :', height, width, secondaryColor),
          _buildText(movieDetails.status, height, width, textColor),
          _buildText('Is Adult :', height, width, secondaryColor),
          _buildText(
              movieDetails.isAdult ? "Yes " : 'No ', height, width, textColor),
          _buildText('Movie Genres :', height, width, secondaryColor),
          _buildHorizontalListView(movieDetails.genres, height),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.03 * height),
            child: _buildBigText("Popularity Details :", height),
          ),
          _buildText('Vote Average :', height, width, secondaryColor),
          _buildText(movieDetails.voteAverage.toStringAsFixed(1), height, width,
              textColor),
          _buildText('Vote Count :', height, width, secondaryColor),
          _buildText(
              movieDetails.voteCount.toString(), height, width, textColor),
          _buildText('Popularity :', height, width, secondaryColor),
          _buildText(movieDetails.popularity.toStringAsFixed(1), height, width,
              textColor),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.03 * height),
            child: _buildBigText("Other Details :", height),
          ),
          _buildText('Original Language :', height, width, secondaryColor),
          _buildText(movieDetails.originalLanguage, height, width, textColor),
          _buildText('Spoken Languages :', height, width, secondaryColor),
          _buildHorizontalListView(
            movieDetails.spokenLangauges,
            height,
          ),
          _buildText('Production Countries :', height, width, secondaryColor),
          _buildHorizontalListView(
            movieDetails.productionCountries,
            height,
          ),
          _buildText('Movie Length :', height, width, secondaryColor),
          _buildText(
              getHoursFormat(movieDetails.runtime), height, width, textColor),
          _buildText('Movie Tagline :', height, width, secondaryColor),
          _buildText(movieDetails.tagline, height, width, textColor),
          _buildBigText("Movie Overview :", height),
          _buildOverView(movieDetails.overview, height, width),
          _buildBigText("Movie Trailer :", height),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.03 * height),
            child: SizedBox(
                height: 0.3 * height, child: TrailerPlayer(movieId: movieId)),
          ),
          _buildBigText("Commercial Details", height),
          _buildText('Movie Budget :', height, width, secondaryColor),
          _buildText(format(movieDetails.budget), height, width, textColor),
          _buildText('Movie Revenue :', height, width, secondaryColor),
          _buildText(format(movieDetails.revenue), height, width, textColor),
          _buildText('Production Companies :', height, width, secondaryColor),
          _buildHorizontalListView(
            movieDetails.productionCompanies,
            height,
          ),
          SizedBox(
            height: 0.05 * height,
          )
        ],
      ),
    );
  }

  Widget _buildOverView(String overview, double height, double width) {
    return SizedBox(
        height: 0.2 * height,
        width: 0.9 * width,
        child: Padding(
          padding: EdgeInsets.only(left: 0.055 * width, top: 0.01 * height),
          child: ListView(
            children: [
              Text(
                overview,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 0.025 * height,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ));
  }

  Widget _buildBigText(String message, double height) {
    return SizedBox(
      height: 0.05 * height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03 * height),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 0.04 * height),
        ),
      ),
    );
  }

  Widget _buildHorizontalListView(List<String> list, double height) {
    return SizedBox(
      height: 0.04 * height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03 * height),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 0.04 * height,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black)),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03 * height),
                child: Center(
                  child: Text(
                    list[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildText(
      String firstText, double height, double width, Color color) {
    return SizedBox(
      height: 0.05 * height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 0.03 * width),
                child: Text(
                  firstText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: color, fontSize: 0.05 * width),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(String imagePath) {
    return imagePath == 'not available'
        ? const SizedBox(
            height: 5,
          )
        : AspectRatio(
            aspectRatio: 3 / 4,
            child: Image.network(
              MOVIE_PICTURE_BASE_URL + imagePath,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryColor.withAlpha(220)),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Movie Details ',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
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
                Colors.black.withAlpha(200),
              ])),
    );
  }

  Widget _buildBackground(double height, double width, String imagePath) {
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
