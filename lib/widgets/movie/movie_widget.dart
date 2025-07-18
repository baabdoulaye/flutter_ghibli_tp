import 'package:flutter/material.dart';

class MovieWidget extends StatelessWidget {
  // récupérer l'id envoyé par l'écran
  final String? id;

  const MovieWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Text(id!);
  }
}
