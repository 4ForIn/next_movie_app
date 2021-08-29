// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<_$_Movie> {
  @override
  final int typeId = 1;

  @override
  _$_Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Movie(
      title: fields[0] as String,
      posterPath: fields[1] as String?,
      id: fields[2] as int,
      overview: fields[3] as String?,
      isFavored: fields[4] as bool,
      photoAsString: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Movie obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.posterPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.overview)
      ..writeByte(4)
      ..write(obj.isFavored)
      ..writeByte(5)
      ..write(obj.photoAsString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$_$_MovieFromJson(Map<String, dynamic> json) {
  return _$_Movie(
    title: json['title'] as String,
    posterPath: json['posterPath'] as String?,
    id: json['id'] as int,
    overview: json['overview'] as String?,
    isFavored: json['isFavored'] as bool? ?? false,
    photoAsString: json['photoAsString'] as String?,
  );
}

Map<String, dynamic> _$_$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'title': instance.title,
      'posterPath': instance.posterPath,
      'id': instance.id,
      'overview': instance.overview,
      'isFavored': instance.isFavored,
      'photoAsString': instance.photoAsString,
    };
