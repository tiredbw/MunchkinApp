import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/application/statistics_controller.dart';
import 'package:munchkin_app/data/storage/statistics_store.dart';
import 'package:munchkin_app/features/room/create_room_screen.dart';
import 'package:munchkin_app/features/room/join_room_screen.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets('join room screen always has a back button', (tester) async {
    await _pump(tester, const JoinRoomScreen());
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('create room screen always has a back button', (tester) async {
    await _pump(tester, const CreateRoomScreen());
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('create room can add players sharing the host device', (
    tester,
  ) async {
    await _pump(tester, const CreateRoomScreen());

    expect(find.text('Players on this device'), findsOneWidget);
    await tester.tap(find.text('Add player'));
    await tester.pump();

    expect(find.byIcon(Icons.remove_circle_outline), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Your name'), findsNWidgets(2));
  });
}

Future<void> _pump(WidgetTester tester, Widget home) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sessionControllerProvider.overrideWith(_FakeSessionController.new),
        statisticsControllerProvider.overrideWith(
          _FakeStatisticsController.new,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeSessionController extends SessionController {
  @override
  SessionState build() => const SessionState();
}

class _FakeStatisticsController extends StatisticsController {
  @override
  Future<StatisticsData> build() async => const StatisticsData();
}
