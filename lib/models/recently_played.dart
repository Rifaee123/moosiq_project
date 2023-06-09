import 'package:hive_flutter/hive_flutter.dart';
part 'recently_played.g.dart';

@HiveType(typeId: 2)
class RecentlyPlayed {
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
  @HiveField(5)
  int? index;
  RecentlyPlayed(
      {this.songname,
      this.artist,
      this.duration,
      this.songurl,
      required this.id,
      required this.index});
}

String boxname2 = 'RecentlyPlayed';

class RecentlyPlayedBox1 {
  static Box<RecentlyPlayed>? _box;
  static Box<RecentlyPlayed> getInstance() {
    return _box ??= Hive.box(boxname2);
  }
}
