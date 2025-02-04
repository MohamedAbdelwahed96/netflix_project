import 'package:netfelix_project/data/movies_data.dart';

class NowPlayingStates {}

class NowPlayingInitialState extends NowPlayingStates {}

class NowPlayingLoadingState extends NowPlayingStates {}

class NowPlayingSuccessState extends NowPlayingStates {
  MovieResponse NowPlayingRes;

  NowPlayingSuccessState(this.NowPlayingRes);
}

class NowPlayingErrorState extends NowPlayingStates {
  String errorMSG;

  NowPlayingErrorState(this.errorMSG);
}
