import 'package:flutter_test/flutter_test.dart';
import 'package:munchkin_app/core/network/network_protocol.dart';

void main() {
  test('network envelope round trips required fields', () {
    const envelope = NetworkEnvelope(
      messageId: 'message',
      type: 'command',
      roomId: 'room',
      senderId: 'player',
      expectedRevision: 4,
      payload: <String, Object?>{'value': 5},
    );

    final decoded = NetworkEnvelope.decode(envelope.encode());
    expect(decoded.protocolVersion, currentProtocolVersion);
    expect(decoded.messageId, 'message');
    expect(decoded.senderId, 'player');
    expect(decoded.expectedRevision, 4);
    expect(decoded.payload['value'], 5);
  });

  test('invite round trips through QR URI', () {
    const invite = RoomInvite(
      host: '192.168.1.42',
      port: 8787,
      roomId: 'room',
      token: 'secret',
      pin: '123456',
    );
    final parsed = RoomInvite.parse(invite.toUri().toString());
    expect(parsed.host, invite.host);
    expect(parsed.port, invite.port);
    expect(parsed.roomId, invite.roomId);
    expect(parsed.token, invite.token);
  });

  test('rejects malformed and oversized messages', () {
    expect(() => NetworkEnvelope.decode('[]'), throwsFormatException);
    final huge = 'x' * maxNetworkMessageBytes;
    expect(() => NetworkEnvelope.decode(huge), throwsFormatException);
  });
}
