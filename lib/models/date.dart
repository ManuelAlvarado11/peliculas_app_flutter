import 'dart:convert';

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  // Decodifica el RawJson en una Instancia de la clase
  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  // Decodifica el Json en una Instancia de la clase
  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}
