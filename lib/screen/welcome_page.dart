import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';

class WelcomePage extends StatefulWidget {
  static String route = "/welcome";

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _controller;
  int currentPage = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: _controller,
              children: [
                _getPage(
                    urlImage: "assets/splash1.svg",
                    title: "Sudoku app",
                    description:
                        "Sudoku is a popular logic-based number-placement puzzle game 1. The game consists of a 9x9 grid with numbers appearing in some of the squares 2."),
                _getPage(
                    urlImage: "assets/splash2.svg",
                    title: "Easy version",
                    description:
                        "It's evaluated are the 3 x 3 box so it is sufficient not to repeat the numevr"),
                _getPage(
                  urlImage: "assets/splash3.svg",
                  title: "Try to play",
                  description: "Test yourself and play ",
                ),
              ],
            ),
            if (currentPage == 2) ...[
              Positioned(
                bottom: 150,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(20),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade700)),
                    onPressed: () => {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomePage.route, (route) => false)
                        },
                    child: const Text(
                      "Start Game",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
            Positioned(bottom: 20, left: 0, right: 0, child: _indicator())
          ],
        ));
  }

  _getPage({
    required String urlImage,
    required String title,
    required String description,
  }) =>
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            urlImage,
            height: 300,
          ),
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
                fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ));

  _indicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _indicatorButton(indexPage: 0),
          _indicatorButton(indexPage: 1),
          _indicatorButton(indexPage: 2),
        ],
      );

  _goPage({required int indexPage}) {
    if (currentPage != indexPage) {
      if (_controller.hasClients) {
        _controller.animateToPage(indexPage,
            duration: const Duration(milliseconds: 1), curve: Curves.linear);
        currentPage = indexPage;
        setState(() {});
      }
    }
  }

  _indicatorButton({required int indexPage}) => IconButton(
      onPressed: () => _goPage(indexPage: indexPage),
      icon: CircleAvatar(
        radius: 8,
        backgroundColor: currentPage == indexPage
            ? Theme.of(context).primaryColor
            : Colors.black45,
      ));
}
