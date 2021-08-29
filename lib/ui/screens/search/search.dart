import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/movie_card/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 8.0,
      forceElevated: true,
      shadowColor: Theme.of(context).secondaryHeaderColor,
      title: _buildAppBarTitle(context),
    );
  }

  Text _buildAppBarTitle(BuildContext context) {
    return Text(
      'Search movie',
      style: TextStyle(
        color: Theme.of(context).textTheme.headline6!.color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        semanticChildCount: 0,
        slivers: <Widget>[
          _buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  _buildSearchFieldAndBtn(context),
                  const Divider(
                    height: 5.0,
                    indent: 40.0,
                    endIndent: 40.0,
                  ),
                ]),
              )
            ]),
          ),
          BlocBuilder<MovieBloc, MovieState>(
              builder: (BuildContext context, MovieState state) {
            if (state is MovieInitial) {
              return SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  const Center(
                    child: Text(
                      'Type a title to start searching',
                    ),
                  ),
                ]),
              );
            } else if (state is MovieLoaded && state.foundMovies.isNotEmpty) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MovieCard(
                      item: state.foundMovies[index],
                      fn1: (Movie m) {
                        context
                            .read<MovieBloc>()
                            .add(MovieFavoriteTriggeredEvent(movie: m));
                      },
                    );
                  },
                  childCount: 7,
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  const Center(
                    child: Text(
                      'nothing was found',
                    ),
                  ),
                ]),
              );
            }
          }),
        ],
      ),
    );
  }

  /// build methods:

  Row _buildSearchFieldAndBtn(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (BuildContext context, MovieState state) {
              return TextField(
                autofocus: true,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color ??
                      const Color(0xFF063852),
                ),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  // hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (String input) =>
                    {context.read<MovieBloc>().add(MovieSearchEvent(input))},
                controller: _controller,
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildSearchBtn(context),
        ),
      ],
    );
  }

  void _searchHandle(BuildContext context) {
    final String v = _controller.value.text;
    const List<String> validate = <String>['', ' ', '  ', '/', "'", '"'];
    if (!validate.contains(v)) {
      context.read<MovieBloc>().add(MovieSearchEvent(_controller.value.text));
    }
  }

  Container _buildSearchBtn(BuildContext context) {
    return Container(
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
      child: TextButton(
        onPressed: () => _searchHandle(context),
        child: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
