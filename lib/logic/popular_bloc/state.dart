import 'package:netfelix_project/data/movies_data.dart';

class PopularStates {}

class PopularInitialState extends PopularStates {}

class PopularLoadingState extends PopularStates {}

class PopularSuccessState extends PopularStates {
  MovieResponse PopularRes;

  PopularSuccessState(this.PopularRes);
}

class PopularErrorState extends PopularStates {
  String errorMSG;

  PopularErrorState(this.errorMSG);
}
