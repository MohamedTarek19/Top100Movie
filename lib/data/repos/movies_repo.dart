import 'package:provider_riverpod/data/models/model.dart';
import 'package:provider_riverpod/data/webservises/movies_webservices.dart';

class MoviesRepository{
  final MoviesWebService service;

  MoviesRepository(this.service);

  Future<List<TopImdbMovies>?> getAllMovies() async{
    final topMovies = await service.getAllMovies();
    final movies = topMovies?.map((movie) => TopImdbMovies.fromjson(movie)).toList();
    print(movies?[0].title);
    return movies;
  }



}