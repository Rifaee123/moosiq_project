import 'package:flutter/material.dart';
import 'package:moosiq_project/screens/home_Screen.dart';
import 'package:moosiq_project/screens/search_screen.dart';

class ScrollScreen extends StatelessWidget {
  ScrollScreen({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [const HomeScreen(), SearchScreen()],
      ),
    );
  }
}
