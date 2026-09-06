import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/game/turn_view.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

/// The "active player" pill at the top of the Current Turn tab wraps its
/// name in Flexible, but the Row itself is `mainAxisSize: MainAxisSize.min`
/// - a Flexible inside a min-sized Row doesn't get a bounded width to
/// ellipsize against, so a long enough name could grow the pill wider than
/// the screen instead of truncating. Verified with the app's max (24-char)
/// player name on the narrowest common phone width.
void main() {
  testWidgets(
    'the active-player pill does not overflow with a maximum-length name on a narrow phone',
    (tester) async {
      final now = DateTime.utc(2026, 1, 1);
      final active = const Player(
        id: 'p1',
        name: 'Alexandra Konstantinovna!!', // 24 chars, the app's max length
        isHost: true,
        level: 1,
        strength: 0,
      );
      final game = GameState(
        roomId: 'room',
        settings: const RoomSettings(),
        phase: RoomPhase.playing,
        players: <Player>[active],
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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: const MediaQueryData(size: Size(320, 640)),
              child: Scaffold(
                body: SizedBox(width: 320, child: TurnView()),
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
  String? get playerId => 'p1';

  @override
  bool get isHost => true;

  @override
  List<String> get controlledPlayerIds => <String>['p1'];

  @override
  bool controlsPlayer(String? id) => id == 'p1';
}
