import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movies_list_bloc/movies_list_bloc.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final String message;
  const ConnectionErrorWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorAnimation(),
          const SizedBox(
            height: 10,
          ),
          _buildErrorMessage(message),
          const SizedBox(
            height: 10,
          ),
          if (message != EMPTY_CACHE_FAILURE_MESSAGE)
            _buildReconnectButton(context)
        ],
      ),
    );
  }

  Widget _buildErrorAnimation() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage(
                LOADING1_PATH,
              ),
              fit: BoxFit.scaleDown)),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildReconnectButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          BlocProvider.of<MoviesListBloc>(context).add(GetMoviesListEvent());
        },
        iconSize: 50,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
        icon: const Icon(
          Icons.restart_alt_rounded,
          color: Colors.black,
        ));
  }
}
