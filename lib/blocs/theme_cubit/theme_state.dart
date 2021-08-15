part of 'theme_cubit.dart';

@immutable
abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeModeState extends ThemeState {
  const ThemeModeState(this.mode);

  final AppTheme mode;

  @override
  List<Object> get props => <Object>[mode];
}
