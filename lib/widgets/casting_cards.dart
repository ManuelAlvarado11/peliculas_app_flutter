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

        return Container(
          margin: const EdgeInsets.only(bottom: 40),
          width: double.infinity,
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (_, index) {
              return _CastCard(cast: cast[index]);
            },
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
      width: 100,
      height: 170,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(cast.fullProfileImg),
            width: 110,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          cast.name,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 2,
        )
      ]),
    );
  }
}
