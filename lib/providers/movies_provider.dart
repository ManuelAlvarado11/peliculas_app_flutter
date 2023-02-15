import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ab75fc068a9fe2644bec04978cda766a';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';

  // Forma 1 de cargar la data
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  int _popularPage = 0;

  // Forma 2 de cargar la data (Memoria)
  Map<int, List<Cast>> moviesCast = {};

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

  // Forma 1
  // ********** GET DISPLAY MOVIES ********
  getOnDisplayMovies() async {
    //Obtener Response Data
    final body = await _getJsonData('3/movie/now_playing');

    // Formatear JSON (SIN PROCESAR) en un Model
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(body);
    onDisplayMovies = nowPlayingResponse.results;

    // Redibuja los widget en base a los cambios de la clase AppState (Provider)
    notifyListeners();
  }

  // Forma 1
  // ********** GET POPULAR MOVIES ********
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

  // Forma 2
  // ************ GET CAST MOVIE **************
  Future<List<Cast>> getMovieCast(int movieId) async {
    // Verificar si ya existe en Memoria (MovieCast)
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    // Peticion HTTP
    final body = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromRawJson(body);

    // Agregar en Memoria (MovieCast)
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
