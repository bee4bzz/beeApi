import 'package:beeapp/app/view/app.dart';
import 'package:beeapp/observer/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print(
        '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver(Logger("BlocObserver"));

  runApp(App());
}
