import 'package:netfelix_project/data/movies_data.dart';

class TopRatedStates {}

class TopRatedInitialState extends TopRatedStates {}

class TopRatedLoadingState extends TopRatedStates {}

class TopRatedSuccessState extends TopRatedStates {
  MovieResponse TopRatedRes;

  TopRatedSuccessState(this.TopRatedRes);
}

class TopRatedErrorState extends TopRatedStates {
  String ErrorMsg;

  TopRatedErrorState(this.ErrorMsg);
}
