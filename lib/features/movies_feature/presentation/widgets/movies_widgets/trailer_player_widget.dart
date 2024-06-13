import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movie_trailer_bloc/movie_trailer_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/other_widgets/video_player_widget.dart';
import '../../../../../injection_container.dart' as di;

class TrailerPlayer extends StatelessWidget {
  final int movieId;
  const TrailerPlayer({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieTrailerBloc>(
        create: (context) => di.sl<MovieTrailerBloc>(),
        child: BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
          builder: (context, state) {
            Widget widget = const Placeholder();
            if (state is TrailerLinkLoadedState) {
              widget = VideoPlayerWidget(videoId: state.trailerLink);
            } else if (state is TrailerLinkLoadingState) {
              widget = const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is ErrorMovieTrailerState) {
              widget = Center(
                child: Text(
                  '${state.message} !',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              widget = IconButton(
                  onPressed: () {
                    BlocProvider.of<MovieTrailerBloc>(context)
                        .add(GetMovieTrailerEvent(movieId: movieId));
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: Colors.red,
                  ));
            }

            return Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(
                      bottom: BorderSide(color: primaryColor),
                      top: BorderSide(color: primaryColor))),
              child: widget,
            );
          },
        ));
  }
}
