import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/session_controller.dart';
import '../../application/statistics_controller.dart';
import '../../data/storage/statistics_store.dart';
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
  final List<TextEditingController> _localPlayerNames =
      <TextEditingController>[];
  var _diceMode = DiceMode.virtual;
  var _countdown = 5.0;

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
      ..._localPlayerNames,
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
        title: Text(l10n.createRoom),
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
              validator: _validateName,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.localPlayers,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(l10n.localPlayersHint),
            const SizedBox(height: 8),
            for (var index = 0; index < _localPlayerNames.length; index++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      key: ValueKey(_localPlayerNames[index]),
                      controller: _localPlayerNames[index],
                      maxLength: 24,
                      decoration: InputDecoration(labelText: l10n.yourName),
                      validator: (value) => _validateLocalName(value, index),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.removePlayer,
                    onPressed: () => _removeLocalPlayer(index),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: _localPlayerNames.length >= 11
                    ? null
                    : _addLocalPlayer,
                icon: const Icon(Icons.person_add_alt_1),
                label: Text(l10n.addLocalPlayer),
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.settings, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
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
            const SizedBox(height: 24),
            Text(
              '${l10n.level}:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _NumberRow(
              controllers: <TextEditingController>[
                _minLevel,
                _initialLevel,
                _maxLevel,
              ],
              labels: <String>[l10n.minimum, l10n.initial, l10n.maximum],
            ),
            const SizedBox(height: 20),
            Text(
              '${l10n.strength}:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _NumberRow(
              controllers: <TextEditingController>[
                _minStrength,
                _initialStrength,
                _maxStrength,
              ],
              labels: <String>[l10n.minimum, l10n.initial, l10n.maximum],
            ),
            const SizedBox(height: 24),
            Text('${l10n.countdownSeconds}: ${_countdown.round()}'),
            Slider(
              min: 3,
              max: 60,
              divisions: 57,
              value: _countdown,
              label: '${_countdown.round()}',
              onChanged: (value) => setState(() => _countdown = value),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: busy ? null : _submit,
              child: busy
                  ? const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.createRoom),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty || normalized.length > 24) return '1–24';
    final duplicate = _localPlayerNames.any(
      (controller) =>
          controller.text.trim().toLowerCase() == normalized.toLowerCase(),
    );
    return duplicate ? AppLocalizations.of(context).duplicatePlayerName : null;
  }

  String? _validateLocalName(String? value, int index) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty || normalized.length > 24) return '1–24';
    final key = normalized.toLowerCase();
    if (_name.text.trim().toLowerCase() == key ||
        _localPlayerNames.indexed.any(
          (entry) =>
              entry.$1 != index && entry.$2.text.trim().toLowerCase() == key,
        )) {
      return AppLocalizations.of(context).duplicatePlayerName;
    }
    return null;
  }

  void _addLocalPlayer() {
    setState(() => _localPlayerNames.add(TextEditingController()));
  }

  void _removeLocalPlayer(int index) {
    late final TextEditingController controller;
    setState(() => controller = _localPlayerNames.removeAt(index));
    controller.dispose();
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
          .createRoom(
            hostName: _name.text.trim(),
            settings: settings,
            localPlayerNames: _localPlayerNames
                .map((controller) => controller.text.trim())
                .toList(growable: false),
          );
      if (mounted) context.go('/room');
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).error)),
        );
      }
    }
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
