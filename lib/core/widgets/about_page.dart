import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_list/core/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 20,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        shadowColor: primaryColor,
        title: const Text(
          "Watch List",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _buildInfoWidget(),
        _buildUrlButtonsWidget(),
      ],
    ));
  }

  Widget _buildUrlButtonsWidget() {
    return Hero(
      tag: "navigation_to_about_page",
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: primaryColor.withAlpha(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildUrlButton("f", "https://www.facebook.com/hayyan.saleh.940",
                const Color.fromARGB(255, 226, 242, 255), Colors.blue),
            _buildUrlButton("GitHub", "https://github.com/Hayyan-Saleh",
                const Color.fromARGB(255, 186, 0, 177), Colors.white),
            _buildUrlButton(
                "in",
                "https://www.linkedin.com/in/hayyan-saleh-6476b1267/",
                const Color.fromARGB(255, 9, 93, 161),
                Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoWidget() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              colors: [primaryColor, Color.fromARGB(255, 80, 43, 0)])),
      child: const Column(
        children: [
          SizedBox(height: 30),
          Text(
            "About the Developer",
            style: TextStyle(
                color: Color.fromARGB(255, 232, 232, 232),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "This Simple Movies Project was done by Hayyan Saleh ! \n\nMy accounts :\n\nfacebook : https://www.facebook.com/hayyan.saleh.940 \n\nGithub : https://github.com/Hayyan-Saleh \n\nlinked in : https://www.linkedin.com/in/hayyan-saleh-6476b1267/ \n\n*you can click any Icon below to open the URL",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  MaterialButton _buildUrlButton(
      String name, String url, Color backgroundColor, Color foregroundColor) {
    return MaterialButton(
      elevation: 10,
      onPressed: () async {
        await _launchUrl(url);
      },
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(360)),
      child: Text(
        name,
        style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final parsedUrl = Uri.parse(url);
    try {
      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
      // ignore: empty_catches
    } catch (e) {}
  }
}
