import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:next_movie_app/domain/entities/movie/movie.dart';
import 'package:next_movie_app/ui/animations/favorite_icon_animation/favorite_icon_animation.dart';
import 'package:next_movie_app/utils/constants/app_strings/app_strings.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {Key? key, required this.item, required this.triggerIsFavorite})
      : super(key: key);
  final Movie item;
  final Function(Movie m) triggerIsFavorite;

  static const String _baseUrl = AppStrings.movieDbPosterBaseUrl;
  @override
  Widget build(BuildContext context) {
    final bool favorite = item.isFavored;
    return ExpansionTile(
      collapsedTextColor:
          Theme.of(context).textTheme.bodyText1?.color ?? Colors.green,
      textColor: Theme.of(context).textTheme.bodyText1?.color ?? Colors.green,
      leading: FavoriteIconAnim(
        icon: favorite
            ? Icon(
                Icons.star,
                color: Colors.red.shade300,
              )
            : Icon(
                Icons.star_border,
                color: Theme.of(context).accentColor,
              ),
        key: Key(item.id.toString()),
        isItemFavorite: favorite,
        handleIsFavState: () => triggerIsFavorite(item),
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
                      ? CachedNetworkImage(
                          imageUrl: '$_baseUrl${item.posterPath}',
                          placeholder: (_, __) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (_, __, dynamic error) =>
                              const Icon(Icons.error),
                          fadeInDuration: const Duration(milliseconds: 400),
                          fadeOutDuration: const Duration(milliseconds: 600),
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
                        style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1?.color ??
                              const Color(0xFFF0810F),
                        ),
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
            style: Theme.of(context).textTheme.bodyText2,
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
