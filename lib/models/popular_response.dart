import 'dart:convert';
import 'package:peliculas_app/models/models.dart';

class PopularResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  // Decodifica el RawJson en una Instancia de la clase
  factory PopularResponse.fromRawJson(String str) =>
      PopularResponse.fromJson(json.decode(str));

  // Decodifica el Json en una Instancia de la clase
  factory PopularResponse.fromJson(Map<String, dynamic> json) =>
      PopularResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
