import 'dart:convert';
import 'package:peliculas_app/models/models.dart';

class NowPlayingResponse {
  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  // Decodifica el RawJson en una Instancia de la clase
  factory NowPlayingResponse.fromRawJson(String str) =>
      NowPlayingResponse.fromJson(json.decode(str));

  // Decodifica el Json en una Instancia de la clase
  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) =>
      NowPlayingResponse(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
