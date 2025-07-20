// services/router_service.dart
import 'dart:developer';

import 'package:ghibli/screens/home_screen.dart';
import 'package:ghibli/screens/movie_screen.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  // lister les routes de l'application
  GoRouter getRouter() {
    return GoRouter(
      routes: [
        /*
        path : schéma web de la route
        nom : nom de la route
        builder permet de cibler l'écran lié à la route
      */
        // écran d'accueil
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => HomeScreen(),
        ),

        // écran d'un film
        GoRoute(
          path: '/movie/:id',
          name: 'movie',
          builder: (context, state) {
            inspect(state);
            return MovieScreen(id: state.pathParameters['id']);
          },
        ),
      ],
    );
  }
}
