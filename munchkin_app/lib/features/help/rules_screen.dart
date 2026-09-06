import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../l10n/app_localizations.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sections = <_RuleSection>[
      _RuleSection(
        icon: Icons.emoji_people,
        title: l10n.rulesTurnTitle,
        body: l10n.rulesTurnBody,
      ),
      _RuleSection(
        icon: Icons.shield,
        title: l10n.rulesCombatTitle,
        body: l10n.rulesCombatBody,
      ),
      _RuleSection(
        icon: Icons.volunteer_activism_outlined,
        title: l10n.rulesHelpingTitle,
        body: l10n.rulesHelpingBody,
      ),
      _RuleSection(
        icon: Icons.front_hand,
        title: l10n.rulesInterventionTitle,
        body: l10n.rulesInterventionBody,
      ),
      _RuleSection(
        icon: Icons.directions_run,
        title: l10n.rulesEscapeTitle,
        body: l10n.rulesEscapeBody,
      ),
      _RuleSection(
        icon: Icons.auto_awesome,
        title: l10n.rulesIdentityTitle,
        body: l10n.rulesIdentityBody,
      ),
      _RuleSection(
        icon: Icons.emoji_events,
        title: l10n.rulesWinningTitle,
        body: l10n.rulesWinningBody,
        highlight: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(l10n.rules),
      ),
      body: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: sections.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final section = sections[index];
          final scheme = Theme.of(context).colorScheme;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        section.icon,
                        size: 18,
                        color: section.highlight
                            ? leaderGold(context)
                            : scheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        section.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    section.body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RuleSection {
  const _RuleSection({
    required this.icon,
    required this.title,
    required this.body,
    this.highlight = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool highlight;
}
