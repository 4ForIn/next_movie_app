import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/domain/repositories/movie_repository_interface/movie_repository_interface.dart';
import 'package:next_movie_app/utils/dummy_data/dummy_movies_list.dart';

import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  MovieRepositoryInterface
], customMocks: [
  MockSpec<MovieRepositoryInterface<List<MovieState>>>(
      as: #MovieRepositoryInterfaceRelaxed, returnNullOnMissingStub: true)
])
void main() {
  late MovieRepositoryInterface<Movie> mockRepo;
  late MovieBloc bloc;

  group('MovieBloc', () {
    setUp(() {
      EquatableConfig.stringify = true;
      mockRepo =
          MockMovieRepositoryInterface() as MovieRepositoryInterface<Movie>;
      bloc = MovieBloc(mockRepo);
    });

    // const List<Movie> emptyMovieList = <Movie>[];
    final List<Movie> movies = dummyMovies;

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoadingInProgress, MovieLoaded] when MovieLoadPopularEvent is emitted',
      build: () {
        when(mockRepo.fetchMovies()).thenAnswer((_) async => movies);
        return bloc;
      },
      act: (MovieBloc bloc) => bloc.add(const MovieLoadPopularEvent()),
      expect: () => [isA<MovieLoadingInProgress>(), isA<MovieLoaded>()],
    );
    blocTest(
      'emits [MovieLoadingInProgress, MovieLoaded] when MovieSearchEvent',
      build: () {
        when(mockRepo.fetchMovies('h')).thenAnswer((_) async => movies);
        return bloc;
      },
      act: (MovieBloc bloc) => bloc.add(const MovieSearchEvent('h')),
      expect: () => <TypeMatcher<MovieState>>[
        isA<MovieLoadingInProgress>(),
        isA<MovieLoaded>()
      ],
    );

    tearDown(() {
      bloc.close();
    });
  });
}

/*class FakeMovieRepository extends Fake implements AppMovieRepository {
  @override
  Future<List<Movie>> fetchMovies([String? title]) async {
    await Future<Function>.delayed(const Duration(seconds: 1));
    return <Movie>[
      const Movie(
          title: 'movies1.isEmpty',
          posterPath: '/rEm96ib0sPiZBADNKBHKBv5bve9.jpg',
          id: -1,
          overview:
              'An elite Navy SEAL uncovers an international conspiracy while seeking justice for'),
    ];
  }
}*/
