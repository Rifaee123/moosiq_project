import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/models/mostly_played1.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:moosiq_project/screens/nowPLayingslider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/recently_played.dart';

class MostlyPlay extends StatefulWidget {
  const MostlyPlay({super.key});

  @override
  State<MostlyPlay> createState() => _MostlyPlayState();
}

class _MostlyPlayState extends State<MostlyPlay> {
  final box = MostplayedBox.getInstance();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId("0");
  List<Audio> songs = [];
  List<MostPlayed> mostfinalsong = [];
  final List<RecentlyPlayed> recentplay = [];
  final box1 = RecentlyPlayedBox1.getInstance();
  List<Audio> rcentplay = [];
  @override
  void initState() {
    final List<RecentlyPlayed> recentlyplayed =
        box1.values.toList().reversed.toList();
    for (var item in recentlyplayed) {
      rcentplay.add(
        Audio.file(
          item.songurl.toString(),
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
      setState(() {});
    }

    List<MostPlayed> songlist = box.values.toList();
    int i = 0;
    for (var item in songlist) {
      if (item.count > 2) {
        mostfinalsong.insert(i, item);
        i++;
      }
    }
    for (var items in mostfinalsong) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomSheet: NowPlayingSlider(),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 270, top: 25, bottom: 80),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 180, bottom: 30, left: 25),
                  child: Text(
                    "Most Played",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Container(
                  height: 160,
                  child: ValueListenableBuilder<Box<MostPlayed>>(
                    valueListenable: box.listenable(),
                    builder: (context, Box<MostPlayed> mostplayedDB, child) {
                      List<MostPlayed> mostplayedsongs =
                          mostplayedDB.values.toList();
                      return mostfinalsong.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: mostfinalsong.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: Color.fromRGBO(180, 179, 244, 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(207, 19, 72, 247),
                                          child: IconButton(
                                              onPressed: () {
                                                _audioPlayer.open(
                                                  Playlist(
                                                      audios: songs,
                                                      startIndex: index),
                                                  showNotification: true,
                                                  headPhoneStrategy:
                                                      HeadPhoneStrategy
                                                          .pauseOnUnplug,
                                                );
                                              },
                                              icon: Icon(Icons.play_arrow)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 20),
                                              child: Text(mostfinalsong[index]
                                                  .songname),
                                            ))
                                      ],
                                    ),
                                  ),
                                  width: 130,
                                  height: 140,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Your most played songs will appear here!",
                              ),
                            );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, right: 110, bottom: 20),
                  child: Text(
                    "Recently Played",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                ValueListenableBuilder<Box<RecentlyPlayed>>(
                  valueListenable: box1.listenable(),
                  builder: (context, Box<RecentlyPlayed> RecenntDB, child) {
                    List<RecentlyPlayed> Recentplayed =
                        RecenntDB.values.toList().reversed.toList();
                    return Recentplayed.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: Recentplayed.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(197, 233, 233, 180),
                                    ),
                                    width: 350,
                                    height: 75,
                                    child: ListTile(
                                      onTap: () {
                                        _audioPlayer.open(
                                          Playlist(
                                              audios: rcentplay,
                                              startIndex: index),
                                          showNotification: true,
                                          headPhoneStrategy:
                                              HeadPhoneStrategy.pauseOnUnplug,
                                        );
                                      },
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                            "assets/Picsart_23-03-02_14-13-15-061.jpg"),
                                      ),
                                      title: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          Recentplayed[index].songname!,
                                        ),
                                      ),
                                      subtitle: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                            Recentplayed[index].artist ??
                                                "No Artist"),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.more_vert)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "You Have't played any songs",
                            ),
                          );
                  },
                )
              ],
            ),
          )),
    ));
  }
}
