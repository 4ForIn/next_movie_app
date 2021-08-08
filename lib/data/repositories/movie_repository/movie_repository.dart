import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/data/providers/movie_api_provider/movie_api_provider.dart';
import 'package:next_movie_app/data/repositories/app_repository/app_repository.dart';

/// Data Provider wrapper
class MovieRepository implements AppMovieRepository {
  final MovieApiProvider moviesApiProvider = MovieApiProvider();

  @override
  Future<List<Movie>> fetchMovies([String? title]) async {
    final List<Movie> _movies = <Movie>[];
    final dynamic _jsonStringFromDataProvider =
        await moviesApiProvider.fetchRawDataFromApiAndConvertToJson(title);

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
}
