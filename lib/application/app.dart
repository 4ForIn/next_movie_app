import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:next_movie_app/config/themes/app_themes.dart';
import 'package:next_movie_app/data/repositories/movie_repository_impl/movie_repository_impl.dart';
import 'package:next_movie_app/ui/screens/favorite/favorite.dart';
import 'package:next_movie_app/ui/screens/home/home.dart';
import 'package:next_movie_app/ui/screens/search/search.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final MovieBloc _movieBloc = MovieBloc(MovieRepositoryImpl());

  final ThemeCubit _themeCubit = ThemeCubit();

  @override
  void dispose() {
    Hive.box('favoriteMovies').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// wrapping MaterialApp with BlocProvider provides a global access
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<MovieBloc>(
          create: (BuildContext context) => _movieBloc,
        ),
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => _themeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          state as ThemeModeState;
          return MaterialApp(
            title: 'BLoC Demo',
            theme: AppThemes.appThemeData[state.mode],
            routes: <String, WidgetBuilder>{
              RouterStrings.homeRoute: (BuildContext context) => const Home(),
              RouterStrings.searchRoute: (BuildContext context) =>
                  const SearchScreen(),
              RouterStrings.favoriteRoute: (BuildContext context) =>
                  const FavoriteScreen(), //const <Movie>[],
            },
          );
        },
      ),
    );
  }
}
