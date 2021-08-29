import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:next_movie_app/data/providers/database/local_db_interface/local_db_interface.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/utils/constants/local_db_strings/local_db_strings.dart';

/// This is a local data source implementation
class LocalDbImpl extends LocalDbInterface {
  // Hive database is setup in main.dart
  // Hive DB adapter is registered in main.dart
  // Hive.openBox<Movie>('favoriteMovies') is opened in main.dart

  static Box<Movie> favoriteBox() => Hive.box(DbStrings.hiveBoxFavoriteMovies);
  @override
  Future<void> add(Movie movie) async {
    // await movie.save(); // available if MovieModel extends HiveObject
    await favoriteBox().put(movie.id, movie);
  }

  @override
  Future<void> delete(Movie movie) async {
    await favoriteBox().delete(movie.id);
    // movie.delete(); // available if MovieModel extends HiveObject
  }

  @override
  Future<Movie?> getMovie(int id) async {
    return await favoriteBox().get(id);
  }

  @override
  Future<List<Movie>> getMovies() async {
    return await favoriteBox().values.toList().cast<Movie>();
  }
}

/*
  // image as a String
  Image iFromStr(String i) {
    return Image.memory(base64Decode(i));
  }*/
