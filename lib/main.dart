import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:next_movie_app/application/app.dart';
import 'package:next_movie_app/utils/bloc_observer/app_bloc_observer.dart';

Future<void> main() async {
  await dotenv.load();
  Bloc.observer = AppBlocObserver(); // bloc debugging
  runApp(Application());
}
