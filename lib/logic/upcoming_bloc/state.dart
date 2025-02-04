import 'package:netfelix_project/data/movies_data.dart';

class UpcomingStates {}

class UpcomingInitialState extends UpcomingStates {}

class UpcomingLoadingState extends UpcomingStates {}

class UpcomingSuccessState extends UpcomingStates {
  MovieResponse UpcomingRes;

  UpcomingSuccessState(this.UpcomingRes);
}

class UpcomingErrorState extends UpcomingStates {
  String errorMSG;

  UpcomingErrorState(this.errorMSG);
}
