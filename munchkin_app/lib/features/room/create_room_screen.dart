import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../domain/models/game_models.dart';
import '../../l10n/app_localizations.dart';

class CreateRoomScreen extends ConsumerStatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  ConsumerState<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends ConsumerState<CreateRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _minLevel = TextEditingController(text: '1');
  final _maxLevel = TextEditingController(text: '10');
  final _initialLevel = TextEditingController(text: '1');
  final _minStrength = TextEditingController(text: '-99');
  final _maxStrength = TextEditingController(text: '99');
  final _initialStrength = TextEditingController(text: '0');
  var _diceMode = DiceMode.virtual;
  var _countdown = 5.0;
  var _trackRaceClass = true;

  @override
  void dispose() {
    for (final controller in <TextEditingController>[
      _name,
      _minLevel,
      _maxLevel,
      _initialLevel,
      _minStrength,
      _maxStrength,
      _initialStrength,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final busy = ref.watch(
      sessionControllerProvider.select((value) => value.busy),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(l10n.createRoom),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: <Widget>[
            TextFormField(
              controller: _name,
              maxLength: 24,
              decoration: InputDecoration(
                labelText: l10n.yourName,
                prefixIcon: const Icon(Icons.badge_outlined),
              ),
              validator: _validateName,
            ),
            const SizedBox(height: AppSpacing.md),
            _SectionCard(
              icon: Icons.tune,
              title: l10n.settings,
              children: <Widget>[
                SegmentedButton<DiceMode>(
                  segments: <ButtonSegment<DiceMode>>[
                    ButtonSegment(
                      value: DiceMode.virtual,
                      label: Text(l10n.virtualDice),
                      icon: const Icon(Icons.casino),
                    ),
                    ButtonSegment(
                      value: DiceMode.physical,
                      label: Text(l10n.realDice),
                      icon: const Icon(Icons.casino_outlined),
                    ),
                  ],
                  selected: <DiceMode>{_diceMode},
                  onSelectionChanged: (value) =>
                      setState(() => _diceMode = value.single),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.trackRaceClass),
                  value: _trackRaceClass,
                  onChanged: (value) => setState(() => _trackRaceClass = value),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _SectionCard(
              icon: Icons.military_tech,
              title: l10n.level,
              children: <Widget>[
                _NumberRow(
                  controllers: <TextEditingController>[
                    _minLevel,
                    _initialLevel,
                    _maxLevel,
                  ],
                  labels: <String>[l10n.minimum, l10n.initial, l10n.maximum],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _SectionCard(
              icon: Icons.fitness_center,
              title: l10n.strength,
              children: <Widget>[
                _NumberRow(
                  controllers: <TextEditingController>[
                    _minStrength,
                    _initialStrength,
                    _maxStrength,
                  ],
                  labels: <String>[l10n.minimum, l10n.initial, l10n.maximum],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _SectionCard(
              icon: Icons.timer_outlined,
              title: '${l10n.countdownSeconds}: ${_countdown.round()}',
              children: <Widget>[
                Slider(
                  min: 3,
                  max: 60,
                  divisions: 57,
                  value: _countdown,
                  label: '${_countdown.round()}',
                  onChanged: (value) => setState(() => _countdown = value),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: busy ? null : _submit,
              child: busy
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.createRoom),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    final normalized = value?.trim() ?? '';
    return normalized.isEmpty || normalized.length > 24 ? '1–24' : null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final settings = RoomSettings(
      diceMode: _diceMode,
      minLevel: int.parse(_minLevel.text),
      initialLevel: int.parse(_initialLevel.text),
      maxLevel: int.parse(_maxLevel.text),
      minStrength: int.parse(_minStrength.text),
      initialStrength: int.parse(_initialStrength.text),
      maxStrength: int.parse(_maxStrength.text),
      victoryCountdownSeconds: _countdown.round(),
      trackRaceClass: _trackRaceClass,
    );
    if (!(settings.minLevel >= 1 &&
        settings.minLevel <= settings.initialLevel &&
        settings.initialLevel <= settings.maxLevel &&
        settings.maxLevel <= 999 &&
        settings.minStrength >= -999 &&
        settings.minStrength <= settings.initialStrength &&
        settings.initialStrength <= settings.maxStrength &&
        settings.maxStrength <= 999)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).invalidForm)),
      );
      return;
    }
    try {
      await ref
          .read(sessionControllerProvider.notifier)
          .createRoom(hostName: _name.text, settings: settings);
      if (mounted) context.go('/room');
    } on Object {
      if (mounted) {
        final message =
            ref.read(sessionControllerProvider).error ??
            AppLocalizations.of(context).error;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 18, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _NumberRow extends StatelessWidget {
  const _NumberRow({required this.controllers, required this.labels});

  final List<TextEditingController> controllers;
  final List<String> labels;

  @override
  Widget build(BuildContext context) => Row(
    children: List<Widget>.generate(controllers.length, (index) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            right: index == controllers.length - 1 ? 0 : 8,
          ),
          child: TextFormField(
            controller: controllers[index],
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            decoration: InputDecoration(labelText: labels[index]),
            validator: (value) =>
                int.tryParse(value ?? '') == null ? '#' : null,
          ),
        ),
      );
    }),
  );
}
