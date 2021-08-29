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
  const MovieLoaded(
      {required this.favoriteMovies,
      required this.foundMovies,
      required this.popularMovies});

  final List<Movie> favoriteMovies;
  final List<Movie> popularMovies;
  final List<Movie> foundMovies;

  @override
  String toString() {
    return 'MovieLoaded{popularMovies: $popularMovies, foundMovies.posterPath: $foundMovies}';
  }

  MovieLoaded copyWith(
      {List<Movie>? favoriteMovies,
      List<Movie>? foundMovies,
      List<Movie>? popularMovies}) {
    return MovieLoaded(
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      foundMovies: foundMovies ?? this.foundMovies,
      popularMovies: popularMovies ?? this.popularMovies,
    );
  }

  @override
  List<Object?> get props =>
      <List<Movie>>[favoriteMovies, foundMovies, popularMovies];
}

/// Failure handling
class MovieError extends MovieState {
  const MovieError(this.errorCode, this.errorMessage);
  final int errorCode;
  final String errorMessage;

  @override
  List<Object?> get props => <dynamic>[errorCode, errorMessage];
}
