import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:next_movie_app/config/themes/app_themes.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/bottom_nav/bottom_nav.dart';
import 'package:next_movie_app/ui/widgets/movies_list_view/movies_list_view.dart';
import 'package:next_movie_app/utils/constants/enums/enums.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeCubit _themeCubit = BlocProvider.of<ThemeCubit>(context);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildSliverAppBar(context, _themeCubit),
          ];
        },
        body: Column(children: <Widget>[
          const SizedBox(height: 8),
          _buildShowPopularBtn(context),
          const SizedBox(height: 8),
          _buildPopularMoviesListView(),
        ]),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  /// build methods:

  SliverAppBar _buildSliverAppBar(
      BuildContext context, ThemeCubit _themeCubit) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 8.0,
      expandedHeight: 65.0,
      floating: true,
      forceElevated: true,
      //forceElevated: innerBoxIsScrolled,
      shadowColor: Theme.of(context).secondaryHeaderColor,
      stretch: true,
      title: _buildAppBarTitle(context),

      actions: <Widget>[
        _buildAppBarActions(_themeCubit),
        // Icon(Icons.more_vert),
      ],
    );
  }

  Text _buildAppBarTitle(BuildContext context) {
    return Text(
      'BLoC Demo',
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

  Center _buildShowPopularBtn(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 1 / 12,
        width: MediaQuery.of(context).size.width * 3 / 5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).accentColor,
                Theme.of(context).buttonColor,
              ]),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: _buildTextButton(context),
      ),
    );
  }

  TextButton _buildTextButton(BuildContext context) {
    return TextButton(
        onPressed: () => BlocProvider.of<MovieBloc>(context)
            .add(const MovieLoadPopularEvent()),
        child: BlocBuilder<MovieBloc, MovieState>(
            builder: (BuildContext context, MovieState state) {
          if (state is MovieLoadingInProgress) {
            return const CircularProgressIndicator(
              color: AppThemes.darkPrimaryColor,
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _textButtonsText(context),
                _textButtonsIcon(context),
              ],
            );
          }
        }));
  }

  Text _textButtonsText(BuildContext context) {
    return Text(
      'Popular movies',
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 1 / 37, // 20.0
          fontWeight: FontWeight.w600,
          color: Colors.white),
    );
  }

  Container _textButtonsIcon(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          Icons.arrow_right_alt_outlined,
          size: 25,
          color: Theme.of(context).accentColor,
        ));
  }

  BlocBuilder<MovieBloc, MovieState> _buildPopularMoviesListView() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (BuildContext context, MovieState state) {
        if (state is MovieInitial) {
          return const Text(
            'You will see popular movies below',
          );
        } else if (state is MovieLoaded && state.popularMovies.isNotEmpty) {
          return MoviesListView(
              movieItems: state.popularMovies,
              fn: (Movie m) {
                context
                    .read<MovieBloc>()
                    .add(MovieFavoriteTriggeredEvent(movie: m));
              });
        } else {
          return const Text(
            'no popular films',
          );
        }
      },
    );
  }
}
