import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/db/db_function/addFavouraties.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:moosiq_project/models/mostly_played1.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:moosiq_project/screens/function/playlistfungtion.dart';
import 'package:moosiq_project/screens/search_items.dart';
import 'package:moosiq_project/screens/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/recently_played.dart';
import 'function/dbfunctions.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final alldbsongs = SongBox.getInstance();
List<songModelDb> allDbsongs = alldbsongs.values.toList();
final songbox = SongBox.getInstance();
final List<MostPlayed> mostplayedsong = mostbox.values.toList();

class _SearchScreenState extends State<SearchScreen> {
  List<Audio> convertedAudio = [];
  bool istaped = true;
  late List<songModelDb> another = List.from(allDbsongs);
  void serchListUpdated(String value) {
    setState(() {
      another = allDbsongs
          .where((item) =>
              item.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      convertedAudio.clear();
      for (var item in another) {
        convertedAudio.add(Audio.file(item.songurl.toString(),
            metas: Metas(
                artist: item.artist,
                title: item.songname,
                id: item.id.toString())));
      }
    });
  }

  @override
  void initState() {
    List<songModelDb> dbSongs = songbox.values.toList();
    for (var element in dbSongs) {
      convertedAudio.add(Audio.file(element.songurl!,
          metas: Metas(
              title: element.songname,
              artist: element.artist,
              id: element.id.toString())));
    }
    super.initState();
  }

  // final _searchController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  int currentindex = 0;

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<SongModel> allSongs = [];
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      audioPlayer.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            audioPlayer.open(
                Playlist(audios: convertedAudio, startIndex: currentindex),
                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                showNotification: true,
                loopMode: LoopMode.playlist);
            NowplayingScreen.indexvalue = currentindex;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NowplayingScreen(index: currentindex),
                ));
          },
          child: const Icon(Icons.play_arrow),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.arrow_drop_up_outlined,
                size: 50,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "All Songs",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Search_items(),
                              ));
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 50,
                          color: Colors.white,
                          weight: 2,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ValueListenableBuilder<Box<songModelDb>>(
                          valueListenable: songbox.listenable(),
                          builder:
                              ((context, Box<songModelDb> allSongsbox, child) {
                            log("hello");
                            List<songModelDb> allDbSongs =
                                allSongsbox.values.toList();
                            return ListView.builder(
                                itemCount: allDbSongs.length,
                                itemBuilder: ((context, songindex) {
                                  return Column(
                                    children: [
                                      Searchitems(
                                          songindex,
                                          allDbSongs[songindex].songname!,
                                          allDbSongs[songindex].artist!,
                                          context),
                                      sapratedbar()
                                    ],
                                  );
                                }));
                          })))),
            ],
          ) /* add child content here */,
        ),
      ),
    );
  }

  Widget sapratedbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 1,
        width: 10,
        color: Colors.black,
      ),
    );
  }

  Widget Searchitems(
      songindex, String name, String subname, BuildContext context) {
    RecentlyPlayed rsongs;
    songModelDb songs = allDbsongs[songindex];
    MostPlayed mostsong = mostplayedsong[songindex];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Text("${songindex + 1}"),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            name,
            style: const TextStyle(fontSize: 18),
            maxLines: 1,
          ),
        ),
        subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Text(subname)),
        trailing: PopupMenuButton<SampleItem>(
          initialValue: selectedMenu,
          // Callback that sets the selected popup menu item.
          onSelected: (value) async {
            switch (value) {
              case SampleItem.itemOne:
                if (checkFavoriteStatus(songindex, context)) {
                  addToFavourites(songindex);
                  const snackbar = SnackBar(
                    content: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Added to Favourites',
                      ),
                    ),
                    dismissDirection: DismissDirection.down,
                    elevation: 10,
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } else if (!checkFavoriteStatus(songindex, context)) {
                  removefavourite(songindex);
                }
                setState(
                  () {
                    istaped = !istaped;
                  },
                );

                break;
              case SampleItem.itemTwo:
                showPlaylistOptions(context, songindex);
                break;
              case SampleItem.itemThree:
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            PopupMenuItem<SampleItem>(
              onTap: () {},
              value: SampleItem.itemOne,
              child: Row(
                children: [
                  const Text('Add favourites'),
                  Icon(Icons.favorite,
                      color: (checkFavoriteStatus(songindex, context))
                          ? const Color.fromARGB(255, 136, 130, 130)
                          : const Color.fromARGB(255, 223, 10, 10))
                ],
              ),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: Text('Add Playlist '),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child: Text('Remove'),
            ),
          ],
        ),
        onTap: () {
          audioPlayer.open(
              Playlist(audios: convertedAudio, startIndex: songindex),
              headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
              showNotification: true,
              loopMode: LoopMode.playlist);
          NowplayingScreen.nowplayingindex.value = songindex;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NowplayingScreen(
                  index: songindex,
                ),
              ));
          setState(() {});
          rsongs = RecentlyPlayed(
              id: songs.id,
              artist: songs.artist,
              duration: songs.duration,
              songname: songs.songname,
              songurl: songs.songurl,
              index: songindex);

          updateRecentlyPlayed(rsongs);
          updatePlayedSongsCount(mostsong, songindex);
        },
      ),
    );
  }
}
