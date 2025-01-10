import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/top_rated_bloc/state.dart';

class TopRatedCubit extends Cubit<TopRatedStates> {
  Dio dio;

  TopRatedCubit(this.dio) : super(TopRatedInitialState());

  Future getTopRatedMovies() async {
    emit(TopRatedLoadingState());
    try {
      final response = await dio.get(Paths.TopRatedURL);
      if (response.statusCode == 200) {
        final TopRatedRes = MovieResponse.fromMap(response.data);
        emit(TopRatedSuccessState(TopRatedRes));
      }
    } catch (e) {
      emit(TopRatedErrorState(e.toString()));
    }
  }
}
