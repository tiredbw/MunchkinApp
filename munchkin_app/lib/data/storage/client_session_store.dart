import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/network_protocol.dart';

class SavedClientSession {
  const SavedClientSession({
    required this.invite,
    required this.playerName,
    this.profileId,
  });

  final RoomInvite invite;
  final String playerName;
  final String? profileId;

  Map<String, Object?> toJson() => <String, Object?>{
    'invite': invite.toJson(),
    'playerName': playerName,
    'profileId': profileId,
  };

  factory SavedClientSession.fromJson(Map<String, Object?> json) {
    final invite = json['invite'];
    if (invite is! Map<String, Object?>) {
      throw const FormatException('Invalid saved client session.');
    }
    return SavedClientSession(
      invite: RoomInvite.fromJson(invite),
      playerName: json['playerName'] as String? ?? '',
      profileId: json['profileId'] as String?,
    );
  }
}

class ClientSessionStore {
  ClientSessionStore({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const _key = 'activeClientSession';
  final FlutterSecureStorage _secureStorage;

  Future<SavedClientSession?> load() async {
    final source = await _secureStorage.read(key: _key);
    if (source == null) return null;
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Invalid saved client session.');
    }
    return SavedClientSession.fromJson(decoded);
  }

  Future<void> save(SavedClientSession session) =>
      _secureStorage.write(key: _key, value: jsonEncode(session.toJson()));

  Future<void> clear() => _secureStorage.delete(key: _key);
}
