import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyMovies();
    }

    // PROVIDER
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getSearchMovies(query),
      builder: (_, snapshot) {
        // NO HAY COINCIDENCIAS
        if (!snapshot.hasData) const _EmptyMovies();
        // HAY COINCDENCIAS
        final movies = snapshot.data ?? [];
        return ListView.separated(
          itemCount: movies.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (_, index) {
            return _SuggestionItem(movies[index]);
          },
        );
      },
    );
  }
}

// Widget de Coincidencia
class _SuggestionItem extends StatelessWidget {
  final Movie movie;

  const _SuggestionItem(this.movie);

  @override
  Widget build(BuildContext context) {
    // Asignacion de Hero ID (Unico) para animacion
    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.fullPosterImg),
          placeholder: const AssetImage('assets/no-image.jpg'),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}

// Widget No hay Coincidencias
class _EmptyMovies extends StatelessWidget {
  const _EmptyMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 130,
      ),
    );
  }
}
