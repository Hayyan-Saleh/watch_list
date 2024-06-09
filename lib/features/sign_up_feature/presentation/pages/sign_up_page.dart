import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/features/sign_up_feature/domain/entities/user_entity.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/bloc/user_bloc.dart';
import 'package:watch_list/features/sign_up_feature/presentation/pages/movies_widget.dart';
import 'package:watch_list/features/sign_up_feature/presentation/widgets/custom_text_field_widget.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final randomNum = getRandomIntFromRange(1, 15);
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        _buildPicture(screenHeight, screenWidth),
        _buildFilter1(screenHeight, screenWidth),
        _buildFilter2(screenHeight, screenWidth),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FadeInDown(
              duration: const Duration(seconds: 1),
              child: _buildTitle(),
            ),
            FadeInRight(
              duration: const Duration(seconds: 2),
              child: _buildTextField(),
            ),
            FadeInUp(
              duration: const Duration(seconds: 2),
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserStoredState) {
                    showSnackBar(state.message, context, true);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const MoviesWidget()),
                        (route) => false);
                  }
                },
                child: _buildButton(context),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Container _buildFilter2(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.black,
            Colors.black.withAlpha(50),
            Colors.black
          ])),
    );
  }

  Container _buildFilter1(double height, double width) {
    return Container(
      height: height,
      width: width,
      color: secondaryColor.withAlpha(50),
    );
  }

  Image _buildPicture(double height, double width) {
    return Image.asset(
      'assets/pngs/background$randomNum.png',
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Welcome To Watch List !",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomTextFieldWidget(
        controller: _userNameController,
        formKey: _formKey,
        hintMessage: 'Enter your name here',
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  User user = User(
                      userName: _userNameController.text,
                      userFavouriteMovies: const []);
                  context.read<UserBloc>().add(CacheUserDataEvent(user: user));
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: const Text(
                "Watch Movies List",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
