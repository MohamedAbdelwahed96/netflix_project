import 'package:netfelix_project/data/movies_images.dart';

class PicsScreenStates {}

class PicsScreenInitialState extends PicsScreenStates {}

class PicsScreenLoadingState extends PicsScreenStates {}

class PicsScreenSuccessState extends PicsScreenStates {
  Images img;

  PicsScreenSuccessState(this.img);
}

class PicsScreenErrorState extends PicsScreenStates {
  String errorMSG;

  PicsScreenErrorState(this.errorMSG);
}
