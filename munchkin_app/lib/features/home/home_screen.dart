import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../application/session_controller.dart';
import '../../l10n/app_localizations.dart';
import '../ads/home_banner_ad.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              scheme.primaryContainer.withValues(alpha: 0.35),
              scheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                color: scheme.primary,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.xl,
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: scheme.primary.withValues(
                                      alpha: 0.35,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.casino_rounded,
                                size: 56,
                                color: scheme.onPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            l10n.appTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.homeTagline,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          FilledButton.icon(
                            onPressed: session.busy
                                ? null
                                : () => context.go('/create'),
                            icon: const Icon(Icons.add_circle_outline),
                            label: Text(l10n.createRoom),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          OutlinedButton.icon(
                            onPressed: session.busy
                                ? null
                                : () => context.go('/join'),
                            icon: const Icon(Icons.login),
                            label: Text(l10n.joinRoom),
                          ),
                          if (session.hasRecovery) ...<Widget>[
                            const SizedBox(height: AppSpacing.sm),
                            TextButton.icon(
                              onPressed: session.busy
                                  ? null
                                  : () async {
                                      await ref
                                          .read(
                                            sessionControllerProvider.notifier,
                                          )
                                          .restoreRoom();
                                      if (context.mounted &&
                                          ref
                                                  .read(
                                                    sessionControllerProvider,
                                                  )
                                                  .game !=
                                              null) {
                                        context.go('/room');
                                      }
                                    },
                              icon: const Icon(Icons.restore),
                              label: Text(l10n.restoreGame),
                            ),
                          ],
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: session.busy
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      top: AppSpacing.lg,
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          if (session.error != null) ...<Widget>[
                            const SizedBox(height: AppSpacing.md),
                            Container(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: scheme.errorContainer,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                              ),
                              child: Text(
                                session.error!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: scheme.onErrorContainer,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const HomeBannerAd(),
            ],
          ),
        ),
      ),
    );
  }
}
