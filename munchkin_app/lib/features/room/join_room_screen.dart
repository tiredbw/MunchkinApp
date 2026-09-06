import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../app/theme.dart';
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(l10n.joinRoom),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: <Widget>[
            if (profiles.isNotEmpty) ...<Widget>[
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: profiles
                    .map(
                      (profile) => ChoiceChip(
                        selected: profile.id == statistics?.activeProfileId,
                        label: Text(profile.name),
                        onSelected: (_) {
                          setState(() => _name.text = profile.name);
                          ref
                              .read(statisticsControllerProvider.notifier)
                              .selectProfile(profile.id);
                        },
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            TextFormField(
              controller: _name,
              maxLength: 24,
              decoration: InputDecoration(
                labelText: l10n.yourName,
                prefixIcon: const Icon(Icons.badge_outlined),
              ),
              validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? '1–24' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: session.busy ? null : _scan,
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(l10n.scanQr),
            ),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.edit_note,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.manualJoin,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _host,
                      decoration: InputDecoration(
                        labelText: l10n.hostAddress,
                        prefixIcon: const Icon(Icons.dns_outlined),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _port,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: l10n.port),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: TextFormField(
                            controller: _pin,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: InputDecoration(
                              labelText: l10n.pin,
                              counterText: '',
                              prefixIcon: const Icon(Icons.password),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _room,
                      decoration: InputDecoration(
                        labelText: l10n.roomId,
                        prefixIcon: const Icon(Icons.meeting_room_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
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
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  session.error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
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
      if (invite.pin.isNotEmpty) _pin.text = invite.pin;
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
      // session.error is set by joinRoom() and rendered inline above.
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
    appBar: AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      title: Text(AppLocalizations.of(context).scanQr),
    ),
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        MobileScanner(
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
        IgnorePointer(
          child: Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
