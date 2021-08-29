// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  // transforming model to create Hive database adapter
  @HiveType(typeId: 1, adapterName: 'MovieAdapter')
  const factory Movie({
    @HiveField(0) required String title,
    @HiveField(1) String? posterPath,
    @HiveField(2) required int id,
    @HiveField(3) String? overview,
    @HiveField(4) @Default(false) bool isFavored,
    @HiveField(5) @Default(null) String? photoAsString,
  }) = _Movie;

// do not need toJson method
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

/*
class Movie with _$Movie {

  const factory Movie({
    required String title,
    String? posterPath,
    required int id,
    String? overview,
    @Default(false) bool isFavored,
  }) = _Movie;

// do not need toJson method
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
 }
  -----------
  with hive adapter:
  @freezed
class Movie with _$Movie {
  @HiveType(typeId: 0, adapterName: 'MovieAdapter')
  factory Movie({
    @JsonKey(name: 'title', required: true) @HiveField(0) required String title,
    @JsonKey(name: 'posterPath', required: false, disallowNullValue: false)
    @HiveField(1)
        String? posterPath,
    @JsonKey(name: 'id', required: true) @HiveField(2) required int id,
    @JsonKey(name: 'overview', required: false, disallowNullValue: false)
    @HiveField(3)
        String? overview,
    @JsonKey(name: 'isFavored', required: false, defaultValue: false)
    @HiveField(4)
    @Default(false)
        bool isFavored,
  }) = _Movie;


// do not need toJson method
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

 */
