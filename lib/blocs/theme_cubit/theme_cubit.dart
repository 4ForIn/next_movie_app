import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:next_movie_app/utils/constants/enums/enums.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeModeState(AppTheme.lightMode));

  AppTheme _prevState = AppTheme.lightMode;

  @override
  void onChange(Change<ThemeState> change) {
    _prevState = (change.nextState as ThemeModeState).mode;
    super.onChange(change);
    // print((change.nextState as ThemeModeState).mode);
  }

  void setLightTheme() => emit(const ThemeModeState(AppTheme.lightMode));
  void setDarkTheme() => emit(const ThemeModeState(AppTheme.darkMode));
  void switchTheme() {
    if (_prevState == AppTheme.lightMode) {
      emit(const ThemeModeState(AppTheme.darkMode));
    } else {
      emit(const ThemeModeState(AppTheme.lightMode));
    }
  }
}
