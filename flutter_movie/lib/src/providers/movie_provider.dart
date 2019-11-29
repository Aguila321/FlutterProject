import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_movie/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '890ef53827d988d4e7ae1a4ad3b4c25d';
  String _url = 'api.themoviedb.org';
  // String _url = 'https://api.themoviedb.org/';
  String _language = 'es-ES';
  
  //Refactorizando Codigo
  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopularity() async {
    //Construyendo la url de la peticion
    final urlPopular = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});
    return await _processResponse(urlPopular);
  }
}
