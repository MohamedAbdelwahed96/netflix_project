import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/popular_bloc/state.dart';

class PopularCubit extends Cubit<PopularStates> {
  Dio dio;

  PopularCubit(this.dio) : super(PopularInitialState());

  Future getPopularMovies() async {
    emit(PopularLoadingState());
    try {
      final response = await dio.get(Paths.PopularURL);
      if (response.statusCode == 200) {
        final PopularRes = MovieResponse.fromMap(response.data);
        emit(PopularSuccessState(PopularRes));
      }
    } catch (e) {
      emit(PopularErrorState(e.toString()));
    }
  }
}
