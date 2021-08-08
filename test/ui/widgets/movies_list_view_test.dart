import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_movie_app/application/app.dart';
import 'package:next_movie_app/blocs/movie_bloc/movie_bloc.dart';

void main() {
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

  group('Home screen as a movies_list_view :)', () {
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
  });
}
