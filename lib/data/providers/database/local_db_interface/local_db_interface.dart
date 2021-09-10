import 'package:next_movie_app/domain/entities/movie/movie.dart';

/// This is a local data source interface
abstract class LocalDbInterface {
  Future<Movie?> getMovie(int id);
  Future<List<Movie>> getMovies();
  Future<void> delete(Movie movie);
  Future<void> add(Movie movie);
  // Image was stored as a String (Uint8List)
  Future<String?> getImgStr(int movieId);
}

/*
abstract class DatabaseInterface<T> {
  Future<List<T>> getAllItems();
  Future<void> addItem(T object);
  Future<void> deleteItem(T object);
}
 */
