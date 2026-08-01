import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import 'router.dart';
import 'theme.dart';

class MunchkinApp extends StatelessWidget {
  const MunchkinApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Tabletop Companion',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(Brightness.light),
    darkTheme: buildAppTheme(Brightness.dark),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: appRouter,
  );
}
