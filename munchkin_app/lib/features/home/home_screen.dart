import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/session_controller.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.casino_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.appTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40),
                  FilledButton.icon(
                    onPressed: session.busy
                        ? null
                        : () => context.go('/create'),
                    icon: const Icon(Icons.add_circle_outline),
                    label: Text(l10n.createRoom),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: session.busy ? null : () => context.go('/join'),
                    icon: const Icon(Icons.login),
                    label: Text(l10n.joinRoom),
                  ),
                  if (session.hasRecovery) ...<Widget>[
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: session.busy
                          ? null
                          : () async {
                              await ref
                                  .read(sessionControllerProvider.notifier)
                                  .restoreRoom();
                              if (context.mounted &&
                                  ref.read(sessionControllerProvider).game !=
                                      null) {
                                context.go('/room');
                              }
                            },
                      icon: const Icon(Icons.restore),
                      label: Text(l10n.restoreGame),
                    ),
                  ],
                  if (session.busy) ...<Widget>[
                    const SizedBox(height: 20),
                    const Center(child: CircularProgressIndicator()),
                  ],
                  if (session.error != null) ...<Widget>[
                    const SizedBox(height: 16),
                    Text(
                      session.error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
