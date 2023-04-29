import 'package:flutter/material.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/models/favourites_model.dart';
import 'package:moosiq_project/screens/Favorite_Screen.dart';
import 'package:moosiq_project/screens/function/dbfunctions.dart';
import '../../screens/splash_screen.dart';

addToFavourites(int songindex) async {
  List<songModelDb> dbsongs = box.values.toList();
  List<favourites> favouritessongs = [];
  favouritessongs = favouritesdb.values.toList();
  bool isAvalable = favouritessongs
      .where((element) => element.songname == dbsongs[songindex].songname)
      .isEmpty;
  if (isAvalable) {
    favouritesdb.add(favourites(
        songname: dbsongs[songindex].songname,
        artist: dbsongs[songindex].artist,
        duration: dbsongs[songindex].duration,
        songurl: dbsongs[songindex].songurl,
        id: dbsongs[songindex].id));
  } else {
    favouritessongs
        .where((element) => element.songname == dbsongs[songindex].songname)
        .isEmpty;
    int currentindex = favouritessongs
        .indexWhere((element) => element.id == dbsongs[songindex].id);
    await favouritesdb.deleteAt(currentindex);
    await favouritesdb.deleteAt(songindex);
  }
}

deletefavouritehome(int index, BuildContext context) async {
  await favouritesdb.deleteAt(favouritesdb.length - index - 1);
  // Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //       pageBuilder: (context, animation1, animation2) => FavorateScreen(),
  //       transitionDuration: Duration.zero,
  //       reverseTransitionDuration: Duration.zero,
  //     ));
}

deletefavourite(int index, BuildContext context) async {
  await favouritesdb.deleteAt(favouritesdb.length - index - 1);
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => FavorateScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ));
}

bool checkFavoriteStatus(int index, BuildContext ctx) {
  List<favourites> favouritessongs = [];
  List<songModelDb> dbsongs = box.values.toList();
  favourites value = favourites(
      songname: dbsongs[index].songname,
      artist: dbsongs[index].artist,
      duration: dbsongs[index].duration,
      songurl: dbsongs[index].songurl,
      id: dbsongs[index].id);

  favouritessongs = favouritesdb.values.toList();
  bool isAlreadyThere = favouritessongs
      .where((element) => element.songname == value.songname)
      .isEmpty;
  return isAlreadyThere ? true : false;
}

removefavourite(int index) async {
  final box4 = Favocuritesbox.getInstance();
  // List<favourites> favouritessongs = [];
  List<favourites> favsongs = box4.values.toList();
  List<songModelDb> dbsongs = box.values.toList();
  int currentindex =
      favsongs.indexWhere((element) => element.id == dbsongs[index].id);
  await favouritesdb.deleteAt(currentindex);
}
