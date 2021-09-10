import 'dart:ui';

abstract class MovieRepositoryInterface<T> {
  Future<List<T>> fetchMovies([String? title]);
  Future<void> addToFavorite(T object);
  Future<void> removeFromFavorite(T object);
  Future<List<T>> getAllFromDb();
  Future<Image?> getImgFromString(int movieId);
}
