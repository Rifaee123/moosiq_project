import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:moosiq_project/models/data_models.dart';
import 'package:moosiq_project/models/playlist_mode1l.dart';

createplaylist(String name, BuildContext context) async {
  final box1 = PlaylistSongsbox.getInstance();

  List<songModelDb> songsplaylist = [];
  List<PlaylistSongs1> songlist = box1.values.toList();
  bool alredy =
      songlist.where((element) => element.playlistname == name).isEmpty;
  if (alredy) {
    box1.add(PlaylistSongs1(playlistname: name, playlistssongs: songsplaylist));
  } else {
    const snackbar = SnackBar(
      content: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'This name alredy taken',
          style: TextStyle(color: Colors.red),
        ),
      ),
      dismissDirection: DismissDirection.down,
      elevation: 10,
      padding: EdgeInsets.only(top: 10, bottom: 15),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  // print(name);
}

deletePlaylist(int index) {
  final box1 = PlaylistSongsbox.getInstance();

  box1.deleteAt(index);
}

editPlaylist(String name, index) async {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs1> playlistsong = playlistbox.values.toList();
  final box1 = PlaylistSongsbox.getInstance();

  box1.putAt(
      index,
      PlaylistSongs1(
          playlistname: name,
          playlistssongs: playlistsong[index].playlistssongs));
}

List<PlaylistSongs1> playlistfnc() {
  final playlistbox = PlaylistSongsbox.getInstance();
  return playlistbox.values.toList();
}

playlistsongfnc(int playindex) {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertAudios = [];
  final playbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs1> playlistsong = playbox.values.toList();

  for (var item in playlistsong[playindex].playlistssongs!) {
    convertAudios.add(Audio.file(item.songurl!,
        metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString())));
  }
}
