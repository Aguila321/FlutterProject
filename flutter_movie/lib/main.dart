import 'package:flutter/material.dart';
import 'package:flutter_movie/src/pages/home_page.dart';
import 'package:flutter_movie/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      //Definimos nuestra ruta inicial cuando inicie la app
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
