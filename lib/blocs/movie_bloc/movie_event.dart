part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

/// shows HomeScreen, but do not automatically fetch popular movies.
class InitialEvent extends MovieEvent {
  const InitialEvent();

  @override
  List<Object?> get props => <dynamic>[];
}

/// add movie to favorite list
class MovieFavoriteTriggeredEvent extends MovieEvent {
  const MovieFavoriteTriggeredEvent({required this.movie});
  final Movie movie;

  @override
  List<Object?> get props => <dynamic>[movie];
}

class MovieLoadPopularEvent extends MovieEvent {
  const MovieLoadPopularEvent();

  @override
  List<Object?> get props => <dynamic>[];
}

class MovieLoadFavoriteEvent extends MovieEvent {
  const MovieLoadFavoriteEvent();

  @override
  List<Object?> get props => <dynamic>[];
}

/// search movies by title
class MovieSearchEvent extends MovieEvent {
  const MovieSearchEvent([this.input]);
  final String? input;

  @override
  List<Object?> get props => <String?>[input];
}

/// Failure handling
class MovieFailureEvent extends MovieEvent {
  const MovieFailureEvent(
      [this.code = -1, this.message = 'something went wrong']);
  final int code;
  final String message;

  @override
  List<Object?> get props => <dynamic>[code, message];
}
