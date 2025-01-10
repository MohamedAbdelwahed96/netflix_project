import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/details_screen_bloc/state.dart';

class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  Dio dio;

  DetailsScreenCubit(this.dio) : super(DetailsScreenInitialState());

  Future getMovieData(int movieId) async {
    emit(DetailsScreenLoadingState());
    try {
      final response =
          await dio.get(Paths.baseURL + movieId.toString() + Paths.apiKey);
      if (response.statusCode == 200) {
        final MovieDataRes = Movie.fromMap(response.data);
        emit(DetailsScreenSuccessState(MovieDataRes));
      }
    } catch (e) {
      emit(DetailsScreenErrorState(e.toString()));
    }
  }
}
