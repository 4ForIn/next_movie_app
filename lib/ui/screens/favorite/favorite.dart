import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/movies_list_view/movies_list_view.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<MovieBloc>().add(const MovieLoadFavoriteEvent());
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: Colors.grey.shade400,
        // padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              BlocBuilder<MovieBloc, MovieState>(
                builder: (BuildContext context, MovieState state) {
                  // MovieFavoriteLoaded state1 = state as MovieFavoriteLoaded;
                  if (state is MovieInitial) {
                    return const Text('You will see popular movies below');
                  } else if (state is MovieLoaded) {
                    if (state.favoriteMovies.isEmpty) {
                      return const Text('Like same movie');
                    } else {
                      return MoviesListView(
                        movieItems: state.favoriteMovies,
                        fn: (Movie m) {
                          context
                              .read<MovieBloc>()
                              .add(MovieFavoriteTriggeredEvent(movie: m));
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Building methods
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: MaterialButton(
        onPressed: () {
          /* */
          Navigator.pushNamed(context, RouterStrings.homeRoute);
        },
        child: const Icon(Icons.home),
      ),
      title: const Text('Favorite movies'),
    );
  }
}

/*
if (state is MovieFavoriteLoaded) {
                return MoviesListView(
                  movieItems: state.favoriteMovies,
                  fn: (Movie m) {
                    context
                        .read<MovieBloc>()
                        .add(MovieFavoriteTriggeredEvent(movie: m));
                  },
                );
              } else {
                return const Expanded(child: CircularProgressIndicator());
              }

 */
