import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/tob/tob_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  int currentIndex = 0;

  List<BottomNavigationBarItem> BottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "Tob"),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "business"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: "science"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_rounded), label: "sports"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
  ];
  List<Widget> screens = [
    TobScreen(),
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen()
  ];
  List<dynamic> tob = [];
  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];
  static NewsCubit get(context) => BlocProvider.of(context);
  void changeBottomNavBar(int indx) {
    currentIndex = indx;
    if (indx == 1) getBusiness();
    if (indx == 2) getScience();
    if (indx == 3) getSports();
    emit(NewsBottomNavState());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "apiKey": "6c5985ea821f4a9c9207d7beb33c4d02",
      "category": "business"
    }).then((value) {
      business = value.data["articles"];

      emit(NewsGetBusinessSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetBusinessErrorState(e.toString()));
    });
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "apiKey": "6c5985ea821f4a9c9207d7beb33c4d02",
      "category": "science"
    }).then((value) {
      science = value.data["articles"];

      emit(NewsGetScienceSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetScienceErrorState(e.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "apiKey": "6c5985ea821f4a9c9207d7beb33c4d02",
      "category": "Sports"
    }).then((value) {
      sports = value.data["articles"];

      emit(NewsGetSportsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetSportsErrorState(e.toString()));
    });
  }

  void getTob() {
    emit(NewsGetTobNewsLoadingState());
    DioHelper.getData("v2/top-headlines", query: {
      "country": "eg",
      "apiKey": "6c5985ea821f4a9c9207d7beb33c4d02",
    }).then((value) {
      tob = value.data["articles"];

      emit(NewsGetTobNewsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetTobNewsErrorState(e.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchNewsLoadingState());
    DioHelper.getData("v2/everything", query: {
      "q": "$value",
      "apiKey": "6c5985ea821f4a9c9207d7beb33c4d02",
    }).then((value) {
      search = value.data["articles"];

      emit(NewsGetSearchNewsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(NewsGetSearchNewsErrorState(e.toString()));
    });
  }
}
