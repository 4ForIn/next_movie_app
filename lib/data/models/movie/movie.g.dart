// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

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
  );
}

Map<String, dynamic> _$_$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'title': instance.title,
      'posterPath': instance.posterPath,
      'id': instance.id,
      'overview': instance.overview,
      'isFavored': instance.isFavored,
    };
