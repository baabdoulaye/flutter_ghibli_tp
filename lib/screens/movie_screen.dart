// screens/movie_screen.dart
import 'package:flutter/material.dart';
import 'package:ghibli/widgets/movie/movie_widget.dart';
import 'package:ghibli/widgets/shared/appbar_widget.dart';

class MovieScreen extends StatelessWidget {
  // propriété qui récupère la variable de route : id
  final String? id;

  const MovieScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // inspect(id);

    return Scaffold(
      appBar: AppbarWidget(),
      // transmettre l'id au widget
      body: SingleChildScrollView(child: MovieWidget(id: id)),
    );
  }
}
