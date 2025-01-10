import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/genre_bloc/state.dart';

class GenreCubit extends Cubit<GenreStates> {
  Dio dio;

  GenreCubit(this.dio) : super(GenreInitialState());

  Future getGenre() async {
    emit(GenreLoadingState());
    try {
      final response = await dio.get(Paths.Genre);
      if (response.statusCode == 200) {
        final List<dynamic> genres = response.data["genres"];
        final genreList = Genre.fromList(genres);
        emit(GenreSuccessState(genreList));
      }
    } catch (e) {
      emit(GenreErrorState(e.toString()));
    }
  }
}
