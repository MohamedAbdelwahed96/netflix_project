import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/discover_genre_bloc/state.dart';

class DiscoverGenreCubit extends Cubit<DiscoverGenreStates> {
  Dio dio;
  DiscoverGenreCubit(this.dio) : super(DiscoverGenreInitialState());

  Future getGenre(int id,pageNumber) async {
    emit(DiscoverGenreLoadingState());
    try {
        final response = await dio.get("${Paths.Discover}&with_genres=$id&page=$pageNumber&certification_country=US&certification.lte=R");
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
