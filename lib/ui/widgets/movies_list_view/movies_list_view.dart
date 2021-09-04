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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
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
