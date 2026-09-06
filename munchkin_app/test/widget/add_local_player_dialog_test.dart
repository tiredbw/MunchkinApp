import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/application/session_controller.dart';
import 'package:munchkin_app/core/network/network_protocol.dart';
import 'package:munchkin_app/domain/models/game_models.dart';
import 'package:munchkin_app/features/room/room_screen.dart';
import 'package:munchkin_app/l10n/app_localizations.dart';

void main() {
  testWidgets(
    'confirming the add-local-player dialog does not crash while it closes',
    (tester) async {
      final now = DateTime.utc(2026, 1, 1);
      final host = const Player(
        id: 'host',
        name: 'Host',
        isHost: true,
        level: 1,
        strength: 0,
      );
      final game = GameState(
        roomId: 'room',
        settings: const RoomSettings(),
        players: <Player>[host],
        createdAt: now,
        updatedAt: now,
      );

      await tester.binding.setSurfaceSize(const Size(400, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sessionControllerProvider.overrideWith(
              () => _FakeSessionController(
                SessionState(
                  game: game,
                  invite: const RoomInvite(
                    host: '127.0.0.1',
                    port: 1234,
                    roomId: 'room',
                    token: 'token',
                    pin: '000000',
                  ),
                ),
              ),
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
            home: const RoomScreen(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Add player'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Bob');
      await tester.tap(find.widgetWithText(FilledButton, 'Add player'));

      // Deliberately pump single frames (not pumpAndSettle) to land in the
      // middle of the dialog's exit transition, which is exactly when a
      // TextEditingController disposed too early would blow up.
      await tester.pump();
      expect(tester.takeException(), isNull);
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      await tester.pumpAndSettle();
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
}
