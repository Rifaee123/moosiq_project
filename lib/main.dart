import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/models/favourites_model.dart';
import 'package:moosiq_project/models/playlist_mode1l.dart';
import 'package:moosiq_project/screens/function/dbfunctions.dart';

import 'package:moosiq_project/screens/splash_screen.dart';

import 'models/mostly_played1.dart';
import 'models/recently_played.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(songModelDbAdapter());

  await Hive.openBox<songModelDb>(boxname);
  Hive.registerAdapter(favouritesAdapter());
  openFavouritesDB();
  Hive.registerAdapter(PlaylistSongs1Adapter());
  await Hive.openBox<PlaylistSongs1>('playlist');
  Hive.registerAdapter(RecentlyPlayedAdapter());
  openrecentlyplayeddb();
  Hive.registerAdapter(MostPlayedAdapter());
  await Hive.openBox<MostPlayed>('MostPlayed');
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: splash_screen());
  }
}
