import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/movie_card/movie_card.dart';
import 'package:next_movie_app/utils/constants/enums/enums.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeCubit _themeCubit = BlocProvider.of<ThemeCubit>(context);
    final MovieBloc _mBloc = BlocProvider.of<MovieBloc>(context);
    _mBloc.add(const MovieLoadFavoriteEvent());
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context, _themeCubit),
          _buildBody(),
        ],
      ),
    );
  }

  /// Build methods:

  SliverAppBar _buildSliverAppBar(
      BuildContext context, ThemeCubit _themeCubit) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 8.0,
      forceElevated: true,
      shadowColor: Theme.of(context).secondaryHeaderColor,
      title: _buildAppBarTitle(context),
      actions: <Widget>[
        _buildAppBarActions(_themeCubit),
        // Icon(Icons.more_vert),
      ],
    );
  }

  Text _buildAppBarTitle(BuildContext context) {
    return Text(
      'Favorite movies',
      style: TextStyle(
        color: Theme.of(context).textTheme.headline6!.color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  BlocBuilder<ThemeCubit, ThemeState> _buildAppBarActions(
      ThemeCubit _themeCubit) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        state as ThemeModeState;
        return IconButton(
          color: Theme.of(context).bottomAppBarColor,
          onPressed: () => _themeCubit.switchTheme(),
          // icon: const Icon(Icons.more_vert),
          icon: state.mode == AppTheme.lightMode
              ? const Icon(Icons.nightlight_round)
              : const Icon(Icons.wb_sunny_outlined),
        );
      },
    );
  }

  BlocBuilder<MovieBloc, MovieState> _buildBody() {
    return BlocBuilder<MovieBloc, MovieState>(
        builder: (BuildContext context, MovieState state) {
      if (state is MovieInitial) {
        return SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            const Center(
              child: Text(
                'You will see popular movies below',
              ),
            ),
          ]),
        );
      } else if (state is MovieLoaded) {
        if (state.favoriteMovies.isEmpty) {
          return SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 1 / 4,
                ),
                child: const Center(
                  child: Text(
                    'Like same movie',
                  ),
                ),
              ),
            ]),
          );
        } else {
          final List<Movie> _favorites = state.favoriteMovies;
          return SliverList(
            delegate:
                SliverChildListDelegate(_buildMovieCards(_favorites, context)),
          );
        }
      } else {
        return SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Center(
              child: Column(
                children: const <Widget>[
                  Text('Ups please try again from beginning'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ]),
        );
      }
    });
  }

  List<Widget> _buildMovieCards(List<Movie> items, BuildContext context) {
    final List<Widget> _movieView = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      _movieView.add(MovieCard(
        item: items[i],
        triggerIsFavorite: (Movie m) {
          context.read<MovieBloc>().add(MovieFavoriteTriggeredEvent(movie: m));
        },
      ));
    }
    return _movieView;
  }
}
