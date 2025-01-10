import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_images.dart';
import 'package:netfelix_project/logic/pics_screen_bloc/state.dart';

class PicsScreenCubit extends Cubit<PicsScreenStates>{
  Dio dio;
  PicsScreenCubit(this.dio) : super(PicsScreenInitialState());

  Future getImages(String movieId) async{
    emit(PicsScreenLoadingState());
    try{
      final response = await dio.get("${Paths.baseURL}$movieId/images${Paths.apiKey}");
      if(response.statusCode==200){
        final ImgResp = Images.fromMap(response.data);
        emit(PicsScreenSuccessState(ImgResp));
      }
    }
    catch(e){
      emit(PicsScreenErrorState(e.toString()));
    }
  }
}