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
      final response = await dio.get("${Paths.baseURL}$movieId/recommendations${Paths.apiKey}");
      if (response.statusCode == 200) {
        // Filter out adult and R-rated movies
        final filteredMovies = MovieResponse(movies:  MovieResponse.fromMap(response.data).movies.where((movie) =>
        !movie.adult && movie.certification != "R" &&
            movie.certification != "NC-17" &&
            movie.certification != "18" &&
            movie.certification != "FSK 18" &&
            movie.certification != "-18"
        ).toList());
        emit(RelatedSuccessState(filteredMovies));
      }
    } catch (e) {
      emit(RelatedErrorState(e.toString()));
    }
  }
}
