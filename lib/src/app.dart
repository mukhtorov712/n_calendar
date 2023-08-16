import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:n_calendar/src/core/locator.dart';

import 'features/calendar/presentation/manager/calendar_bloc.dart';
import 'features/calendar/presentation/pages/calendar_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CalendarBloc>()..init(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('en', 'GB'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'GB'),
          Locale('uz', 'UZ'),
        ],
        home: CalendarScreen(),
      ),
    );
  }
}
