import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../application/session_controller.dart';
import '../../application/statistics_controller.dart';
import '../../core/network/network_protocol.dart';
import '../../data/storage/statistics_store.dart';
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
    final statistics = ref.watch(statisticsControllerProvider).value;
    final profiles = statistics?.profiles ?? const <UserProfile>[];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(l10n.joinRoom),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            if (profiles.isNotEmpty) ...<Widget>[
              Wrap(
                spacing: 8,
                children: profiles
                    .map(
                      (profile) => ChoiceChip(
                        selected: profile.id == statistics?.activeProfileId,
                        label: Text(profile.name),
                        onSelected: (_) {
                          _name.text = profile.name;
                          ref
                              .read(statisticsControllerProvider.notifier)
                              .selectProfile(profile.id);
                        },
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: 8),
            ],
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
              validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? l10n.invalidForm : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _port,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.port),
                    validator: (value) {
                      final port = int.tryParse(value?.trim() ?? '');
                      return port == null || port < 1 || port > 65535
                          ? l10n.invalidForm
                          : null;
                    },
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
                    validator: (value) {
                      if (_scannedInvite?.token.isNotEmpty ?? false) {
                        return null;
                      }
                      return RegExp(r'^\d{6}$').hasMatch(value?.trim() ?? '')
                          ? null
                          : l10n.invalidForm;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _room,
              decoration: InputDecoration(labelText: l10n.roomId),
              validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? l10n.invalidForm : null,
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
    final invite = RoomInvite(
      host: _host.text.trim(),
      port: int.tryParse(_port.text) ?? 0,
      roomId: _room.text.trim(),
      token: _scannedInvite?.token ?? '',
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
