import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/statistics_controller.dart';
import 'package:munchkin_app/data/storage/statistics_store.dart';
import 'package:munchkin_app/features/statistics/statistics_screen.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets('statistics screen shows profile totals and history', (
    tester,
  ) async {
    final profile = UserProfile(
      id: 'profile',
      name: 'Alice',
      createdAt: DateTime.utc(2026, 8, 3),
      gamesPlayed: 1,
      wins: 1,
      maxLevel: 10,
      totalDurationSeconds: 3600,
    );
    final data = StatisticsData(
      profiles: <UserProfile>[profile],
      activeProfileId: profile.id,
      history: <GameHistoryRecord>[
        GameHistoryRecord(
          id: 'room:profile',
          roomId: 'room',
          localProfileId: profile.id,
          localPlayerId: 'alice',
          startedAt: DateTime.utc(2026, 8, 3, 10),
          endedAt: DateTime.utc(2026, 8, 3, 11),
          participants: const <GameParticipantRecord>[
            GameParticipantRecord(
              playerId: 'alice',
              name: 'Alice',
              finalLevel: 10,
              peakLevel: 10,
              finalStrength: 4,
            ),
          ],
          winnerPlayerIds: const <String>['alice'],
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          statisticsControllerProvider.overrideWith(
            () => _FakeStatisticsController(data),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const StatisticsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Games played'), findsOneWidget);
    expect(find.text('Wins'), findsOneWidget);
    expect(find.text('Maximum level'), findsOneWidget);
    expect(find.text('1 h 0 min'), findsAtLeast(1));
    expect(find.text('Winner: Alice'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}

class _FakeStatisticsController extends StatisticsController {
  _FakeStatisticsController(this.data);

  final StatisticsData data;

  @override
  Future<StatisticsData> build() async => data;
}
