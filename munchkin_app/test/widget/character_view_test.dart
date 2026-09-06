import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/game/character_view.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets('character view scrolls to reveal identity and turn actions', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 1, 1);
    final player = const Player(
      id: 'p1',
      name: 'Alexey',
      isHost: true,
      level: 1,
      strength: 0,
    );
    final game = GameState(
      roomId: 'room',
      settings: const RoomSettings(),
      phase: RoomPhase.playing,
      players: <Player>[player],
      turnOrder: const <String>['p1'],
      activePlayerId: 'p1',
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionControllerProvider.overrideWith(
            () => _FakeSessionController(SessionState(game: game)),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SizedBox(
              // Small viewport, like a phone screen with a bottom nav bar
              // taking up part of the height, to force scrolling to be
              // necessary to reach the bottom content.
              height: 500,
              child: CharacterView(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Race & class'), findsNothing);
    expect(find.text('Start battle'), findsNothing);

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pump();

    expect(find.text('Race & class'), findsOneWidget);
    expect(find.text('Start battle'), findsOneWidget);
  });
}

class _FakeSessionController extends SessionController {
  _FakeSessionController(this._initial);

  final SessionState _initial;

  @override
  SessionState build() => _initial;

  @override
  String? get playerId => _initial.game?.players.first.id;

  @override
  bool get isHost => true;
}
