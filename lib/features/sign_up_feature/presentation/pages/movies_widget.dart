import 'package:flutter/material.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("movies page"),
        centerTitle: true,
      ),
      body: const Center(child: Text("welcome !")),
    );
  }
}
