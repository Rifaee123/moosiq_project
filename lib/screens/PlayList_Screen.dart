import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moosiq_project/db/db_function/PlaylistFunction.dart';
import 'package:moosiq_project/models/playlist_mode1l.dart';

import 'package:moosiq_project/screens/Playlist_songs_screen.dart';
import 'package:moosiq_project/screens/function/playlistfungtion.dart';
import 'package:moosiq_project/widgets/popoups.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  // final playlistbox = PlaylistSongsbox.getInstance();
  // late List<PlaylistSongs1> playlistsong = playlistbox.values.toList();
  

  SampleItem? selectedMenu;
  final playlistsong = playlistfnc();
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 40,
                      )),
                ),
                const Text(
                  "All Playlist",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 10),
                  child: IconButton(
                      onPressed: () {
                        openDialog(context);
                      },
                      icon: const Icon(
                        Icons.playlist_add,
                        size: 50,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          
          ValueListenableBuilder<Box<PlaylistSongs1>>(
              valueListenable: playlistbox.listenable(),
              builder: (context, Box<PlaylistSongs1> playlistsongs, child) {
                List<PlaylistSongs1> playlistsong =
                    playlistsongs.values.toList();
                return playlistsong.isNotEmpty
                    ? Expanded(
                        child: (ListView.builder(
                            shrinkWrap: true,
                            itemCount: playlistsong.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: const Color.fromARGB(197, 233, 233, 180),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaylistSongs(
                                                      playindex: index,
                                                      playlistname:
                                                          playlistsong[index]
                                                              .playlistname)));
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        playlistsong[index].playlistname!,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            openDialogedit(context, index);
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              deletePlaylist(index);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }))),
                      )
                    : const Text("No Playlist Found");
              }),
        ],
      ),
    ));
  }

  Widget popup() {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
          
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: InkWell(child: Text('Rename')),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: InkWell(child: Text('delete')),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: InkWell(child: Text('playAll')),
        ),
      ],
    );
  }

  Widget listitems(String name, context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaylistSongs(
                      playindex: index,
                      playlistname: playlistsong[index].playlistname)));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: const Color.fromARGB(197, 233, 233, 180),
            ),
            child: ListTile(
                title: Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: popup())),
      ),
    );
  }
}
