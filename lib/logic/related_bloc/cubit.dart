import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_data.dart';
import 'package:netfelix_project/logic/related_bloc/state.dart';

class RelatedCubit extends Cubit<RelatedStates> {
  Dio dio;

  RelatedCubit(this.dio) : super(RelatedInitialState());

  Future getRelatedMovies(int movieId) async {
    emit(RelatedLoadingState());
    try {
      final response = await dio.get(Paths.baseURL+movieId.toString()+"/recommendations"+Paths.apiKey);
      if (response.statusCode == 200) {
        final movRes = MovieResponse.fromMap(response.data);
        emit(RelatedSuccessState(movRes));
      }
    } catch (e) {
      emit(RelatedErrorState(e.toString()));
    }
  }
}
