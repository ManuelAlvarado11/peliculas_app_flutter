import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      // Crea efectos de desplazamiento personalizados usando astillas(slivers)
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PostAndTitle(movie: movie),
                _OverView(descripcion: movie.overview),
                _OverView(descripcion: movie.overview),
                _OverView(descripcion: movie.overview),
                const SizedBox(height: 10),
                const CastingCards()
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Widget de AppBar Personalizado
class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // Widget AppBar dinamico
    return SliverAppBar(
      backgroundColor: Colors.blue,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      // Widget que se apila detrás de la barra de herramientas
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        // Titulo del FlexibleSpace
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black45,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        // Fondo del FlexibleSpace
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackDropImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Widget de ficha informativa
class _PostAndTitle extends StatelessWidget {
  final Movie movie;
  const _PostAndTitle({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              height: 200,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_sharp,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      movie.voteAverage.toString(),
                      style: textTheme.caption,
                    )
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

// Widget de descripcion
class _OverView extends StatelessWidget {
  final String descripcion;
  const _OverView({super.key, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        descripcion,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
