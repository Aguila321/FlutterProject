import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_movie/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '890ef53827d988d4e7ae1a4ad3b4c25d';
  String _url = 'api.themoviedb.org';
  // String _url = 'https://api.themoviedb.org/';
  String _language = 'es-ES';
  int _popularPage = 0;
  //Variable loader para evitar llamadas http innecesarias, al hacer el scroll al horizontal image
  bool _loader = false;
  List<Movie> populares = new List();
  //Este stream sirve para escuchar y emitir informacion es un puente de  flujo de datos
  //El brodcast escucha varios listener no solo uno
  final _popularesStreamController =
      new StreamController<List<Movie>>.broadcast();

  //Funcion que recibie una  lista de  movies, esta  misma la manda por el stream "flujo"
  //Proceso de introducir peliculas
  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Obtener los datos
  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  //Refactorizando Codigo
  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getEnCines() async {
    print('get cines: http');

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopularity() async {
    print('get popularity: http');

    //Si  esta cargando datos returna un array vacio
    if (_loader) return [];
    //Si no esta cargando, asiganmos el true
    _loader = true;

    _popularPage++;

    //Construyendo la url de la peticion
    final urlPopular = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await _processResponse(urlPopular);
    //Agregados datos del response al array
    populares.addAll(response);
    //Añadiendo informacion al stream mediante el Sink
    popularesSink(populares);
    //Cuando la respuesta ya se tiene del servicio.
    _loader = false;
    return response;
  }
}
