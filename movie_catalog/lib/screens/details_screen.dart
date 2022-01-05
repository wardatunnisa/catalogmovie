import 'package:flutter/material.dart';
import 'package:movie_catalog/models/models.dart';
import 'package:movie_catalog/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            movieTitle: movie.title,
            backDropImage: movie.fullBackdropImg,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(
                  movieTitle: movie.title,
                  originalMovieTitle: movie.originalTitle,
                  posterImage: movie.fullPosterImg,
                  voteAverage: movie.voteAverage,
                ),
                _OverView(
                  overview: movie.overview,
                ),
                CastingCards(
                  backdropImage: movie.fullBackdropImg,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String movieTitle;
  final String? backDropImage;
  const _CustomAppBar({Key? key, required this.movieTitle, this.backDropImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 5),
          color: Colors.black12,
          child: Text(
            movieTitle,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/images/loading.gif'),
          image: NetworkImage(backDropImage!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String? posterImage;
  final String movieTitle;
  final String originalMovieTitle;
  final double voteAverage;

  const _PosterAndTitle({
    Key? key,
    this.posterImage,
    required this.movieTitle,
    required this.originalMovieTitle,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(posterImage!),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  originalMovieTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      voteAverage.toString(),
                      style: textTheme.caption,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final String overview;

  const _OverView({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: textTheme.subtitle1,
      ),
    );
  }
}
