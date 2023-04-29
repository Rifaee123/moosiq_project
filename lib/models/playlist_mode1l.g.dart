// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_mode1l.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistSongs1Adapter extends TypeAdapter<PlaylistSongs1> {
  @override
  final int typeId = 4;

  @override
  PlaylistSongs1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistSongs1(
      playlistname: fields[0] as String?,
      playlistssongs: (fields[1] as List?)?.cast<songModelDb>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistSongs1 obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistname)
      ..writeByte(1)
      ..write(obj.playlistssongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistSongs1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
