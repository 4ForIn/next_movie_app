part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  const MovieInitial();

  @override
  List<Object?> get props => <Object?>[];
}

class MovieLoadingInProgress extends MovieState {
  const MovieLoadingInProgress();

  @override
  List<Object?> get props => <Object?>[];
}

class MovieLoaded extends MovieState {
  const MovieLoaded({required this.foundMovies, required this.popularMovies});
  final List<Movie> popularMovies;
  final List<Movie> foundMovies;

  @override
  String toString() {
    return 'MovieLoaded{popularMovies: $popularMovies, foundMovies.posterPath: $foundMovies}';
  }

  /*MovieLoaded copyWith({List<Movie> foundMovies, List<Movie> popularMovies}) {
    return MovieLoaded(
      foundMovies: foundMovies ?? this.foundMovies,
      popularMovies: popularMovies ?? this.popularMovies,
    );
  }*/

  @override
  List<Object?> get props => <List<Movie>>[foundMovies, popularMovies];
}

/// Failure handling
class MovieError extends MovieState {
  const MovieError(this.errorCode, this.errorMessage);
  final int errorCode;
  final String errorMessage;

  @override
  List<Object?> get props => <dynamic>[errorCode, errorMessage];
}

class MovieFavoriteLoaded extends MovieState {
  const MovieFavoriteLoaded(this.favoriteMovies);
  final List<Movie> favoriteMovies;

  @override
  List<Object?> get props => <List<Movie>>[favoriteMovies];
}
