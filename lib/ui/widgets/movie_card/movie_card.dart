import 'package:flutter/material.dart';
import 'package:next_movie_app/data/models/movie/movie.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.item, required this.fn1});
  final Movie item;
  final Function(Movie m) fn1;

  static const String _baseUrl = AppStrings.movieDbPosterBaseUrl;
  @override
  Widget build(BuildContext context) {
    final bool favorite = item.isFavored;
    return ExpansionTile(
      leading: IconButton(
        icon: favorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
        color: favorite ? Colors.red.shade300 : Colors.grey.shade700,
        onPressed: () => fn1(item),
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
