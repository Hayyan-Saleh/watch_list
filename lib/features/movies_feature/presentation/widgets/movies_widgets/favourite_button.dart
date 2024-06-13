import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';

class FavouriteButton extends StatelessWidget {
  final Movie movie;
  final bool isFavourite;
  const FavouriteButton(
      {required this.isFavourite, required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isFavourite) {
          BlocProvider.of<UserBloc>(context)
              .add(RemoveFromFavouriteEvent(movie: movie));
          showSnackBar("Successfully Removed from Favourites", context, true);
        } else {
          BlocProvider.of<UserBloc>(context)
              .add(AddToFavouriteEvent(movie: movie));
          showSnackBar("Successfully Added To Favourites", context, true);
        }
      },
      icon: isFavourite
          ? const Icon(Icons.star_rounded)
          : const Icon(Icons.star_border_rounded),
      color: secondaryColor,
    );
  }
}
