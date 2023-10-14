part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}


class MoviesOnLoading extends MoviesState {}

class MoviesOnLoaded extends MoviesState {
  List<TopImdbMovies> movies;

  MoviesOnLoaded({required this.movies});
}

class MoviesOnError extends MoviesState {
  String error;

  MoviesOnError({required this.error});
}
