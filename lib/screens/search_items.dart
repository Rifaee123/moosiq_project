import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: camel_case_types
class Search_items extends StatefulWidget {
  const Search_items({super.key});

  @override
  State<Search_items> createState() => _search_itemsState();
}

class _search_itemsState extends State<Search_items> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();
  late List<songModelDb> dbSongs;
  @override
  void initState() {
    dbSongs = box.values.toList();
    for (var item in dbSongs) {
      allSongs.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }

    super.initState();
  }

  List<Audio> allSongs = [];
  final TextEditingController myController = TextEditingController();
  late List<songModelDb> another = List.from(dbSongs);

  bool istaped = true;
  final songbox = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    double vwidth = MediaQuery.of(context).size.width;
    double vheight = MediaQuery.of(context).size.height;
    return Container(
      color: Color.fromARGB(255, 24, 23, 23),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/allScreen.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      bottom: 40,
                    ),
                    child: Container(
                      height: 47,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 1)),
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'What do you want to listen ?'),
                        onChanged: (value) => updateList(value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: another.length,
                      itemBuilder: ((context, index) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 5),
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                keepOldArtwork: true,
                                artworkBorder: BorderRadius.circular(10),
                                id: another[index].id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/Picsart_23-03-02_14-13-15-061.jpg',
                                    height: vheight * 0.06,
                                    width: vheight * 0.06,
                                  ),
                                ),
                              ),
                              title: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  another[index].songname!,
                                ),
                              ),
                              subtitle: Text(
                                another[index].artist ?? "No Artist",
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _audioPlayer.open(
                                    Playlist(
                                        audios: allSongs, startIndex: index),
                                    showNotification: true,
                                    headPhoneStrategy:
                                        HeadPhoneStrategy.pauseOnUnplug,
                                    loopMode: LoopMode.playlist);
                                NowplayingScreen.nowplayingindex.value = index;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NowplayingScreen(index: index),
                                    ));
                              },
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateList(String value) {
    setState(
      () {
        another = dbSongs
            .where((element) =>
                element.songname!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        allSongs.clear();
        for (var item in another) {
          allSongs.add(
            Audio.file(
              item.songurl.toString(),
              metas: Metas(
                artist: item.artist,
                title: item.songname,
                id: item.id.toString(),
              ),
            ),
          );
        }
      },
    );
  }
}
