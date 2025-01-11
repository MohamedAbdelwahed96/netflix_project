import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netfelix_project/core/paths.dart';
import 'package:netfelix_project/data/movies_videos.dart';
import 'package:netfelix_project/logic/videos_screen_bloc/state.dart';

class VideosScreenCubit extends Cubit<VideosScreenStates>{
  Dio dio;
  VideosScreenCubit(this.dio) : super(VideosScreenInitialState());

  Future getVideos(String movieId) async{
    emit(VideosScreenLoadingState());
    try{
      final response = await dio.get("${Paths.baseURL}$movieId/videos${Paths.apiKey}");
      if(response.statusCode==200){
        final VidResp = VideoList.fromMap(response.data);
        emit(VideosScreenSuccessState(VidResp));
      }
    }
    catch(e){
      emit(VideosScreenErrorState(e.toString()));
    }
  }
}