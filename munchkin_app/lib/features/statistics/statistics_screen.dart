import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/statistics_controller.dart';
import '../../data/storage/statistics_store.dart';
import '../../l10n/app_localizations.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final statistics = ref.watch(statisticsControllerProvider);
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
        title: Text(l10n.statistics),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProfile(context, ref),
        icon: const Icon(Icons.person_add_alt_1),
        label: Text(l10n.addProfile),
      ),
      body: statistics.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('${l10n.error}: $error')),
        data: (data) => _StatisticsBody(data: data),
      ),
    );
  }

  Future<void> _createProfile(BuildContext context, WidgetRef ref) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => const _CreateProfileDialog(),
    );
    if (name == null || name.trim().isEmpty) return;
    await ref.read(statisticsControllerProvider.notifier).ensureProfile(name);
  }
}

class _StatisticsBody extends ConsumerWidget {
  const _StatisticsBody({required this.data});

  final StatisticsData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (data.profiles.isEmpty) {
      return Center(child: Text(l10n.noProfiles));
    }
    final active = data.activeProfile ?? data.profiles.first;
    final controller = ref.read(statisticsControllerProvider.notifier);
    final profileStats = controller.statisticsFor(active);
    final history = data.history
        .where((record) => record.localProfileId == active.id)
        .toList(growable: false);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: <Widget>[
        Text(
          l10n.personalProfiles,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: data.profiles
              .map(
                (profile) => ChoiceChip(
                  selected: profile.id == active.id,
                  label: Text(profile.name),
                  onSelected: (_) => controller.selectProfile(profile.id),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 24),
        Text(active.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: MediaQuery.sizeOf(context).width >= 600 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: <Widget>[
            _MetricCard(
              label: l10n.gamesPlayed,
              value: '${profileStats.gamesPlayed}',
            ),
            _MetricCard(label: l10n.wins, value: '${profileStats.wins}'),
            _MetricCard(
              label: l10n.maxLevelReached,
              value: '${profileStats.maxLevel}',
            ),
            _MetricCard(
              label: l10n.averageDuration,
              value: _formatDuration(l10n, profileStats.averageDuration),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(l10n.gameHistory, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (history.isEmpty)
          Text(l10n.noGameHistory)
        else
          ...history.map((record) => _HistoryCard(record: record)),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.record});

  final GameHistoryRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final winners = record.winnerNames;
    final winnerText = winners.isEmpty
        ? l10n.noWinner
        : l10n.winnerNames(winners.join(', '));
    final date = MaterialLocalizations.of(
      context,
    ).formatMediumDate(record.endedAt.toLocal());
    return Card(
      child: ExpansionTile(
        leading: Icon(
          record.localPlayerWon ? Icons.emoji_events : Icons.history,
        ),
        title: Text('$date · ${_formatDuration(l10n, record.duration)}'),
        subtitle: Text(winnerText),
        children: record.participants
            .map(
              (participant) => ListTile(
                dense: true,
                title: Text(participant.name),
                subtitle: Text(
                  '${l10n.level}: ${participant.finalLevel} · '
                  '${l10n.maxLevelReached}: ${participant.peakLevel}',
                ),
                trailing: record.winnerPlayerIds.contains(participant.playerId)
                    ? const Icon(Icons.emoji_events)
                    : null,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _CreateProfileDialog extends StatefulWidget {
  const _CreateProfileDialog();

  @override
  State<_CreateProfileDialog> createState() => _CreateProfileDialogState();
}

class _CreateProfileDialogState extends State<_CreateProfileDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.addProfile),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 24,
        decoration: InputDecoration(labelText: l10n.profileName),
        onSubmitted: _submit,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => _submit(_controller.text),
          child: Text(l10n.save),
        ),
      ],
    );
  }

  void _submit(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty || normalized.length > 24) return;
    Navigator.pop(context, normalized);
  }
}

String _formatDuration(AppLocalizations l10n, Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  if (hours == 0) return l10n.durationMinutes(minutes);
  return l10n.durationHoursMinutes(hours, minutes);
}
