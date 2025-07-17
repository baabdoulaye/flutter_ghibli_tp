import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ghibli/services/movies_api_service.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      débogage :
        print : déboguer des données simples
        inspect : déboguer des données complexes (Map et List)
    */
    inspect(MoviesApiService().getMovies());

    return Column(
      children: [
        Text('Movies', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
