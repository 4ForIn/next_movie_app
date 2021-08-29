import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:next_movie_app/application/app.dart';
import 'package:next_movie_app/utils/bloc_observer/app_bloc_observer.dart';
import 'package:next_movie_app/utils/constants/local_db_strings/local_db_strings.dart';

import 'domain/entities/movie/movie.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  // setup Hive database:
  await Hive.initFlutter();
  // registration of Hive DB adapter generated in movie.g.dart file:
  Hive.registerAdapter<Movie>(MovieAdapter());
  await Hive.openBox<Movie>(
      DbStrings.hiveBoxFavoriteMovies); // need to be closed!

  Bloc.observer = AppBlocObserver(); // bloc debugging
  runApp(Application());
}
