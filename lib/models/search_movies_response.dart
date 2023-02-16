import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class SearchMoviesResponse {
  int page;
  int totalPages;
  int totalResults;
  List<Movie> results;

  SearchMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMoviesResponse.fromRawJson(String str) =>
      SearchMoviesResponse.fromJson(json.decode(str));

  factory SearchMoviesResponse.fromJson(Map<String, dynamic> json) =>
      SearchMoviesResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
