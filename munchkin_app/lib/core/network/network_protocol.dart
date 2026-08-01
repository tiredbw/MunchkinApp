import 'dart:convert';

const int currentProtocolVersion = 1;
const int maxNetworkMessageBytes = 64 * 1024;

class NetworkEnvelope {
  const NetworkEnvelope({
    required this.messageId,
    required this.type,
    required this.roomId,
    required this.payload,
    this.senderId,
    this.expectedRevision,
    this.protocolVersion = currentProtocolVersion,
  });

  final int protocolVersion;
  final String messageId;
  final String type;
  final String roomId;
  final String? senderId;
  final int? expectedRevision;
  final Map<String, Object?> payload;

  Map<String, Object?> toJson() => <String, Object?>{
    'protocolVersion': protocolVersion,
    'messageId': messageId,
    'type': type,
    'roomId': roomId,
    'senderId': senderId,
    'expectedRevision': expectedRevision,
    'sentAt': DateTime.now().toUtc().toIso8601String(),
    'payload': payload,
  };

  String encode() => jsonEncode(toJson());

  factory NetworkEnvelope.decode(String source) {
    if (utf8.encode(source).length > maxNetworkMessageBytes) {
      throw const FormatException('Message is too large.');
    }
    final decoded = jsonDecode(source);
    if (decoded is! Map<String, Object?>) {
      throw const FormatException('Message must be a JSON object.');
    }
    final payload = decoded['payload'];
    if (payload is! Map<String, Object?>) {
      throw const FormatException('Message payload must be an object.');
    }
    return NetworkEnvelope(
      protocolVersion: decoded['protocolVersion'] as int? ?? 0,
      messageId: decoded['messageId'] as String? ?? '',
      type: decoded['type'] as String? ?? '',
      roomId: decoded['roomId'] as String? ?? '',
      senderId: decoded['senderId'] as String?,
      expectedRevision: decoded['expectedRevision'] as int?,
      payload: payload,
    );
  }
}

class RoomInvite {
  const RoomInvite({
    required this.host,
    required this.port,
    required this.roomId,
    required this.token,
    required this.pin,
  });

  final String host;
  final int port;
  final String roomId;
  final String token;
  final String pin;

  Uri toUri() => Uri(
    scheme: 'munchkin',
    host: 'join',
    queryParameters: <String, String>{
      'host': host,
      'port': '$port',
      'room': roomId,
      'token': token,
    },
  );

  factory RoomInvite.parse(String source) {
    final uri = Uri.parse(source);
    if (uri.scheme != 'munchkin' || uri.host != 'join') {
      throw const FormatException('Unsupported invite.');
    }
    final host = uri.queryParameters['host'];
    final port = int.tryParse(uri.queryParameters['port'] ?? '');
    final room = uri.queryParameters['room'];
    final token = uri.queryParameters['token'];
    if (host == null || port == null || room == null || token == null) {
      throw const FormatException('Invite is incomplete.');
    }
    return RoomInvite(
      host: host,
      port: port,
      roomId: room,
      token: token,
      pin: '',
    );
  }

  RoomInvite withManualPin(String value) => RoomInvite(
    host: host,
    port: port,
    roomId: roomId,
    token: token,
    pin: value,
  );
}
