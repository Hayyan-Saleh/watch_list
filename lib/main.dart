import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/strings.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/core/widgets/loading_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/movies_lists_page.dart';
import 'package:watch_list/features/sign_up_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:watch_list/features/sign_up_feature/presentation/pages/sign_up_page.dart';
import 'package:watch_list/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(BlocProvider<UserBloc>(
    create: (context) => di.sl<UserBloc>()..add(GetUserDataEvent()),
    child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSplashScreen(context);
  }

  Widget _buildSplashScreen(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return FlutterSplashScreen.fadeIn(
      animationDuration: const Duration(seconds: 5),
      duration: const Duration(seconds: 5),
      childWidget: SizedBox(
          height: 0.5 * height,
          width: 0.7 * width,
          child: Padding(
            padding: EdgeInsets.only(left: 0.04 * width),
            child: Image.asset(LOADING3_PATH),
          )),
      nextScreen: _handelNextScreen(),
      backgroundImage: _buildPicture(height, width),
    );
  }

  Widget _handelNextScreen() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        Widget nextScreen = const Placeholder();
        if (state is UserLoadedState) {
          nextScreen = const MoviesListsPage();
        } else if (state is UserLoadingState) {
          nextScreen = const Scaffold(body: LoadingWidget());
        } else if (state is UserErrorState) {
          nextScreen = SignUpPage();
        } else if (state is UserStoredState) {
          nextScreen = const MoviesListsPage();
        }
        return nextScreen;
      },
    );
  }

  Image _buildPicture(double height, double width) {
    return Image.asset(
      'assets/pngs/background${getRandomIntFromRange(1, 15)}.png',
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
