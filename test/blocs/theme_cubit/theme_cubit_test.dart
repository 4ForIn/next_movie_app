import 'package:bloc_test/bloc_test.dart';
import 'package:next_movie_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:next_movie_app/utils/constants/enums/enums.dart';
import 'package:test/test.dart';

void main() {
  late ThemeCubit cubit;

  group('ThemeCubit emits mode: lightMode', () {
    setUp(() {
      cubit = ThemeCubit();
    });
    tearDown(() {
      cubit.close();
    });

    test('as initial state', () {
      expect((cubit.state as ThemeModeState).mode, AppTheme.lightMode);
    });
    test('as initial state ThemeModeState(AppTheme.lightMode)', () {
      expect(cubit.state, const ThemeModeState(AppTheme.lightMode));
    });
  });

  group('ThemeCubit emits', () {
    setUp(() {
      cubit = ThemeCubit();
    });
    tearDown(() {
      cubit.close();
    });

    blocTest<ThemeCubit, ThemeState>(
      '<ThemeModeState>',
      build: () => cubit,
      act: (ThemeCubit cubit) {
        cubit.setLightTheme();
        cubit.switchTheme();
      },
      expect: () => <TypeMatcher<ThemeModeState>>[
        isA<ThemeModeState>(),
        isA<ThemeModeState>(),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'ThemeModeState(AppTheme.lightMode) when setLightTheme() called',
      build: () => cubit,
      act: (ThemeCubit cubit) => cubit.setLightTheme(),
      expect: () => <ThemeState>[
        const ThemeModeState(AppTheme.lightMode),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'ThemeModeState(AppTheme.darkMode) when setDarkTheme() called',
      build: () => cubit,
      act: (ThemeCubit cubit) => cubit.setDarkTheme(),
      expect: () => <ThemeState>[
        const ThemeModeState(AppTheme.darkMode),
      ],
    );
  });

  group('ThemeCubit switches state mode', () {
    setUp(() {
      cubit = ThemeCubit();
    });
    tearDown(() {
      cubit.close();
    });

    blocTest<ThemeCubit, ThemeState>(
      'to AppTheme.darkMode from AppTheme.lightMode',
      build: () => cubit,
      act: (ThemeCubit cubit) {
        cubit.setLightTheme();
        cubit.switchTheme();
      },
      expect: () => <ThemeState>[
        const ThemeModeState(AppTheme.lightMode),
        const ThemeModeState(AppTheme.darkMode),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'to AppTheme.lightMode from AppTheme.darkMode',
      build: () => cubit,
      act: (ThemeCubit cubit) {
        cubit.setDarkTheme();
        cubit.switchTheme();
      },
      expect: () => <ThemeState>[
        const ThemeModeState(AppTheme.darkMode),
        const ThemeModeState(AppTheme.lightMode),
      ],
    );
  });
}
