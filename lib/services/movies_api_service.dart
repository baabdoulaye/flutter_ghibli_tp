import 'dart:convert';

import 'package:ghibli/models/movie.dart';
import 'package:http/http.dart' as http;

class MoviesApiService {
  // récupérer tous les films
  // Future équivaut à une Promise (promesse en JS)
  Future<List<Movie>> getMovies() async {
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
    throw Error();
  }
}
