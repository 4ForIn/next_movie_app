import 'package:next_movie_app/data/models/movie/movie.dart';

abstract class AppMovieRepository {
  Future<List<Movie>> fetchMovies([String? title]);
}
