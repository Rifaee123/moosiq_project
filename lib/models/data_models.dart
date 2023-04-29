import 'package:hive_flutter/hive_flutter.dart';
part 'data_models.g.dart';

@HiveType(typeId: 1)
class songModelDb {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  songModelDb(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.id,
      required this.songurl});

  
}

String boxname = 'Songs';

class SongBox {
  static Box<songModelDb>? _box;
  static Box<songModelDb> getInstance() {
    return _box ??= Hive.box(boxname);
  }
}
