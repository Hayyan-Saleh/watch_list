import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list/core/constants/lists.dart';
import 'package:watch_list/core/theme/app_theme.dart';
import 'package:watch_list/core/util/functions.dart';
import 'package:watch_list/core/widgets/custom_text_field_widget.dart';
import 'package:watch_list/features/movies_feature/presentation/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:watch_list/features/movies_feature/presentation/pages/results_page.dart';
import 'package:watch_list/features/movies_feature/presentation/widgets/other_widgets/drop_down_button.dart';

class SearchPage extends StatelessWidget {
  final MoviesListBloc moviesListBloc;
  final int randomNum = getRandomIntFromRange(1, 15);
  final DropDownButton countryDropDownButton = DropDownButton(
    buttonTitle: 'Include County Filter',
    dataList: REGION_LIST,
    dropDownTitle: 'Select a country',
  );
  final DropDownButton yearDropDownButton = DropDownButton(
    buttonTitle: 'Include Year Filter',
    dataList: YEAR_LIST,
    dropDownTitle: 'Select a year',
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController movieNameController = TextEditingController();
  SearchPage({required this.moviesListBloc, super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => moviesListBloc,
      child: BlocListener<MoviesListBloc, MoviesListState>(
        listener: (context, state) {
          if (state is SearchDoneMovieListState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ResultsPage(
                      searchedMovies: state.searchedMovies,
                      movieName: movieNameController.text,
                    )));
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Stack(children: [
            _buildBackground(height, width),
            _buildFilter(),
            _buildBody(height, width, context),
          ]),
        ),
      ),
    );
  }

  Widget _buildBody(double height, double width, BuildContext context) {
    return ListView(
      children: [
        FadeInDown(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.05 * width, vertical: 0.05 * height),
            child: CustomTextFieldWidget(
                controller: movieNameController,
                keyboardType: 1,
                icon: Icons.search,
                formKey: formKey,
                hintMessage: 'Enter your movie name'),
          ),
        ),
        FadeInLeft(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.1 * width, vertical: 0.01 * height),
              child: yearDropDownButton),
        ),
        FadeInRight(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.1 * width, vertical: 0.01 * height),
              child: countryDropDownButton),
        ),
        FadeInUp(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.1 * width, vertical: 0.1 * height),
              child: _buildSearchButton(context)),
        ),
      ],
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return BlocBuilder<MoviesListBloc, MoviesListState>(
      builder: (context, state) {
        Widget? loadingWidget;
        if (state is LoadingMoviesListState) {
          loadingWidget = const CircularProgressIndicator(
            color: Colors.black,
          );
        }
        return TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              moviesListBloc.add(SearchMovieListEvent(
                  query: movieNameController.text,
                  region: countryDropDownButton.selectedItem,
                  year: countryDropDownButton.selectedItem));
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  secondaryColor.withAlpha(200))),
          child: loadingWidget ??
              const Text(
                '         Find Movie          ',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: const Text(
        "Search For Movies",
        style: TextStyle(
            fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
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
    return SizedBox(
      width: width,
      height: height * 3 + height / 3,
      child: Image.asset(
        'assets/pngs/background$randomNum.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
