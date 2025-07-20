// lib/widgets/movie/movie_widget.dart
import 'package:flutter/material.dart';
import 'package:ghibli/models/movie.dart';
import 'package:ghibli/services/movies_api_service.dart';
// Importe l'extension pour les étoiles
import 'package:flutter_rating_stars/flutter_rating_stars.dart'; // <-- Nouvelle importation

class MovieWidget extends StatefulWidget {
  final String? id; // L'ID du film est requis pour récupérer les détails

  const MovieWidget({super.key, required this.id});

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  // Instance du service API pour récupérer les données
  final MoviesApiService _moviesApiService = MoviesApiService();

  // Future qui contiendra les données du film
  late Future<Movie> _movieFuture;

  @override
  void initState() {
    super.initState();
    // Vérifie si l'ID est valide avant de lancer la requête
    if (widget.id != null) {
      _movieFuture = _moviesApiService.getMovieById(widget.id!);
    } else {
      // Si l'ID est nul, on peut retourner une erreur ou un Future.error
      _movieFuture = Future.error('Movie ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
      future: _movieFuture,
      builder: (context, snapshot) {
        // Si les données sont en cours de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Si une erreur s'est produite
        else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }
        // Si les données sont disponibles
        else if (snapshot.hasData) {
          final Movie movie = snapshot.data!; // Récupère l'objet Movie

          // Convertir rt_score en double pour le widget RatingStars
          // Le rt_score est une chaîne de caractères (ex: "80").
          // On le divise par 100 pour obtenir une valeur entre 0 et 1, puis on multiplie par le nombre d'étoiles max (ici 5).
          // Gérer le cas où rt_score est null ou non numérique.
          double starRating = 0.0;
          if (movie.rt_score != null) {
            try {
              starRating =
                  (double.parse(movie.rt_score!) / 100) *
                  5; // Convertit "80" en 0.8, puis 0.8 * 5 = 4.0 étoiles
            } catch (e) {
              // Gérer l'erreur de conversion si rt_score n'est pas un nombre
              print('Erreur de conversion de rt_score: ${movie.rt_score}, $e');
              starRating = 0.0; // Valeur par défaut en cas d'erreur
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre du film en haut
                Text(
                  movie.title ??
                      'Titre inconnu', // Utilise ?? pour gérer les valeurs nulles
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  movie.original_title ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  movie.original_title_romanised ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),

                // Mise en page en deux colonnes : Image à gauche, Informations à droite
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Colonne de gauche : Image du film
                    Expanded(
                      flex: 1, // Prend 1 part sur 3 de l'espace
                      child: movie.image != null && movie.image!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ), // Coins arrondis
                              child: Image.network(
                                movie.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    // Placeholder en cas d'erreur de chargement
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Text('Image non disponible'),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              // Placeholder si l'URL de l'image est nulle ou vide
                              height: 200,
                              color: Colors.grey[300],
                              child: const Center(child: Text('Pas d\'image')),
                            ),
                    ),
                    const SizedBox(width: 20), // Espace entre les colonnes
                    // Colonne de droite : Informations détaillées
                    Expanded(
                      flex: 2, // Prend 2 parts sur 3 de l'espace
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('Réalisateur', movie.director),
                          _buildInfoRow('Producteur', movie.producer),
                          _buildInfoRow('Date de sortie', movie.release_date),
                          _buildInfoRow('Durée', '${movie.running_time} min'),

                          const SizedBox(height: 10), // Espacement
                          // Affichage de la note avec les étoiles
                          Row(
                            children: [
                              const Text(
                                'Note (RT Score) : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // Widget RatingStars pour afficher les étoiles
                              RatingStars(
                                value:
                                    starRating, // La valeur calculée des étoiles
                                starBuilder: (index, color) =>
                                    Icon(Icons.star, color: color),
                                starCount:
                                    5, // Nombre total d'étoiles (par exemple, sur 5)
                                starSize: 20, // Taille des étoiles
                                valueLabelColor: const Color(0xff9b9b9b),
                                valueLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0,
                                ),
                                valueLabelRadius: 10,
                                maxValue: 5, // La valeur maximale des étoiles
                                starSpacing: 2,
                                maxValueVisibility: true,
                                valueLabelVisibility: true,
                                animationDuration: const Duration(
                                  milliseconds: 1000,
                                ),
                                // Personnalisation des couleurs des étoiles
                                starColor: Colors
                                    .amber, // Couleur des étoiles remplies
                                starOffColor: Colors
                                    .grey, // Couleur des étoiles non remplies
                              ),
                              // Afficher la valeur numérique à côté des étoiles si tu veux
                              // Text(' (${movie.rt_score ?? 'N/A'})'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Description complète sous les colonnes
                Text(
                  'Description:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.description ?? 'Pas de description disponible.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        }
        // Cas par défaut si aucune donnée n'est présente (par exemple, ID nul)
        else {
          return const Center(
            child: Text('Aucun film sélectionné ou ID manquant.'),
          );
        }
      },
    );
  }

  // Widget utilitaire pour afficher une ligne d'information
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(
            context,
          ).style, // Hérite du style par défaut
          children: <TextSpan>[
            TextSpan(
              text: '$label : ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value ?? 'Non spécifié'),
          ],
        ),
      ),
    );
  }
}
