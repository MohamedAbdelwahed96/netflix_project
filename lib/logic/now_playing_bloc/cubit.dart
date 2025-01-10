import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/now_playing_bloc/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingCubit extends Cubit<NowPlayingStates> {
  Dio dio;

  NowPlayingCubit(this.dio) : super(NowPlayingInitialState());

  Future getNowPlayingMovies() async {
    emit(NowPlayingLoadingState());
    try {
      final response = await dio.get(Paths.NowPlayingURL);
      if (response.statusCode == 200) {
        final NowPlayingRes = MovieResponse.fromMap(response.data);
        emit(NowPlayingSuccessState(NowPlayingRes));
      }
    } catch (e) {
      emit(NowPlayingErrorState(e.toString()));
    }
  }
}
