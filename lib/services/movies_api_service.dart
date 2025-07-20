// services/movies_api_service.dart
import 'dart:convert';
import 'package:ghibli/models/movie.dart';
import 'package:http/http.dart' as http;

class MoviesApiService {
  // Méthode pour récupérer tous les films
  // Future équivaut à une Promise (promesse en JS)
  Future<List<Movie>> getMovies() async {
    // <-- Cette méthode doit être présente !
    // définir l'URL de la requête
    Uri uri = Uri.parse('https://ghibliapi.vercel.app/films');

    // requête / réponse en GET
    http.Response response = await http.get(uri);

    // si la requête renvoie un code 200
    if (response.statusCode == 200) {
      // formater la réponse en JSON
      List json = await jsonDecode(response.body);

      // récupérer une liste d'objet Movie
      List<Movie> results = json.map((data) {
        return Movie.fromJSON(data);
      }).toList();

      return results;
    }

    // renvoyer une erreur
    throw Exception('Failed to load movies'); // Une meilleure gestion d'erreur
  }

  // Nouvelle méthode pour récupérer un film par son ID
  Future<Movie> getMovieById(String id) async {
    Uri uri = Uri.parse(
      'https://ghibliapi.vercel.app/films/$id',
    ); // L'URL de l'API pour un film spécifique

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = await jsonDecode(
        response.body,
      ); // C'est un seul objet, pas une liste

      return Movie.fromJSON(json); // Crée un seul objet Movie
    }

    throw Exception(
      'Failed to load movie with ID: $id',
    ); // Une meilleure gestion d'erreur
  }
}
