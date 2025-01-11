import 'package:netfelix_project/data/movies_videos.dart';

class VideosScreenStates {}

class VideosScreenInitialState extends VideosScreenStates {}

class VideosScreenLoadingState extends VideosScreenStates {}

class VideosScreenSuccessState extends VideosScreenStates {
  VideoList vid;

  VideosScreenSuccessState(this.vid);
}

class VideosScreenErrorState extends VideosScreenStates {
  String errormsg;

  VideosScreenErrorState(this.errormsg);
}
