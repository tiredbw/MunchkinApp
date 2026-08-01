import '../../domain/commands/game_command.dart';
import '../../domain/game_engine.dart';
import '../../domain/models/game_models.dart';

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

sealed class CommandReply {
  const CommandReply();
}

class CommandAccepted extends CommandReply {
  const CommandAccepted(this.revision);

  final int revision;
}

class CommandRejected extends CommandReply {
  const CommandRejected(this.code, this.message);

  final GameErrorCode code;
  final String message;
}

abstract interface class GameConnection {
  Stream<GameState> get snapshots;
  Stream<ConnectionStatus> get statuses;
  GameState? get currentState;
  String? get playerId;

  Future<CommandReply> send(GameCommand command);
  Future<void> disconnect();
}
