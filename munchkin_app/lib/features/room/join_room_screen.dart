import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../application/session_controller.dart';
import '../../core/network/network_protocol.dart';
import '../../l10n/app_localizations.dart';

class JoinRoomScreen extends ConsumerStatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  ConsumerState<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends ConsumerState<JoinRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _host = TextEditingController();
  final _port = TextEditingController();
  final _room = TextEditingController();
  final _pin = TextEditingController();
  RoomInvite? _scannedInvite;

  @override
  void dispose() {
    for (final controller in <TextEditingController>[
      _name,
      _host,
      _port,
      _room,
      _pin,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.joinRoom)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            TextFormField(
              controller: _name,
              maxLength: 24,
              decoration: InputDecoration(labelText: l10n.yourName),
              validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? '1–24' : null,
            ),
            OutlinedButton.icon(
              onPressed: session.busy ? null : _scan,
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(l10n.scanQr),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.manualJoin,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _host,
              decoration: InputDecoration(labelText: l10n.hostAddress),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _port,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.port),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _pin,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: l10n.pin,
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _room,
              decoration: InputDecoration(labelText: l10n.roomId),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: session.busy ? null : _join,
              child: session.busy
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.joinRoom),
            ),
            if (session.error != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                session.error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _scan() async {
    final invite = await Navigator.of(context).push<RoomInvite>(
      MaterialPageRoute(builder: (context) => const _ScannerScreen()),
    );
    if (invite == null) return;
    setState(() {
      _scannedInvite = invite;
      _host.text = invite.host;
      _port.text = '${invite.port}';
      _room.text = invite.roomId;
    });
  }

  Future<void> _join() async {
    if (!_formKey.currentState!.validate()) return;
    final invite =
        _scannedInvite ??
        RoomInvite(
          host: _host.text.trim(),
          port: int.tryParse(_port.text) ?? 0,
          roomId: _room.text.trim(),
          token: '',
          pin: _pin.text.trim(),
        );
    if (invite.host.isEmpty || invite.port < 1 || invite.roomId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidForm)),
      );
      return;
    }
    try {
      await ref
          .read(sessionControllerProvider.notifier)
          .joinRoom(invite: invite, playerName: _name.text);
      if (mounted) context.go('/room');
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).connectionError)),
        );
      }
    }
  }
}

class _ScannerScreen extends StatefulWidget {
  const _ScannerScreen();

  @override
  State<_ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<_ScannerScreen> {
  var _handled = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppLocalizations.of(context).scanQr)),
    body: MobileScanner(
      onDetect: (capture) {
        if (_handled) return;
        final value = capture.barcodes.firstOrNull?.rawValue;
        if (value == null) return;
        try {
          final invite = RoomInvite.parse(value);
          _handled = true;
          Navigator.of(context).pop(invite);
        } on FormatException {
          return;
        }
      },
    ),
  );
}
