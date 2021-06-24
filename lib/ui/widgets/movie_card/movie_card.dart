import 'package:flutter/material.dart';
import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.item});
  final Movie item;

  static const String _baseUrl = AppStrings.movieDbPosterBaseUrl;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: IconButton(
        icon: const Icon(Icons.star),
        color: Colors.green,
        onPressed: () {
          /*context
              .read<MovieBloc>()
              .add(FavoredTriggerEvent(item.id));*/
        },
      ),
      title: Container(
        height: 200.0,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            if (item.posterPath != null)
              Expanded(
                child: Hero(
                  tag: item.id,
                  child: item.posterPath != ''
                      ? Image.network(
                          '$_baseUrl${item.posterPath}',
                          fit: BoxFit.scaleDown,
                        )
                      : _buildNoPosterContainer(
                          backgroundColor: Colors.green, textColor: Colors.red),
                ),
              )
            else
              _buildNoPosterContainer(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        item.title,
                        maxLines: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey.shade800),
            text: item.overview,
          ),
        ),
      ],
    );
  }

  Container _buildNoPosterContainer(
      {Color backgroundColor = Colors.black, Color textColor = Colors.white}) {
    return Container(
      width: 70,
      height: 80,
      color: backgroundColor,
      child: const Center(
        child: Text(
          'No poster',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
