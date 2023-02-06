import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_app/providers/movies_provider.dart';

void main() => runApp(const AppState());

// Clase del estado de mi App atravez de la cual instanciamos MyApp()
class AppState extends StatelessWidget {
  const AppState({super.key});

  // Widget que retorna una lista de Providers
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

// Widget principal de MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.blue.shade900),
      ),
    );
  }
}
