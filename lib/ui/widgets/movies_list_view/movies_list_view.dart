import 'package:flutter/material.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/widgets/movie_card/movie_card.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({
    Key? key,
    required this.movieItems,
    required this.fn,
  }) : super(key: key);

  final List<Movie> movieItems;
  final Function(Movie m) fn;
  // final GlobalKey _listKey = GlobalKey();
  // final GlobalKey<AnimatedListState> _animListKey =
  //     GlobalKey<AnimatedListState>();

  /*
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /* function to fire only after build method - then there is a current state!*/ /*
      _animListKey.currentState!.insertItem();
   */
    });
  }
   */

  @override
  Widget build(BuildContext context) {
    //  _animListKey.currentState!.insertItem(); // index of the inserted item
    // Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));

    return Expanded(
      child: ListView.builder(
        //key: _listKey,
        shrinkWrap: true,
        padding: const EdgeInsets.all(7.0),
        itemCount: movieItems.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieCard(
            //key: GlobalKey(debugLabel: movieItems[index].title),
            item: movieItems[index],
            triggerIsFavorite: fn,
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
