import 'dart:typed_data';
import 'dart:ui';

import 'package:next_movie_app/data/providers/database/local_db_impl/local_db_impl.dart';
import 'package:next_movie_app/data/providers/movie_api_provider/movie_api_provider.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/domain/repositories/movie_repository_interface/movie_repository_interface.dart';
import 'package:next_movie_app/utils/image_as_string/image_as_string.dart';

/// Data Provider wrapper
class MovieRepositoryImpl implements MovieRepositoryInterface<Movie> {
  final MovieApiProvider _moviesApiProvider = MovieApiProvider();
  final LocalDbImpl _localDb = LocalDbImpl();

  // add data/providers/database/local_db_impl

  @override
  Future<List<Movie>> fetchMovies([String? title]) async {
    final List<Movie> _movies = <Movie>[];
    final dynamic _jsonStringFromDataProvider =
        await _moviesApiProvider.fetchRawDataFromApiAndConvertToJson(title);

    /// fetchRawDataFromApiAndConvertToJson() returns Map<String, dynamic>?, throws Exceptions
    if (_jsonStringFromDataProvider == null) {
      _movies.clear();
      return _movies;
    } else {
      final Map<String, dynamic> _tempFilmsFromResponse =
          _jsonStringFromDataProvider as Map<String, dynamic>;

      /// if response have more then one record, movie data is stored into
      /// 'results': []'
      if (_tempFilmsFromResponse['results'] != null) {
        final List<dynamic> _tempMovies =
            _tempFilmsFromResponse['results'] as List<dynamic>;
        for (int i = 0; i < _tempMovies.length; i++) {
          _addMovieToList(_movies, _tempMovies[i] as Map<String, dynamic>);
        }

        /// to check if response from API has any movie object
      } else if (_tempFilmsFromResponse['title'] != null) {
        /// if response have only one record, movie data is stored into {},
        _addMovieToList(_movies, _tempFilmsFromResponse);
      }
    }

    if (_movies.isNotEmpty && _movies[0].title == '' && _movies[0].id.isNaN) {
      _movies.clear();
    }
    return _movies;
  }

  /// converts http response body (after convert.jsonDecode) to Movie object
  /// and add each item to the List<Movie>[]
  void _addMovieToList(List<dynamic> list, Map<String, dynamic> item) {
    final Map<String, dynamic> _tempItem = item;

    if (_tempItem['id'] is! int) {
      final int _parsedId = int.tryParse(_tempItem['id'].toString()) ?? -1;
      _tempItem['id'] = _parsedId;
    }
    final Movie _tempMovieObject = Movie.fromJson(_tempItem);

    /// json has a "poster_path" but Movie model has posterPath property!
    final Movie movieObject =
        _tempMovieObject.copyWith(posterPath: item['poster_path']?.toString());

    list.add(movieObject);
  }

  @override
  Future<void> addToFavorite(Movie object) async {
    Movie _movie = object;
    final String? _path = _movie.posterPath;

    if (_path != null) {
      // saving poster as a String in database
      final Uint8List? _imageAsString =
          await _moviesApiProvider.getImageUint8ListData(_path);
      if (_imageAsString != null) {
        final String _data = ImageAsString.base64String(_imageAsString);
        _movie = _movie.copyWith(photoAsString: _data);
      }
    }
    _localDb.add(_movie);
  }

  @override
  Future<void> removeFromFavorite(Movie object) async {
    _localDb.delete(object);
  }

  @override
  Future<List<Movie>> getAllFromDb() async {
    return _localDb.getMovies();
  }

  @override
  Future<Image?> getImgFromString(int movieId) async {
    final String? _base64Str = await _localDb.getImgStr(movieId);

    if (_base64Str != null && _base64Str.length > 4) {
      try {
        final Image? _img = ImageAsString.fromBase64Str(_base64Str) as Image?;
        return _img;
      } catch (e) {
        print('Error when parsing String to Image: \n ${e.toString()}');
      }
    } else {
      print('Error when parsing String to Image - getImgFromString() -');
      return null;
    }
  }
}
