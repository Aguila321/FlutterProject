import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //recuperamos el valor de los argumentos. enviados desde el home_page ['horizontal image'];
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text(movie.title),
      ),
    );
  }
}
