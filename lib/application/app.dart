import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc.dart';
import 'package:next_movie_app/data/repositories/movie_repository/movie_repository.dart';
import 'package:next_movie_app/ui/screens/home/home.dart';
import 'package:next_movie_app/ui/screens/search/search.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class Application extends StatelessWidget {
  final MovieBloc _movieBloc = MovieBloc(MovieRepository());
  @override
  Widget build(BuildContext context) {
    /// wrapping MaterialApp with BlocProvider provides a global access
    return BlocProvider<MovieBloc>(
      create: (BuildContext context) => MovieBloc(MovieRepository()),
      child: MaterialApp(
        title: 'BLoC Demo',
        theme: ThemeData(
            primarySwatch: Colors.grey,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              foregroundColor: Colors.red,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: <String, WidgetBuilder>{
          RouterStrings.homeRoute: (BuildContext context) => const Home(),
          RouterStrings.searchRoute: (BuildContext context) =>
              const SearchScreen(),
        },
      ),
    );
  }
}
