
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/screens/search_screen.dart';

import '../../models/playlist_mode1l.dart';

final playlistbox = PlaylistSongsbox.getInstance();

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  final myController = TextEditingController();
  playlistbox.isNotEmpty
      ? showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: Color.fromARGB(162, 68, 24, 170),
                alignment: Alignment.bottomCenter,
                content: Container(
                  height: 200,
                  width: vwidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    insetPadding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    backgroundColor:
                                        Color.fromARGB(162, 68, 24, 170),
                                    alignment: Alignment.bottomCenter,
                                    content: Container(
                                      height: 250,
                                      width: vwidth,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Center(
                                                  child: Text(
                                                    'Create Playlist',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      width: vwidth * 0.90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Color.fromARGB(
                                                            185, 255, 255, 255),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          cursorColor:
                                                              Colors.black,
                                                          controller:
                                                              myController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            label: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0),
                                                              child: Text(
                                                                'Enter Playlist Name:',
                                                              ),
                                                            ),
                                                            // alignLabelWithHint: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      width: vwidth * 0.40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Color.fromARGB(
                                                            255, 224, 216, 189),
                                                      ),
                                                      child: TextButton.icon(
                                                        icon: const Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        label: Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      width: vwidth * 0.43,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Color.fromARGB(
                                                            255, 224, 216, 189),
                                                      ),
                                                      child: TextButton.icon(
                                                        icon: const Icon(
                                                          Icons.done,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          createplaylist(
                                                              myController
                                                                  .text);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        label: Text(
                                                          'Done',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                          ValueListenableBuilder<Box<PlaylistSongs1>>(
                            valueListenable: box.listenable(),
                            builder: (context,
                                Box<PlaylistSongs1> playlistsongs, child) {
                              List<PlaylistSongs1> playlistsong =
                                  playlistsongs.values.toList();
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: playlistsong.length,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    onTap: () {
                                      PlaylistSongs1? playsongs =
                                          playlistsongs.getAt(index);
                                      List<songModelDb> playsongdb =
                                          playsongs!.playlistssongs!;
                                      List<songModelDb> songdb =
                                          songbox.values.toList();
                                      bool isAlreadyAdded = playsongdb.any(
                                          (element) =>
                                              element.id ==
                                              songdb[songindex].id);
                                      if (!isAlreadyAdded) {
                                        playsongdb.add(
                                          songModelDb(
                                            songname:
                                                songdb[songindex].songname,
                                            artist: songdb[songindex].artist,
                                            duration:
                                                songdb[songindex].duration,
                                            songurl: songdb[songindex].songurl,
                                            id: songdb[songindex].id,
                                          ),
                                        );
                                      }
                                      playlistsongs.putAt(
                                          index,
                                          PlaylistSongs1(
                                              playlistname: playlistsong[index]
                                                  .playlistname,
                                              playlistssongs: playsongdb));
                                      // print(
                                      //     'song added to${playlistsong[index].playlistname}');
                                      Navigator.pop(context);
                                    },
                                    title: Text(
                                      playlistsong[index].playlistname!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      : showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Color.fromARGB(162, 68, 24, 170),
            alignment: Alignment.bottomCenter,
            content: Container(
              height: 250,
              width: vwidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Create Playlist',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: vwidth * 0.90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(185, 255, 255, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  controller: myController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Enter Playlist Name:',
                                      ),
                                    ),
                                    // alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: vwidth * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 224, 216, 189),
                              ),
                              child: TextButton.icon(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: Text(
                                  'Cancel',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: vwidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 224, 216, 189),
                              ),
                              child: TextButton.icon(
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  createplaylist(myController.text);
                                  Navigator.pop(context);
                                },
                                label: Text(
                                  'Done',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}

createplaylist(String name) async {
  final box1 = PlaylistSongsbox.getInstance();

  List<songModelDb> songsplaylist = [];

  box1.add(PlaylistSongs1(playlistname: name, playlistssongs: songsplaylist));
  // print(name);
}
