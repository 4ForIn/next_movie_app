// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return _Movie.fromJson(json);
}

/// @nodoc
class _$MovieTearOff {
  const _$MovieTearOff();

  _Movie call(
      {@HiveField(0) required String title,
      @HiveField(1) String? posterPath,
      @HiveField(2) required int id,
      @HiveField(3) String? overview,
      @HiveField(4) bool isFavored = false,
      @HiveField(5) String? photoAsString = null}) {
    return _Movie(
      title: title,
      posterPath: posterPath,
      id: id,
      overview: overview,
      isFavored: isFavored,
      photoAsString: photoAsString,
    );
  }

  Movie fromJson(Map<String, Object> json) {
    return Movie.fromJson(json);
  }
}

/// @nodoc
const $Movie = _$MovieTearOff();

/// @nodoc
mixin _$Movie {
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get posterPath => throw _privateConstructorUsedError;
  @HiveField(2)
  int get id => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get overview => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isFavored => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get photoAsString => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieCopyWith<Movie> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieCopyWith<$Res> {
  factory $MovieCopyWith(Movie value, $Res Function(Movie) then) =
      _$MovieCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String? posterPath,
      @HiveField(2) int id,
      @HiveField(3) String? overview,
      @HiveField(4) bool isFavored,
      @HiveField(5) String? photoAsString});
}

/// @nodoc
class _$MovieCopyWithImpl<$Res> implements $MovieCopyWith<$Res> {
  _$MovieCopyWithImpl(this._value, this._then);

  final Movie _value;
  // ignore: unused_field
  final $Res Function(Movie) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? posterPath = freezed,
    Object? id = freezed,
    Object? overview = freezed,
    Object? isFavored = freezed,
    Object? photoAsString = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: posterPath == freezed
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      overview: overview == freezed
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavored: isFavored == freezed
          ? _value.isFavored
          : isFavored // ignore: cast_nullable_to_non_nullable
              as bool,
      photoAsString: photoAsString == freezed
          ? _value.photoAsString
          : photoAsString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MovieCopyWith<$Res> implements $MovieCopyWith<$Res> {
  factory _$MovieCopyWith(_Movie value, $Res Function(_Movie) then) =
      __$MovieCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String? posterPath,
      @HiveField(2) int id,
      @HiveField(3) String? overview,
      @HiveField(4) bool isFavored,
      @HiveField(5) String? photoAsString});
}

/// @nodoc
class __$MovieCopyWithImpl<$Res> extends _$MovieCopyWithImpl<$Res>
    implements _$MovieCopyWith<$Res> {
  __$MovieCopyWithImpl(_Movie _value, $Res Function(_Movie) _then)
      : super(_value, (v) => _then(v as _Movie));

  @override
  _Movie get _value => super._value as _Movie;

  @override
  $Res call({
    Object? title = freezed,
    Object? posterPath = freezed,
    Object? id = freezed,
    Object? overview = freezed,
    Object? isFavored = freezed,
    Object? photoAsString = freezed,
  }) {
    return _then(_Movie(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: posterPath == freezed
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      overview: overview == freezed
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavored: isFavored == freezed
          ? _value.isFavored
          : isFavored // ignore: cast_nullable_to_non_nullable
              as bool,
      photoAsString: photoAsString == freezed
          ? _value.photoAsString
          : photoAsString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'MovieAdapter')
class _$_Movie with DiagnosticableTreeMixin implements _Movie {
  const _$_Movie(
      {@HiveField(0) required this.title,
      @HiveField(1) this.posterPath,
      @HiveField(2) required this.id,
      @HiveField(3) this.overview,
      @HiveField(4) this.isFavored = false,
      @HiveField(5) this.photoAsString = null});

  factory _$_Movie.fromJson(Map<String, dynamic> json) =>
      _$_$_MovieFromJson(json);

  @override
  @HiveField(0)
  final String title;
  @override
  @HiveField(1)
  final String? posterPath;
  @override
  @HiveField(2)
  final int id;
  @override
  @HiveField(3)
  final String? overview;
  @JsonKey(defaultValue: false)
  @override
  @HiveField(4)
  final bool isFavored;
  @JsonKey(defaultValue: null)
  @override
  @HiveField(5)
  final String? photoAsString;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Movie(title: $title, posterPath: $posterPath, id: $id, overview: $overview, isFavored: $isFavored, photoAsString: $photoAsString)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Movie'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('posterPath', posterPath))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('isFavored', isFavored))
      ..add(DiagnosticsProperty('photoAsString', photoAsString));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Movie &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality()
                    .equals(other.posterPath, posterPath)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality()
                    .equals(other.overview, overview)) &&
            (identical(other.isFavored, isFavored) ||
                const DeepCollectionEquality()
                    .equals(other.isFavored, isFavored)) &&
            (identical(other.photoAsString, photoAsString) ||
                const DeepCollectionEquality()
                    .equals(other.photoAsString, photoAsString)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(isFavored) ^
      const DeepCollectionEquality().hash(photoAsString);

  @JsonKey(ignore: true)
  @override
  _$MovieCopyWith<_Movie> get copyWith =>
      __$MovieCopyWithImpl<_Movie>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MovieToJson(this);
  }
}

abstract class _Movie implements Movie {
  const factory _Movie(
      {@HiveField(0) required String title,
      @HiveField(1) String? posterPath,
      @HiveField(2) required int id,
      @HiveField(3) String? overview,
      @HiveField(4) bool isFavored,
      @HiveField(5) String? photoAsString}) = _$_Movie;

  factory _Movie.fromJson(Map<String, dynamic> json) = _$_Movie.fromJson;

  @override
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String? get posterPath => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  int get id => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  String? get overview => throw _privateConstructorUsedError;
  @override
  @HiveField(4)
  bool get isFavored => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  String? get photoAsString => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MovieCopyWith<_Movie> get copyWith => throw _privateConstructorUsedError;
}
