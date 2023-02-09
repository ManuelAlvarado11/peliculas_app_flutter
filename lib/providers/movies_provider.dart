import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ab75fc068a9fe2644bec04978cda766a';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    // URL Backend
    var url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': '$page',
    });

    // Peticion Http
    final response = await http.get(url);
    return response.body;
  }

  // ********** GET MOVIES ********
  getOnDisplayMovies() async {
    //Obtener Response Data
    final body = await _getJsonData('3/movie/now_playing');

    // Formatear JSON (SIN PROCESAR) en un Model
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(body);
    onDisplayMovies = nowPlayingResponse.results;

    // Redibuja los widget en base a los cambios de la clase AppState (Provider)
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    //Obtener Response Data
    final body = await _getJsonData('3/movie/popular', _popularPage);

    // Formatear JSON (SIN PROCESAR) en un Model
    final popularResponse = PopularResponse.fromRawJson(body);

    onPopularMovies = [...onPopularMovies, ...popularResponse.results];

    // Redibuja los widget en base a los cambios de la clase AppState (Provider)
    notifyListeners();
  }
}
