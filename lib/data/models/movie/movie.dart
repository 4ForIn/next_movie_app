// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// like: part 'freezed_classes.g.dart'
part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
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
