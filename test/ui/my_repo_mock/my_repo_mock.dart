import 'dart:async';
import 'dart:ui';

import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/domain/repositories/movie_repository_interface/movie_repository_interface.dart';

class MyRepoMock implements MovieRepositoryInterface {
  @override
  Future<List<Movie>> fetchMovies([String? title]) async {
    final List<Movie> dummyMovies = <Movie>[
      Movie(
          title: 'Title 1',
          posterPath: '',
          id: -3,
          overview:
              'An elite Navy SEAL uncovers an international conspiracy while seeking justice for'),
      Movie(
          title: 'Title 2',
          posterPath: '',
          id: -2,
          overview: 'Victoria is a young mother trying to put her dark past'),
    ];

    final Completer<List<Movie>> completer = Completer<List<Movie>>();
    completer.complete(dummyMovies);
    return completer.future;
  }

  @override
  Future<void> addToFavorite(object) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromFavorite(object) {
    // TODO: implement removeFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<List> getAllFromDb() {
    // TODO: implement getAllFromDb
    throw UnimplementedError();
  }

  @override
  Future<Image?> getImgFromString(int movieId) {
    // TODO: implement getImgFromString
    throw UnimplementedError();
  }
}
