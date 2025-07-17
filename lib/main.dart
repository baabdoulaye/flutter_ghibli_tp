/*
  fonction main : démarrer l'application dart
    - dart est un langage typé : variables, paramètres, retour de fonction…
    - dart n'affecte pas la valeur nulle à une variable sans valeur
*/

import 'package:flutter/material.dart';
import 'package:ghibli/screens/home_screen.dart';
import 'package:ghibli/theme/app_theme.dart';

/*
  MyApp est le widget (composant) général de l'application
  un widget est une classe dart
*/

void main() => runApp(MyApp());

// widget (composant) général de l'application
class MyApp extends StatelessWidget {
  // constructeur
  const MyApp({super.key});

  // build permet d'afficher le contenu du widget
  // paramètre context permet d'identifier le widget dans l'architecture de l'application, accès aux parents / enfants du widget
  @override
  Widget build(BuildContext context) {
    // MaterialApp permet de créer une application avec la bibliothèque de design Material (Android)
    // chaque widget possède des paramètres nommés et promus
    return MaterialApp(
      title: 'Studio Ghibli',
      theme: AppTheme().getTheme(),
      home: HomeScreen(),
    );
  }
}
