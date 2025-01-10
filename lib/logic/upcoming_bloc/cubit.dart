import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/upcoming_bloc/state.dart';

class UpcomingCubit extends Cubit<UpcomingStates> {
  Dio dio;

  UpcomingCubit(this.dio) : super(UpcomingInitialState());

  Future getUpcomingMovies() async {
    emit(UpcomingLoadingState());
    try {
      final response = await dio.get(Paths.UpcomingURL);
      if (response.statusCode == 200) {
        final UpcomingRes = MovieResponse.fromMap(response.data);
        emit(UpcomingSuccessState(UpcomingRes));
      }
    } catch (e) {
      emit(UpcomingErrorState(e.toString()));
    }
  }
}
