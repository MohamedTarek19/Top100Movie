import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider_riverpod/data/models/model.dart';
import 'package:provider_riverpod/data/repos/movies_repo.dart';
import 'package:provider_riverpod/data/webservises/movies_webservices.dart';
part 'movies_state.dart';


class MoviesCubit extends Cubit<MoviesState> {
  late final MoviesRepository repo;
  List<TopImdbMovies>? Movies;
  MoviesCubit(this.repo) : super(MoviesInitial());

  List<TopImdbMovies>? GetMovies(){
    emit(MoviesOnLoading());
    try{
      repo.getAllMovies().then((Movies){
        emit(MoviesOnLoaded(movies: Movies??[]));
        this.Movies = Movies;
      });
      return Movies;
    }catch(e){
      emit(MoviesOnError(error: e.toString()));
      return [];
    }

  }
}
