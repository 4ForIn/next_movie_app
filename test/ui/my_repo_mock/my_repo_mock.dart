import 'dart:async';

import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/data/repositories/app_repository/app_repository.dart';

class MyRepoMock implements AppMovieRepository {
  @override
  Future<List<Movie>> fetchMovies([String? title]) async {
    const List<Movie> dummyMovies = <Movie>[
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
}
