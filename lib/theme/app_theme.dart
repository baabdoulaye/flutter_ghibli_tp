import 'package:flutter/material.dart';

class AppTheme {
  /*
    visibilité en dart : uniquement public et private
    pas de mot-clé public ou private
    pour créer un membre privé, préfixer le nom du membre par un tiret bas _
  */

  ThemeData getTheme() {
    return ThemeData(
      // style de la appbar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      // style des textes
      textTheme: TextTheme(
        // texte courant
        bodyMedium: TextStyle(
          fontFamily: 'RedditSansCondensed',
          fontWeight: FontWeight.w400,
        ),

        // titre
        titleMedium: TextStyle(
          fontFamily: 'RedditSansCondensed',
          fontSize: 21,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
