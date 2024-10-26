import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.4,
        pagination: SwiperPagination(
          margin: const EdgeInsetsDirectional.only(
            top: 0,
          ),
          builder: DotSwiperPaginationBuilder(
            color: colors.surfaceDim,
            activeColor: colors.primary,
          ),
        ),
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
      ],
    );
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 30),
      child: DecoratedBox(
        decoration: boxDecoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            fit: BoxFit.cover,
            movie.backdropPath,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black12));
              }
              return FadeIn(
                animate: true,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
