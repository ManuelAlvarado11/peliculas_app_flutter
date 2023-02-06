import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'ab75fc068a9fe2644bec04978cda766a';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';
  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
  }

  // ********** GET MOVIES ********
  getOnDisplayMovies() async {
    // URL Backend
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': '1',
    });

    // Peticion Http
    final response = await http.get(url);

    // Formatear JSON en un Model
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    // Redibuja los widget en base a los cambios de la clase AppState (Provider)

    notifyListeners();
  }
}
