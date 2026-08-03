import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/network/network_protocol.dart';

class SavedClientSession {
  const SavedClientSession({
    required this.invite,
    required this.playerName,
    this.profileId,
    this.localProfiles = const <SavedLocalProfile>[],
  });

  final RoomInvite invite;
  final String playerName;
  final String? profileId;
  final List<SavedLocalProfile> localProfiles;

  Map<String, Object?> toJson() => <String, Object?>{
    'invite': invite.toJson(),
    'playerName': playerName,
    'profileId': profileId,
    'localProfiles': localProfiles.map((value) => value.toJson()).toList(),
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
      localProfiles: (json['localProfiles'] as List<Object?>? ?? const [])
          .whereType<Map<String, Object?>>()
          .map(SavedLocalProfile.fromJson)
          .toList(growable: false),
    );
  }
}

class SavedLocalProfile {
  const SavedLocalProfile({
    required this.playerId,
    required this.name,
    required this.profileId,
  });

  final String playerId;
  final String name;
  final String profileId;

  Map<String, Object?> toJson() => <String, Object?>{
    'playerId': playerId,
    'name': name,
    'profileId': profileId,
  };

  factory SavedLocalProfile.fromJson(Map<String, Object?> json) =>
      SavedLocalProfile(
        playerId: json['playerId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        profileId: json['profileId'] as String? ?? '',
      );
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
