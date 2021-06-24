import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie_app/blocs/movie_bloc.dart';
import 'package:next_movie_app/ui/widgets/movies_list_view/movies_list_view.dart';
import 'package:next_movie_app/utils/constants/router_strings/router_strings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Colors.grey.shade400,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _buildSearchFieldWithBtn(context),
            const Divider(
              height: 5.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (BuildContext context, MovieState state) {
                if (state is MovieInitial) {
                  return const Text('You will see popular movies below');
                } else if (state is MovieLoaded &&
                    state.foundMovies.isNotEmpty) {
                  return MoviesListView(movieItems: state.foundMovies);
                } else {
                  return const Text('no popular films');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: MaterialButton(
        onPressed: () {
          /* */
          Navigator.pushNamed(context, RouterStrings.homeRoute);
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: const Text('Search movie'),
    );
  }

  Row _buildSearchFieldWithBtn(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (BuildContext context, MovieState state) {
              return TextField(
                // ignore: always_specify_types
                onChanged: (String input) =>
                    // ignore: always_specify_types
                    {context.read<MovieBloc>().add(MovieSearchEvent(input))},
                controller: _controller,
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: MaterialButton(
            onPressed: () => _searchHandle(context),
            color: Colors.green,
            child: const Text('Search'),
          ),
        ),
      ],
    );
  }

  void _searchHandle(BuildContext context) {
    if (_controller.value != null) {
      // ignore: avoid_print
      print('_controller.value.text: ${_controller.value.text}');
      final String v = _controller.value.text;
      final List<String> validate = <String>['', ' ', '  ', '/', "''"];
      if (!validate.contains(v)) {
        context.read<MovieBloc>().add(MovieSearchEvent(_controller.value.text));
      }
      // ignore: avoid_print
      print('v =  --$v--');
    }
  }
}
