abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetTobNewsSuccessState extends NewsStates {}

class NewsGetTobNewsErrorState extends NewsStates {
  final error;

  NewsGetTobNewsErrorState(this.error);
}

class NewsGetTobNewsLoadingState extends NewsStates {}

class NewsGetSearchNewsSuccessState extends NewsStates {}

class NewsGetSearchNewsErrorState extends NewsStates {
  final error;

  NewsGetSearchNewsErrorState(this.error);
}

class NewsGetSearchNewsLoadingState extends NewsStates {}
