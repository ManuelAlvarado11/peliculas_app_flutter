import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea efectos de desplazamiento personalizados usando astillas(slivers)
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _PostAndTitle(),
                const _OverView(),
                const _OverView(),
                const _OverView(),
                const _OverView(),
                const _OverView(),
                const _OverView(),
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
  const _CustomAppBar({super.key});

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
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black45,
          child: const Text(
            'movie.name',
            style: TextStyle(fontSize: 20),
          ),
        ),
        // Fondo del FlexibleSpace
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Widget de ficha informativa
class _PostAndTitle extends StatelessWidget {
  const _PostAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const FadeInImage(
              height: 200,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'original.title',
                style: textTheme.subtitle1,
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
                    'movie.puntaje',
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

// Widget de descripcion
class _OverView extends StatelessWidget {
  const _OverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Adipisicing sit dolore ullamco consectetur fugiat et sint amet irure irure aute nulla. Duis culpa ipsum deserunt ex. Et id minim aute commodo deserunt eu duis qui sunt id ullamco.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
