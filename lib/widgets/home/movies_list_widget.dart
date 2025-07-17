import 'package:flutter/material.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Movies', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
