import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    // PROVIDER
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    // Widget que se construye a sí mismo en función de la última snapshot de interacción con un Future.
    return FutureBuilder(
      // Peticion HTTP
      future: moviesProvider.getMovieCast(movieId),
      // Builder()
      builder: (_, snapshot) {
        // Si no tiene data (Mostrar Loading)
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        // Obtener data de la peticcion HTTP
        final cast = snapshot.data!;

        return SizedBox(
          width: double.infinity,
          height: 200,
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, index) {
                return _CastCard(cast: cast[index]);
              },
            ),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;

  const _CastCard({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              width: 110,
              height: 140,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfileImg),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            cast.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
