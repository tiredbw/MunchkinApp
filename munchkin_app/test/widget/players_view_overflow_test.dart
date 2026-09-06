import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/game/players_view.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

/// The name/tag row in each player card is a plain Row with only the name
/// wrapped in Flexible - every tag ("You", "Current turn", "Winner", "This
/// device", "Up next") is a fixed-width sibling with no wrap. A player who
/// is simultaneously the local device, the active player, and the winner,
/// with a maximum-length (24-char) name, on a narrow phone width, is the
/// worst case for that row overflowing.
void main() {
  testWidgets(
    'a maxed-out name plus every simultaneous tag does not overflow on a narrow phone',
    (tester) async {
      final now = DateTime.utc(2026, 1, 1);
      final me = const Player(
        id: 'p1',
        name: 'Alexandra Konstantinovna!!', // 24 chars, the app's max length
        isHost: true,
        level: 9,
        peakLevel: 9,
        strength: 3,
      );
      final other = const Player(
        id: 'p2',
        name: 'Bob',
        isHost: false,
        level: 1,
        peakLevel: 1,
        strength: 0,
      );
      final game = GameState(
        roomId: 'room',
        settings: const RoomSettings(),
        phase: RoomPhase.playing,
        players: <Player>[me, other],
        turnOrder: const <String>['p1', 'p2'],
        activePlayerId: 'p1',
        winnerPlayerId: 'p1',
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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              // The narrowest common phone width (iPhone SE class).
              data: const MediaQueryData(size: Size(320, 640)),
              child: Scaffold(
                body: SizedBox(
                  width: 320,
                  child: PlayersView(onOpenCharacter: () {}),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    },
  );
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

  @override
  List<String> get controlledPlayerIds => <String>['p1'];

  @override
  bool controlsPlayer(String? id) => id == 'p1';
}
