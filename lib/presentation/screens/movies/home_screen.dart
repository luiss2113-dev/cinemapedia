import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayinMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMoviesListView = ref.watch(nowPlayinMoviesProvider);
    final popularMoviesListView = ref.watch(popularMoviesProvider);
    final upcomingMoviesListView = ref.watch(upcomingMoviesProvider);
    final topRatedMoviesListView = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: MyCustomAppBar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: nowPlayingMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMoviesListView,
                  title: 'en cines',
                  subtitle: 'Lunes 20',
                  loadMore: () =>
                      ref.read(nowPlayinMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: upcomingMoviesListView,
                  title: 'Proximamente',
                  subtitle: "En Lista",
                  loadMore: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: popularMoviesListView,
                  title: 'Populares',
                  loadMore: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: topRatedMoviesListView,
                  title: 'Mejor Calificadas',
                  subtitle: 'Desde siempre',
                  loadMore: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
              ],
            );
          },
          childCount: 1,
        ),
      )
    ]);
  }
}
