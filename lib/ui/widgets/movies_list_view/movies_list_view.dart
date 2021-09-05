import 'package:flutter/material.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/movie_card/movie_card.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({
    Key? key,
    required this.movieItems,
    required this.fn,
  }) : super(key: key);

  final List<Movie> movieItems;
  final Function(Movie m) fn;

  @override
  _MoviesListViewState createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final Tween<Offset> _offset =
      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
  final List<Movie> _mItems = <Movie>[];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _a1();
    });
    super.initState();
  }

  Future<void> _ft = Future<void>(() {});

  void _a1() {
    widget.movieItems.forEach((Movie element) {
      _ft = _ft.then((_) {
        return Future<void>.delayed(const Duration(milliseconds: 100), () {
          _mItems.add(element);
          _key.currentState?.insertItem(
            _mItems.length - 1,
            // duration: const Duration(milliseconds: 500),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        key: _key,
        padding: const EdgeInsets.all(7.0),
        initialItemCount: _mItems.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          if (index == _mItems.length) {
            return const SizedBox(
              height: 1,
            );
          }
          return SlideTransition(
            position: animation.drive(_offset),
            child: MovieCard(
              item: widget.movieItems[index],
              triggerIsFavorite: widget.fn,
            ),
          );
        },
      ),
    );
  }
}

/*
class MoviesListView extends StatelessWidget {
  MoviesListView({
    Key? key,
    required this.movieItems,
    required this.fn,
  }) : super(key: key);

  final List<Movie> movieItems;
  final Function(Movie m) fn;
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        key: _listKey,
        shrinkWrap: true,
        padding: const EdgeInsets.all(7.0),
        itemCount: movieItems.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieCard(
            key: GlobalKey(debugLabel: movieItems[index].title),
            item: movieItems[index],
            triggerIsFavorite: fn,
          );
        },
      ),
    );
  }
}

 */
