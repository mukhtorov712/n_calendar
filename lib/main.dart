import 'package:flutter/material.dart';
import 'package:n_calendar/src/app.dart';
import 'package:n_calendar/src/core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MainApp());
}
