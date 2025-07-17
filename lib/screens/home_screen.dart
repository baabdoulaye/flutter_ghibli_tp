import 'package:flutter/material.dart';
import 'package:ghibli/widgets/home/movies_list_widget.dart';
import 'package:ghibli/widgets/shared/appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      // SingleChildScrollView permet de créer un ascenseur
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: MoviesListWidget(),
        ),
      ),
    );
  }
}
