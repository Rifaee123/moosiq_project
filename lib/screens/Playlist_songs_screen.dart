import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/db/db_function/PlaylistFunction.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/models/playlist_mode1l.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:moosiq_project/screens/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongs extends StatefulWidget {
  PlaylistSongs(
      {super.key, required int this.playindex, required this.playlistname});
  int? playindex;
  String? playlistname;
  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertAudios = [];
  @override
  void initState() {
    final playbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs1> playlistsong = playbox.values.toList();
    for (var item in playlistsong[widget.playindex!].playlistssongs!) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    playlistsongfnc(widget.playindex!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final playbox = PlaylistSongsbox.getInstance();
    List<PlaylistSongs1> playlistsong = playbox.values.toList();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/playlist_page.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 130, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 40,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 30,
                      ),
                      child: Text(
                        playlistsong[widget.playindex!].playlistname!,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 40,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: ValueListenableBuilder<Box<PlaylistSongs1>>(
                      valueListenable: playbox.listenable(),
                      builder:
                          (context, Box<PlaylistSongs1> playlistsongs, child) {
                        log("play");
                        List<PlaylistSongs1> playlistsong =
                            playlistsongs.values.toList().toList();
                        List<songModelDb>? playsong =
                            playlistsong[widget.playindex!].playlistssongs;
                        return playsong!.isNotEmpty
                            ? ListView.builder(
                                itemCount: playsong.length,
                                itemBuilder: ((context, index) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 28, right: 18, bottom: 15),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          color: const Color.fromARGB(
                                              197, 233, 233, 180),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            audioPlayer.open(
                                                Playlist(
                                                    audios: convertAudios,
                                                    startIndex: index),
                                                showNotification: true,
                                                headPhoneStrategy:
                                                    HeadPhoneStrategy
                                                        .pauseOnUnplug,
                                                loopMode: LoopMode.playlist);
                                            NowplayingScreen
                                                .nowplayingindex.value = index;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NowplayingScreen(
                                                          index: index),
                                                ));
                                          },
                                          leading: QueryArtworkWidget(
                                              id: playlistsong[
                                                      widget.playindex!]
                                                  .playlistssongs![index]
                                                  .id!,
                                              type: ArtworkType.AUDIO,
                                              nullArtworkWidget: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.asset(
                                                  'assets/Picsart_23-03-02_14-13-15-061.jpg',
                                                ),
                                              )),
                                          title: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              playsong[index].songname!,
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          subtitle: Text(
                                            playsong[index].artist ??
                                                "No Artist",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    playsong.removeAt(index);
                                                    playlistsong.removeAt(
                                                        widget.playindex!);
                                                    playbox.putAt(
                                                        widget.playindex!,
                                                        PlaylistSongs1(
                                                            playlistname: widget
                                                                .playlistname!,
                                                            playlistssongs:
                                                                playsong));
                                                  },
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation1,
                                                            animation2) =>
                                                        PlaylistSongs(
                                                            playindex: widget
                                                                .playindex!,
                                                            playlistname: widget
                                                                .playlistname),
                                                    transitionDuration:
                                                        Duration.zero,
                                                    reverseTransitionDuration:
                                                        Duration.zero,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 31, 30, 30),
                                              )),
                                        ),
                                      ),
                                    )))
                            : const Text(
                                "You haven't Liked any songs!",
                              );
                      }))
            ],
          ) /* add child content here */,
        ),
      ),
    );
  }

  Widget listitems(assetImage, String name, String subname, context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 30),
      child: InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => NowplayingScreen()));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: const Color.fromARGB(197, 233, 233, 180),
            ),
            child: ListTile(
              leading: ClipRRect(
                child: Image.asset(
                  "$assetImage",
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              title: Text(
                name,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text(subname),
              trailing: const InkWell(child: Icon(Icons.favorite_sharp)),
            )),
      ),
    );
  }
}
