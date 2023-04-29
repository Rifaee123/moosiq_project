import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/db/db_function/addFavouraties.dart';
import 'package:moosiq_project/models/favourites_model.dart';
import 'package:moosiq_project/screens/NowPlaying_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({super.key});

  @override
  State<FavorateScreen> createState() => _FavorateScreenState();
}

final _audioplayar = AssetsAudioPlayer.withId('0');

class _FavorateScreenState extends State<FavorateScreen> {
  final List<favourites> favourite = [];
  final box = Favocuritesbox.getInstance();
  bool isAvalabile = true;
  List<Audio> favsong = [];

  @override
  void initState() {
    final List<favourites> favouritesongs =
        box.values.toList().reversed.toList();
    for (var item in favouritesongs) {
      favsong.add(
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
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/allScreen.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, bottom: 80),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          "Favourite",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
                // ValueListenableBuilder<Box<favourites>>(
                //   valueListenable: box.listenable(),
                //   builder: (context, Box<favourites> favouriteDB, child) {
                //     log("added");
                //     List<favourites> favouritesongs =
                //         favouriteDB.values.toList().reversed.toList();
                //     return favouritesongs.isNotEmpty
                //         ? Container(
                //             child: Expanded(
                //               child: (ListView.builder(
                //                 // reverse: true,
                //                 // physics: const NeverScrollableScrollPhysics(),
                //                 // shrinkWrap: true,
                //                 itemCount: favouritesongs.length,
                //                 itemBuilder: ((context, index) => Padding(
                //                       padding: const EdgeInsets.only(
                //                           bottom: 8.0, left: 5),
                //                       child: ListTile(
                //                           onTap: () {
                //                             _audioPlayer.open(
                //                                 Playlist(
                //                                     audios: favsong,
                //                                     startIndex: index),
                //                                 showNotification: true,
                //                                 headPhoneStrategy:
                //                                     HeadPhoneStrategy
                //                                         .pauseOnUnplug,
                //                                 loopMode: LoopMode.playlist);
                //                             // print(index);
                //                           },
                //                           leading: QueryArtworkWidget(
                //                             keepOldArtwork: true,
                //                             artworkBorder:
                //                                 BorderRadius.circular(10),
                //                             id: favouritesongs[index].id!,
                //                             type: ArtworkType.AUDIO,
                //                             nullArtworkWidget: ClipRRect(
                //                               borderRadius:
                //                                   BorderRadius.circular(10),
                //                               child: Image.asset(
                //                                 'assets/images/music.jpeg',
                //                               ),
                //                             ),
                //                           ),
                //                           title: Text(
                //                             favouritesongs[index].songname!,
                //                           ),
                //                           subtitle: Text(
                //                             favouritesongs[index].artist ??
                //                                 "No Artist",
                //                             overflow: TextOverflow.ellipsis,
                //                           ),
                //                           trailing: IconButton(
                //                               onPressed: () {},
                //                               icon: const Icon(Icons.favorite),
                //                               color: Colors.white)),
                //                     )),
                //               )),
                //             ),
                //           )
                //         : Text(
                //             "You haven't Liked any songs!",
                //           );
                //   },
                // ),
                ValueListenableBuilder<Box<favourites>>(
                    valueListenable: Favocuritesbox.getInstance().listenable(),
                    builder: (context, Box<favourites> favouriteDB, child) {
                      log("added");
                      List<favourites> favouritesongs =
                          favouriteDB.values.toList().reversed.toList();
                      return favouritesongs.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: favouritesongs.length,
                                  itemBuilder: ((context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(45),
                                            color: const Color.fromARGB(
                                                197, 233, 233, 180),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              _audioplayar.open(
                                                  Playlist(
                                                      audios: favsong,
                                                      startIndex: index),
                                                  showNotification: true,
                                                  headPhoneStrategy:
                                                      HeadPhoneStrategy
                                                          .pauseOnUnplug,
                                                  loopMode: LoopMode.playlist);
                                              NowplayingScreen.nowplayingindex
                                                  .value = index;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NowplayingScreen(
                                                            index: NowplayingScreen
                                                                .nowplayingindex
                                                                .value),
                                                  ));
                                            },
                                            leading: QueryArtworkWidget(
                                                id: favouritesongs[index].id!,
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
                                                favouritesongs[index].songname!,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            subtitle: Text(
                                              favouritesongs[index].artist ??
                                                  "No Artist",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            trailing: IconButton(
                                                onPressed: () {
                                                  deletefavourite(
                                                      index, context);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 31, 30, 30),
                                                )),
                                          ),
                                        ),
                                      ))),
                            )
                          : Column(
                              children: [
                                const Text(
                                  "You haven't Liked any songs!",
                                ),
                                Text(
                                  "${favouritesongs.length}",
                                ),
                              ],
                            );
                    })
              ],
            ),
          ), /* add child content here */
        ),
      ),
    );
  }
  //  Widget listitems(assetImage, String name, String subname, context) {
  //   return InkWell(
  //     onTap: () {
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (context) => NowplayingScreen()));
  //     },
  //     child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(45),
  //           color: Color.fromARGB(197, 233, 233, 180),
  //         ),
  //         child: ListTile(
  //           leading:
  //           QueryArtworkWidget(id: , type: type)
  //           // ClipRRect(
  //           //   child: Image.asset(
  //           //     "$assetImage",
  //           //   ),
  //           //   borderRadius: BorderRadius.circular(40),
  //           // ),
  //           ,
  //           title: Text(
  //             name,
  //             style: TextStyle(fontSize: 18),
  //           ),
  //           subtitle: Text(subname),
  //           trailing: InkWell(child: Icon(Icons.favorite_sharp)),
  //         )),
  //   );
  // }
}
