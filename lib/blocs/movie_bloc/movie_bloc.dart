import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/domain/repositories/movie_repository_interface/movie_repository_interface.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this._movieRepository) : super(const MovieInitial());
  final MovieRepositoryInterface<Movie> _movieRepository;

  final List<MovieState> _prevState = <MovieState>[];

  MovieState _getPreviewState() {
    List<Movie> _prevFavoriteMovies = <Movie>[];
    List<Movie> _prevFoundMovies = <Movie>[];
    List<Movie> _prevPopularMovies = <Movie>[];
    if (_prevState.whereType<MovieLoaded>().isNotEmpty) {
      _prevFoundMovies = _prevState.whereType<MovieLoaded>().last.foundMovies;
      _prevPopularMovies =
          _prevState.whereType<MovieLoaded>().last.popularMovies;
      _prevFavoriteMovies =
          _prevState.whereType<MovieLoaded>().last.favoriteMovies;
    }
    return MovieLoaded(
        favoriteMovies: _prevFavoriteMovies,
        foundMovies: _prevFoundMovies,
        popularMovies: _prevPopularMovies);
  }

  @override
  void onTransition(Transition<MovieEvent, MovieState> transition) {
    _prevState.add(transition.nextState);
    super.onTransition(transition);
  }

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    final MovieLoaded _prevMovieLoaded = _getPreviewState() as MovieLoaded;

    /// app starting
    if (event is InitialEvent) {
      yield const MovieInitial();
    } else if (event is MovieLoadPopularEvent) {
      yield* _mapLoadingPopularToState(_prevMovieLoaded);
    } else if (event is MovieSearchEvent) {
      yield* _mapMovieSearchToState(event, _prevMovieLoaded);
    } else if (event is MovieFavoriteTriggeredEvent) {
      yield* _mapFavoriteTriggerToState(event, state as MovieLoaded);
      // have to watch if the state as MovieLoaded up here is not problematic!
    } else if (event is MovieLoadFavoriteEvent) {
      yield* _mapMovieLoadFavoriteToState(_prevMovieLoaded);
    }
  }

  Stream<MovieState> _mapLoadingPopularToState(MovieLoaded prevState) async* {
    {
      yield const MovieLoadingInProgress();
      try {
        yield MovieLoaded(
            favoriteMovies: prevState.favoriteMovies,
            popularMovies: await _getMovies(),
            foundMovies: prevState.foundMovies);
      } on Exception {
        yield const MovieError(-1, AppStrings.movieLoadedError);
      }
    }
  }

  Stream<MovieState> _mapMovieSearchToState(
      MovieSearchEvent event, MovieLoaded prevState) async* {
    yield const MovieLoadingInProgress();

    try {
      yield MovieLoaded(
          favoriteMovies: prevState.favoriteMovies,
          popularMovies: prevState.popularMovies,
          foundMovies: await _searchMovie(event.input!));
    } on Exception {
      yield const MovieError(-1, AppStrings.movieLoadedError);
    }
  }

  /// TO REFACTORING

  Stream<MovieState> _mapFavoriteTriggerToState(
      MovieFavoriteTriggeredEvent event, MovieLoaded state) async* {
    // have to watch if the state MovieLoaded up here is not problematic!
    final int idFromEvent = event.movie.id;
    List<Movie> _tempFoundMovies = state.foundMovies;
    List<Movie> _tempPopularMovies = state.popularMovies;
    final List<Movie> _favoriteInDb = await _movieRepository.getAllFromDb();

    try {
      // checking if movie is on the favorite list in DB
      if (isMovieIdOnTheList(_moviesIds(_favoriteInDb), idFromEvent)) {
        /// the movie already is on the favorite movies list
        // remove the movie from the favorite movies list in database
        _movieRepository.removeFromFavorite(event.movie); // hive DB

        // check if there is any movie with the id in foundMovies, popularMovies

        // check foundMovies
        if (isMovieIdOnTheList(_moviesIds(state.foundMovies), idFromEvent)) {
          // set isFavored field to false:
          _tempFoundMovies = _tempFoundMovies
              .take(_tempFoundMovies.length)
              .map((Movie i) =>
                  i.id == idFromEvent ? i.copyWith(isFavored: false) : i)
              .toList();
        }
        // check popularMovies
        if (isMovieIdOnTheList(_moviesIds(state.popularMovies), idFromEvent)) {
          // set isFavored field to false:
          _tempPopularMovies = _tempPopularMovies
              .take(_tempPopularMovies.length)
              .map((Movie i) =>
                  i.id == idFromEvent ? i.copyWith(isFavored: false) : i)
              .toList();
        }

        // emitting updated state:
        final List<Movie> _favBox = await _movieRepository.getAllFromDb();
        yield MovieLoaded(
            favoriteMovies: _favBox, //_updatedFavorite
            foundMovies: _tempFoundMovies,
            popularMovies: _tempPopularMovies);
      } else {
        /// movie is not marked as favorite, so add the movie to favorites

        // change isFavorite field to true in the movie object.
        final Movie _updatedItem = event.movie.copyWith(isFavored: true);

        // add the updated movie to the favorite movies list in database
        _movieRepository.addToFavorite(_updatedItem); // hive DB

        // check if there is any movie with the id in foundMovies and popularMovies
        // check foundMovies

        // checking if movie is on the foundMovies list
        if (isMovieIdOnTheList(_moviesIds(state.foundMovies), idFromEvent)) {
          // set isFavored field to true:
          _tempFoundMovies = _tempFoundMovies
              .take(_tempFoundMovies.length)
              .map((Movie i) =>
                  i.id == idFromEvent ? i.copyWith(isFavored: true) : i)
              .toList();
        }
        // check popularMovies

        // checking if movie is on the popularMovies list
        if (isMovieIdOnTheList(_moviesIds(state.popularMovies), idFromEvent)) {
          // set isFavored field to true:
          _tempPopularMovies = _tempPopularMovies
              .take(_tempPopularMovies.length)
              .map((Movie i) =>
                  i.id == idFromEvent ? i.copyWith(isFavored: true) : i)
              .toList();
        }

        // emitting updated state:
        final List<Movie> _favBox = await _movieRepository.getAllFromDb();
        yield MovieLoaded(
            favoriteMovies: _favBox, // _newFavoriteList
            foundMovies: _tempFoundMovies,
            popularMovies: _tempPopularMovies);
      }
    } on Exception {
      yield const MovieError(-1, AppStrings.somethingWrong);
    }
  }

  Stream<MovieState> _mapMovieLoadFavoriteToState(MovieLoaded state) async* {
    yield const MovieLoadingInProgress();
    try {
      yield MovieLoaded(
          favoriteMovies: await _movieRepository.getAllFromDb(),
          foundMovies: state.foundMovies,
          popularMovies: state.popularMovies);
    } on Exception {
      yield const MovieError(-1, AppStrings.somethingWrong);
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

  List<int> _moviesIds(List<Movie> movies) {
    final List<int> _ids =
        movies.take(movies.length).map((Movie e) => e.id).toList();
    return _ids;
  }
}
