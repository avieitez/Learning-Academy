import 'package:flutter/material.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/shared/presentation/feature_placeholder_screen.dart';

enum LearningFeature { mathematics, romanNumbers, clock }

abstract final class AppRoutes {
  static const home = '/';
  static const mathematics = '/mathematics';
  static const romanNumbers = '/roman-numbers';
  static const clock = '/clock';

  static Route<void> onGenerateRoute(
    RouteSettings settings, {
    required ValueChanged<Locale?> onLocaleChanged,
  }) {
    if (settings.name == home) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => HomeScreen(onLocaleChanged: onLocaleChanged),
      );
    }

    final feature = switch (settings.name) {
      mathematics => LearningFeature.mathematics,
      romanNumbers => LearningFeature.romanNumbers,
      clock => LearningFeature.clock,
      _ => null,
    };
    if (feature != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => FeaturePlaceholderScreen(feature: feature),
      );
    }
    return MaterialPageRoute<void>(
      builder: (_) => HomeScreen(onLocaleChanged: onLocaleChanged),
    );
  }
}
