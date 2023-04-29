import 'package:flutter/material.dart';

import 'package:moosiq_project/screens/Favorite_Screen.dart';

import 'package:moosiq_project/screens/unFavoriteScreen.dart';

class favorateScrollScreen extends StatelessWidget {
  favorateScrollScreen({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [FavorateScreen(), unFavorteScreen()],
      ),
    );
  }
}
