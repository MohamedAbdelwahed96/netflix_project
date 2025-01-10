import 'package:netfelix_project/data/movies_data.dart';

class DetailsScreenStates {}

class DetailsScreenInitialState extends DetailsScreenStates {}

class DetailsScreenLoadingState extends DetailsScreenStates {}

class DetailsScreenSuccessState extends DetailsScreenStates {
  Movie MovieDetails;

  DetailsScreenSuccessState(this.MovieDetails);
}

class DetailsScreenErrorState extends DetailsScreenStates {
  String ErrorMSG;

  DetailsScreenErrorState(this.ErrorMSG);
}
