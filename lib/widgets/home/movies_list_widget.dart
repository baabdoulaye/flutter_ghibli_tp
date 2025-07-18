import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ghibli/models/movie.dart';
import 'package:ghibli/services/movies_api_service.dart';
import 'package:go_router/go_router.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      débogage :
        print : déboguer des données simples
        inspect : déboguer des données complexes (Map et List)
    */
    // inspect(MoviesApiService().getMovies());

    return Column(
      children: [
        Text('Movies', style: Theme.of(context).textTheme.titleMedium),
        /*
			pour accéder aux données d'une future, il est obligatoire d'utiliser le widget FutureBuilder
		*/
        FutureBuilder(
          future: MoviesApiService().getMovies(),
          builder: (context, snapshot) {
            // snapshot contient les données de la future
            // si les données sont disponibles
            if (snapshot.hasData) {
              // récupérer les données de la future
              List<Movie> movies = snapshot.requireData;

              // afficher une liste défilante
              return ListView.builder(
                // la hauteur de la liste s'adapte à son contenu
                shrinkWrap: true,

                // nombre d'éléments de la liste à créer
                itemCount: movies.length,

                // éviter le conflit de défilement vertical entre l'application et la liste
                physics: NeverScrollableScrollPhysics(),

                // créer chaque élément de la liste
                itemBuilder: (context, index) {
                  /*
						? : exécuter la partie de droite si la partie de gauche n'est pas nulle
						! : indiquer que la valeur n'est pas nulle
					*/
                  return ListTile(
                    leading: Image.network(
                      movies[index].movie_banner!,
                      width: 80,
                    ),
                    title: Text(movies[index].title!),
                    subtitle: Text(movies[index].original_title!),
                    trailing: Icon(Icons.chevron_right),

                    // événement onTap : appui
                    /*
                      utiliser le contexte pour naviguer
                        push : ajouter un écran au-dessus de l'écran affiché, en se basant sur le schéma de la route
                        pushNamed : ajouter un écran au-dessus de l'écran affiché, en se basant sur la nom de la route
                    */
                    onTap: () => context.push('/movie/${movies[index].id}'),
                  );
                },
              );
            }

            // si les données ne sont pas disponibles
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
