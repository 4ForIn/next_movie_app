import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/data/repositories/movie_repository/movie_repository.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this._movieRepository) : super(const MovieInitial());
  final MovieRepository _movieRepository;

  final List<MovieState> _prevState = <MovieState>[];

  @override
  void onTransition(Transition<MovieEvent, MovieState> transition) {
    _prevState.add(transition.nextState);
    super.onTransition(transition);
  }

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    /// app starting
    if (event is InitialEvent) {
      yield const MovieInitial();
    } else if (event is MovieLoadPopularEvent) {
      yield const MovieLoadingInProgress();
      try {
        List<Movie> _prevFoundMovies = <Movie>[];
        if (_prevState.whereType<MovieLoaded>().isNotEmpty) {
          _prevFoundMovies =
              _prevState.whereType<MovieLoaded>().last.foundMovies;
        }

        yield MovieLoaded(
            popularMovies: await getMovies(), foundMovies: _prevFoundMovies);
      } on Exception {
        yield const MovieError(-1, AppStrings.movieLoadedError);
      }
    } else if (event is MovieSearchEvent) {
      yield const MovieLoadingInProgress();

      try {
        List<Movie> _prevPopularMovies = <Movie>[];
        // pre1 = _prevState.whereType<MovieLoaded>().isNotEmpty

        if (_prevState.whereType<MovieLoaded>().isNotEmpty) {
          _prevPopularMovies =
              _prevState.whereType<MovieLoaded>().last.popularMovies;
        }

        yield MovieLoaded(
            popularMovies: _prevPopularMovies,
            foundMovies: await searchMovie(event.input!));
      } on Exception {
        yield const MovieError(-1, AppStrings.movieLoadedError);
      }
    } else {
      yield const MovieError(-1, AppStrings.somethingWrong);
    }
  }

  Future<List<Movie>> getMovies() async {
    final List<Movie> data = await _movieRepository.fetchMovies();
    return data;
  }

  Future<List<Movie>> searchMovie(String title) async {
    final List<Movie> data = await _movieRepository.fetchMovies(title);
    return data;
  }
}

/*
events:
InitialEvent
MovieFavoriteTriggeredEvent(int)
MovieLoadEvent(MovieType)
MovieLoadingInProgressEvent
MovieSearchEvent(String?)

state:
MovieInitial()
MovieLoadingInProgress()
MovieLoaded(List<Movie>)
MovieLoadedError(String?)
MovieFavoriteLoaded(List<Movie>)
 */
