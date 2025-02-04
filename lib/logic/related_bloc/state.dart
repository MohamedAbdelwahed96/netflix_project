import 'package:netfelix_project/data/movies_data.dart';

class RelatedStates {}

class RelatedInitialState extends RelatedStates {}

class RelatedLoadingState extends RelatedStates {}

class RelatedSuccessState extends RelatedStates {
  MovieResponse movRes;

  RelatedSuccessState(this.movRes);
}

class RelatedErrorState extends RelatedStates {
  String errorMSG;

  RelatedErrorState(this.errorMSG);
}
