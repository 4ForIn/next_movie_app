// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
// (Given) some context
// (When) some action is carried out
// (Then) a particular set of observable consequences should obtain
// ARRANGE
// ACT
// ASSERT

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:next_movie_app/application/app.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:next_movie_app/ui/screens/home/home.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class MovieEventFake extends mocktail.Fake implements MovieEvent {}

class MovieStateFake extends mocktail.Fake implements MovieState {}

void main() {
  // late MovieState mState;
  late MovieBloc mBloc2;

  /*Widget makeWidgetTestable({required Widget child, required MovieBloc mBloc}) {
    return MaterialApp(
      home: BlocProvider<MovieBloc>(
        create: (BuildContext context) {
          return mBloc;
        },
        child: child,
      ),
    );
  }*/

  group('Home screen', () {
    group('when app starts', () {
      testWidgets('should render text "Show popular movies"',
          (WidgetTester tester) async {
        // ASSEMBLE
        await dotenv.load();
        await tester.pumpWidget(Application());
        // ACT
        // ASSERT
        expect(find.text('Show popular movies'), findsOneWidget);
        expect(find.text('BLoC Demo44'), findsNothing);
      }, skip: true);
      testWidgets('should render text "You will see popular movies below"',
          (WidgetTester tester) async {
        // ASSEMBLE

        await tester.pumpWidget(Application());
        // ACT
        await tester
            .press(find.widgetWithText(MaterialButton, 'Show popular movies'));
        await tester.pump();
        // ASSERT
        expect(find.text('You will see popular movies below'), findsOneWidget);
      }, skip: true);
    });
  });

  group('renders 2', () {
    setUp(() {
      mocktail.registerFallbackValue<MovieEvent>(MovieEventFake());
      mocktail.registerFallbackValue<MovieState>(MovieStateFake());
      //mState = MovieStateFake();
      mBloc2 = MockMovieBloc();
    });

    testWidgets('text You will see popular movies below',
        (WidgetTester tester) async {
      // when(mBloc2.state).thenAnswer((_) => const MovieInitial());
      whenListen(
          mBloc2,
          Stream<MovieState>.fromIterable([
            const MovieInitial(),
            const MovieLoaded(
                favoriteMovies: [], foundMovies: [], popularMovies: [])
          ]));
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<MovieBloc>.value(value: mBloc2),
          ],
          child: const MaterialApp(
            home: Home(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('no popular films'), findsOneWidget);
    }, skip: true);
  });
}

/*

 Widget makeWidgetTestable({required Widget child, required MovieBloc mBloc}) {
    return MaterialApp(
      home: BlocProvider<MovieBloc>(
        create: (BuildContext context) {
          return mBloc;
        },
        child: child,
      ),
    );
  }

  group('Home screen', () {
    group('when app starts', () {
      testWidgets('should render text "Show popular movies"',
          (WidgetTester tester) async {
        // ASSEMBLE
        await dotenv.load();
        await tester.pumpWidget(Application());
        // ACT
        // ASSERT
        expect(find.text('Show popular movies'), findsOneWidget);
        expect(find.text('BLoC Demo44'), findsNothing);
      });
      testWidgets('should render text "You will see popular movies below"',
          (WidgetTester tester) async {
        // ASSEMBLE

        await tester.pumpWidget(Application());
        // ACT
        await tester
            .press(find.widgetWithText(MaterialButton, 'Show popular movies'));
        await tester.pump();
        // ASSERT
        expect(find.text('You will see popular movies below'), findsOneWidget);
      });
    });

    // test above do not work
    group('when Btn is pressed', () {
      testWidgets('should render MovieCard"', (WidgetTester tester) async {
        // ASSEMBLE
        final AppMovieRepository mockRepo = MyRepoMock();
        final MovieBloc _bloc = MovieBloc(mockRepo);

        await tester
            .pumpWidget(makeWidgetTestable(child: const Home(), mBloc: _bloc));

        // ACT
        _bloc.add(const MovieLoadPopularEvent());
        await tester.pump();
        // await tester
        //     .press(find.widgetWithText(MaterialButton, 'Show popular movies'));
        await tester
            .tap(find.widgetWithText(MaterialButton, 'Show popular movies'));
        await tester.pump();
        // ASSERT
        expect(find.text('You will see popular movies below'), findsNothing);
        expect(find.byElementType(MoviesListView), findsWidgets);
        // expect(find.byElementType(CircularProgressIndicator), findsWidgets);
        // expect(find.text('Show popular movies'), findsOneWidget);
      });
    });
  });

 */
