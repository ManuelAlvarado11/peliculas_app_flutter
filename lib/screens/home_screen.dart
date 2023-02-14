import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cine'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Libreria CardSwiper
            CardSwipper(movies: moviesProvider.onDisplayMovies),

            // ListView Horizontal
            MovieSlider(
              movies: moviesProvider.onPopularMovies,
              title: 'Populares!',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
