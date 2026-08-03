import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/features/home/home_screen.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets('home screen renders English localization', (tester) async {
    await tester.pumpWidget(_testApp(const Locale('en')));
    await tester.pump();
    expect(find.text('Tabletop Companion'), findsOneWidget);
    expect(find.text('Create room'), findsOneWidget);
    expect(find.text('Join room'), findsOneWidget);
  });

  testWidgets('home screen renders Russian localization', (tester) async {
    await tester.pumpWidget(_testApp(const Locale('ru')));
    await tester.pump();
    expect(find.text('Настольный помощник'), findsOneWidget);
    expect(find.text('Создать комнату'), findsOneWidget);
    expect(find.text('Войти в комнату'), findsOneWidget);
  });

  testWidgets('home screen offers a saved client session', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionControllerProvider.overrideWith(_SavedSessionController.new),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Continue game'), findsOneWidget);
  });
}

class _SavedSessionController extends SessionController {
  @override
  SessionState build() => const SessionState(hasClientSession: true);
}

Widget _testApp(Locale locale) => ProviderScope(
  child: MaterialApp(
    locale: locale,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: const HomeScreen(),
  ),
);
