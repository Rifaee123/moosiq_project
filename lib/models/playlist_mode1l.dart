
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moosiq_project/models/data_models.dart';

part 'playlist_mode1l.g.dart';

@HiveType(typeId: 4)
class PlaylistSongs1 {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<songModelDb>? playlistssongs;
  PlaylistSongs1({required this.playlistname, required this.playlistssongs});
}

class PlaylistSongsbox {
  static Box<PlaylistSongs1>? _box;
  static Box<PlaylistSongs1> getInstance() {
    return _box ??= Hive.box('playlist');
  }
}
