import 'package:news_app/shared/cubit/app_mode_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/shard_helper.dart';

class AppModeCubit extends Cubit<AppModeStates> {
  AppModeCubit() : super(InitialAppModeState());
  static AppModeCubit get(context) => BlocProvider.of(context);
  bool isDark = true;
  void changeAppMode({bool? isDarkMode}) {
    if (isDarkMode != null) {
      isDark = isDarkMode;
    } else {
      isDark = !isDark;
      SharedHelper()..putData("isDark", isDark);
    }

    emit(ChangeAppModeState());
  }
}
