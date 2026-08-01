import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../domain/models/game_models.dart';

class RecoverySnapshot {
  const RecoverySnapshot({
    required this.state,
    this.resumeTokenHashes = const <String, String>{},
  });

  final GameState state;
  final Map<String, String> resumeTokenHashes;

  Map<String, Object?> toJson() => <String, Object?>{
    'schemaVersion': 1,
    'state': state.toJson(),
    'resumeTokenHashes': resumeTokenHashes,
  };

  factory RecoverySnapshot.fromJson(Map<String, Object?> json) {
    final state = json['state'];
    final hashes = json['resumeTokenHashes'];
    if (state is! Map<String, Object?> || hashes is! Map<String, Object?>) {
      throw const FormatException('Invalid recovery snapshot.');
    }
    return RecoverySnapshot(
      state: GameState.fromJson(state),
      resumeTokenHashes: hashes.map(
        (key, value) => MapEntry(key, value as String),
      ),
    );
  }
}

abstract interface class GameSnapshotStore {
  Future<RecoverySnapshot?> load();
  Future<void> save(RecoverySnapshot snapshot);
  Future<void> clear();
}

class JsonFileGameSnapshotStore implements GameSnapshotStore {
  JsonFileGameSnapshotStore({this.fileName = 'active_game.json'});

  final String fileName;

  Future<File> _file() async {
    final directory = await getApplicationSupportDirectory();
    final folder = Directory('${directory.path}/munchkin_app');
    if (!folder.existsSync()) await folder.create(recursive: true);
    return File('${folder.path}/$fileName');
  }

  @override
  Future<RecoverySnapshot?> load() async {
    final file = await _file();
    final backup = File('${file.path}.bak');
    final source = file.existsSync() ? file : backup;
    if (!source.existsSync()) return null;
    final decoded = jsonDecode(await source.readAsString());
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Snapshot root must be an object.');
    }
    return RecoverySnapshot.fromJson(decoded);
  }

  @override
  Future<void> save(RecoverySnapshot snapshot) async {
    final file = await _file();
    final temporary = File('${file.path}.tmp');
    final backup = File('${file.path}.bak');
    await temporary.writeAsString(jsonEncode(snapshot.toJson()), flush: true);
    if (backup.existsSync()) await backup.delete();
    if (file.existsSync()) await file.rename(backup.path);
    await temporary.rename(file.path);
    if (backup.existsSync()) await backup.delete();
  }

  @override
  Future<void> clear() async {
    final file = await _file();
    for (final path in <String>[
      file.path,
      '${file.path}.tmp',
      '${file.path}.bak',
    ]) {
      final candidate = File(path);
      if (candidate.existsSync()) await candidate.delete();
    }
  }
}

class MemoryGameSnapshotStore implements GameSnapshotStore {
  RecoverySnapshot? value;

  @override
  Future<void> clear() async => value = null;

  @override
  Future<RecoverySnapshot?> load() async => value;

  @override
  Future<void> save(RecoverySnapshot snapshot) async => value = snapshot;
}
