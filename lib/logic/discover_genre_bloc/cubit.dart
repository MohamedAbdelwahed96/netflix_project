import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/discover_genre_bloc/state.dart';

class DiscoverGenreCubit extends Cubit<DiscoverGenreStates> {
  Dio dio;

  DiscoverGenreCubit(this.dio) : super(DiscoverGenreInitialState());

  Future getGenre(int id,pageNumber) async {
    emit(DiscoverGenreLoadingState());
    try {
        final response = await dio.get("https://api.themoviedb.org/3/discover/movie?api_key=0e56004f55365c73dbfae5234655fbcd&with_genres=$id&page=$pageNumber&include_adult=false");
        if (response.statusCode == 200) {
          final genRes = MovieResponse.fromMap(response.data);
          emit(DiscoverGenreSuccessState(genRes));
        }
    }
      catch (e) {
      emit(DiscoverGenreErrorState(e.toString()));
    }
  }
}
