import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc.dart';
import 'package:next_movie_app/ui/widgets/bottom_nav/bottom_nav.dart';
import 'package:next_movie_app/ui/widgets/movies_list_view/movies_list_view.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(children: <Widget>[
        const SizedBox(height: 8),
        Center(
          child: SizedBox(
            width: 300,
            height: 60,
            child: buildShowPopularBtn(context),
          ),
        ),
        // const CircularProgressIndicator(),
        const SizedBox(height: 8),
        buildPopularMoviesListView(),
      ]),
      bottomNavigationBar: const BottomNav(),
    );
  }

  /// build methods:
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: MaterialButton(
        onPressed: () {
          /* */
          Navigator.pushNamed(context, RouterStrings.searchRoute);
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: const Text('BLoC Demo'),
    );
  }

  MaterialButton buildShowPopularBtn(BuildContext context) {
    return MaterialButton(
      color: Colors.grey,
      onPressed: () => BlocProvider.of<MovieBloc>(context)
          .add(const MovieLoadPopularEvent()),
      child: BlocBuilder<MovieBloc, MovieState>(
          builder: (BuildContext context, MovieState state) {
        if (state is MovieLoadingInProgress) {
          return const CircularProgressIndicator(
            color: Colors.green,
          );
        } else {
          return const Text('Show popular movies');
        }
      }),
    );
  }

  BlocBuilder<MovieBloc, MovieState> buildPopularMoviesListView() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (BuildContext context, MovieState state) {
        if (state is MovieInitial) {
          return const Text('You will see popular movies below');
        } else if (state is MovieLoaded && state.popularMovies.isNotEmpty) {
          return MoviesListView(movieItems: state.popularMovies);
        } else {
          return const Text('no popular films');
        }
      },
    );
  }
}

/*

 */
