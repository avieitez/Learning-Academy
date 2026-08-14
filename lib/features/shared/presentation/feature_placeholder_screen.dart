import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../app/routes.dart';
import '../../../l10n/app_localizations.dart';

class FeaturePlaceholderScreen extends StatelessWidget {
  const FeaturePlaceholderScreen({required this.feature, super.key});

  final LearningFeature feature;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final icon = switch (feature) {
      LearningFeature.mathematics => Icons.calculate_rounded,
      LearningFeature.romanNumbers => Icons.account_balance_rounded,
      LearningFeature.clock => Icons.access_time_filled_rounded,
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_title(localizations)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 72, color: AppColors.blue),
              ),
              const SizedBox(height: 24),
              Text(
                _title(localizations),
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                localizations.featureReady,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: Text(localizations.back),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _title(AppLocalizations localizations) => switch (feature) {
    LearningFeature.mathematics => localizations.mathematics,
    LearningFeature.romanNumbers => localizations.romanNumbers,
    LearningFeature.clock => localizations.clock,
  };
}
