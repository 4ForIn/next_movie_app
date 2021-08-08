import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/data/repositories/app_repository/app_repository.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this._movieRepository) : super(const MovieInitial());
  final AppMovieRepository _movieRepository;

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
      yield* _mapLoadingPopularToState();
    } else if (event is MovieSearchEvent) {
      yield* _mapMovieSearchToState(event);
    } else if (event is MovieFavoriteTriggeredEvent) {
      yield* _mapFavoriteTriggerToState(event, state as MovieLoaded);
      // have to watch if the state MovieLoaded up here is not problematic!
    } else if (event is MovieLoadFavoriteEvent) {
      final MovieLoaded state1 = state as MovieLoaded;
      yield MovieLoaded(
          favoriteMovies: state1.favoriteMovies,
          foundMovies: state1.foundMovies,
          popularMovies: state1.popularMovies);
    } else {
      yield const MovieError(-1, AppStrings.somethingWrong);
    }
  }

  Stream<MovieState> _mapLoadingPopularToState() async* {
    {
      yield const MovieLoadingInProgress();
      try {
        List<Movie> _prevFoundMovies = <Movie>[];
        List<Movie> _prevFavoriteMovies = <Movie>[];
        if (_prevState.whereType<MovieLoaded>().isNotEmpty) {
          _prevFoundMovies =
              _prevState.whereType<MovieLoaded>().last.foundMovies;
          _prevFavoriteMovies =
              _prevState.whereType<MovieLoaded>().last.favoriteMovies;
        }

        yield MovieLoaded(
            favoriteMovies: _prevFavoriteMovies,
            popularMovies: await _getMovies(),
            foundMovies: _prevFoundMovies);
      } on Exception {
        yield const MovieError(-1, AppStrings.movieLoadedError);
      }
    }
  }

  Stream<MovieState> _mapMovieSearchToState(MovieSearchEvent event) async* {
    yield const MovieLoadingInProgress();

    try {
      List<Movie> _prevPopularMovies = <Movie>[];
      List<Movie> _prevFavoriteMovies = <Movie>[];
      // pre1 = _prevState.whereType<MovieLoaded>().isNotEmpty

      if (_prevState.whereType<MovieLoaded>().isNotEmpty) {
        _prevPopularMovies =
            _prevState.whereType<MovieLoaded>().last.popularMovies;
        _prevFavoriteMovies =
            _prevState.whereType<MovieLoaded>().last.favoriteMovies;
      }

      yield MovieLoaded(
          favoriteMovies: _prevFavoriteMovies,
          popularMovies: _prevPopularMovies,
          foundMovies: await _searchMovie(event.input!));
    } on Exception {
      yield const MovieError(-1, AppStrings.movieLoadedError);
    }

    /*try {
      final List<Movie> _found = await _searchMovie(event.input!);

      yield state.copyWith(foundMovies: _found);
    } on Exception {
      yield const MovieError(-1, AppStrings.movieLoadedError);
    }*/
  }

  /// TO REFACTORING

  Stream<MovieState> _mapFavoriteTriggerToState(
      MovieFavoriteTriggeredEvent event, MovieLoaded state) async* {
    // have to watch if the state MovieLoaded up here is not problematic!
    final int idFromEvent = event.movie.id;
    final List<Movie> _tempFavoriteList = state.favoriteMovies;
    List<Movie> _tempFoundMovies = state.foundMovies;
    List<Movie> _tempPopularMovies = state.popularMovies;

    // checking if movie is on the favorite list
    final List<int> favoriteIds = state.favoriteMovies
        .take(state.favoriteMovies.length)
        .map((Movie e) => e.id)
        .toList();

    if (isMovieIdOnTheList(favoriteIds, idFromEvent)) {
      /// the movie already is on the favorite movies list

      // remove the movie from the favorite movies list
      final List<Movie> _updatedFavorite = _tempFavoriteList
          .where((Movie movie) => movie.id != idFromEvent)
          .toList();

      // check if there is any movie with the id in foundMovies, popularMovies
      // check foundMovies
      final List<int> _foundMoviesIds = state.foundMovies
          .take(state.foundMovies.length)
          .map((Movie e) => e.id)
          .toList();

      if (isMovieIdOnTheList(_foundMoviesIds, idFromEvent)) {
        // set isFavored field to false:
        _tempFoundMovies = _tempFoundMovies
            .take(_tempFoundMovies.length)
            .map((Movie i) =>
                i.id == idFromEvent ? i.copyWith(isFavored: false) : i)
            .toList();
      }
      // check popularMovies
      // checking if movie is on the popularMovies list
      final List<int> _popularMoviesIds = state.popularMovies
          .take(state.popularMovies.length)
          .map((Movie e) => e.id)
          .toList();

      if (isMovieIdOnTheList(_popularMoviesIds, idFromEvent)) {
        // set isFavored field to false:
        _tempPopularMovies = _tempPopularMovies
            .take(_tempPopularMovies.length)
            .map((Movie i) =>
                i.id == idFromEvent ? i.copyWith(isFavored: false) : i)
            .toList();
      }

      // emitting updated state:
      yield MovieLoaded(
          favoriteMovies: _updatedFavorite,
          foundMovies: _tempFoundMovies,
          popularMovies: _tempPopularMovies);
    } else {
      /// movie is not marked as favorite, so we will add the movie to favorites
      // change isFavorite field to true in the movie object.
      final Movie _updatedItem = event.movie.copyWith(isFavored: true);
      // add the movie to the favorite movies list
      final List<Movie> _newFavoriteList = <Movie>[
        _updatedItem,
        ..._tempFavoriteList
      ];
      // check if there is any movie with the id in foundMovies, popularMovies
      // check foundMovies
      // checking if movie is on the foundMovies list
      final List<int> _foundMoviesIds = state.foundMovies
          .take(state.foundMovies.length)
          .map((Movie e) => e.id)
          .toList();

      if (isMovieIdOnTheList(_foundMoviesIds, idFromEvent)) {
        // set isFavored field to false:
        _tempFoundMovies = _tempFoundMovies
            .take(_tempFoundMovies.length)
            .map((Movie i) =>
                i.id == idFromEvent ? i.copyWith(isFavored: true) : i)
            .toList();
      }
      // check popularMovies
      // checking if movie is on the popularMovies list
      final List<int> _popularMoviesIds = state.popularMovies
          .take(state.popularMovies.length)
          .map((Movie e) => e.id)
          .toList();

      if (isMovieIdOnTheList(_popularMoviesIds, idFromEvent)) {
        // set isFavored field to false:
        _tempPopularMovies = _tempPopularMovies
            .take(_tempPopularMovies.length)
            .map((Movie i) =>
                i.id == idFromEvent ? i.copyWith(isFavored: true) : i)
            .toList();
      }

      // emitting updated state:
      yield MovieLoaded(
          favoriteMovies: _newFavoriteList,
          foundMovies: _tempFoundMovies,
          popularMovies: _tempPopularMovies);
    }
  }

  Future<List<Movie>> _getMovies() async {
    final List<Movie> data = await _movieRepository.fetchMovies();
    return data;
  }

  Future<List<Movie>> _searchMovie(String title) async {
    final List<Movie> data = await _movieRepository.fetchMovies(title);
    return data;
  }

  bool isMovieIdOnTheList(List<int> moviesIdsList, int movieId) {
    bool fav = false;
    if (moviesIdsList.contains(movieId)) fav = true;
    return fav;
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

--------

 */
