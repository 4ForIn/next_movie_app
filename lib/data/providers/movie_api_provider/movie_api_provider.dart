import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class MovieApiProvider {
  final Client _http = Client();
  final String? _apiKey = dotenv.env['THEMOVIE_KEY'];
  final String _pathPopular =
      'https://api.themoviedb.org/3/movie/popular?api_key=';
  final String _path = 'https://api.themoviedb.org/3/search/movie?api_key=';

  /// if query is null fetching popular movies
  Future<Map<String, dynamic>?> fetchRawDataFromApiAndConvertToJson(
      [String? query]) async {
    late Uri _urlString;
    if (query == null) {
      /// fetching popular movies
      _urlString = Uri.parse('$_pathPopular$_apiKey');
    } else {
      _urlString = Uri.parse('$_path$_apiKey&query=$query');
    }
    // ignore: avoid_print
    print('start fetching movies');
    Map<String, dynamic>? convertedDataFromApi;

    try {
      final dynamic _jsonDecoded = await _http
              .get(_urlString)
              .then((Response res) => convert.jsonDecode(res.body))
          as Map<String, dynamic>;
      if (_jsonDecoded != null) {
        /// searching movies
        convertedDataFromApi = _jsonDecoded as Map<String, dynamic>;
      }
    } on HttpException {
      // ignore: avoid_print
      print('HttpException in class MovieApiProvider -> fetchMovies()');
      rethrow;
      //throw FailureHandling(message: 'bad connection');
    } on SocketException {
      // ignore: avoid_print
      print('SocketException in class MovieApiProvider -> fetchMovies()');
      rethrow;
      //throw FailureHandling(message: "Couldn't find the movie 😱");
    } on FormatException {
      // ignore: avoid_print
      print('FormatException in class MovieApiProvider -> fetchMovies()');
      rethrow;
      //throw FailureHandling(message: 'Bad response format 👎');
    }
    return convertedDataFromApi;
    // if response have more then one record, movie data is stored into
    // 'results': []'
    // if response have only one record, movie data is stored into {},
  }
}
