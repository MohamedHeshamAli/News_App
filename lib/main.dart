import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/shared/cubit/app_mode_cuibit.dart';
import 'package:news_app/shared/cubit/app_mode_states.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/local/shard_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/news_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  DioHelper.init();

  runApp(MyApp(SharedHelper.getData("isDark")));

  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool? isDarkmode;

  MyApp(this.isDarkmode);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) =>
              AppModeCubit()..changeAppMode(isDarkMode: isDarkmode),
        ),
        BlocProvider(
          create: (BuildContext context) {
            return NewsCubit()..getTob();
          },
        )
      ],
      child: BlocConsumer<AppModeCubit, AppModeStates>(
          listener: (ctx, state) {},
          builder: (ctx, states) {
            return MaterialApp(
              themeMode: AppModeCubit.get(ctx).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: ThemeData.dark().copyWith(
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      elevation: 50, type: BottomNavigationBarType.fixed),
                  appBarTheme: AppBarTheme(
                      elevation: 00,
                      titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarIconBrightness: Brightness.light,
                      )),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white))),
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepOrange,
                      elevation: 50,
                      type: BottomNavigationBarType.fixed),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      elevation: 00,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ))),
              home: NewsLayout(),
            );
          }),
    );
  }
}
