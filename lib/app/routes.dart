import 'package:flutter/material.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/mathematics/domain/math_operation.dart';
import '../features/mathematics/presentation/addition_level_one_screen.dart';
import '../features/mathematics/presentation/level_map_screen.dart';
import '../features/mathematics/presentation/operation_selection_screen.dart';
import '../features/shared/presentation/feature_placeholder_screen.dart';
import '../settings/presentation/settings_screen.dart';

enum LearningFeature { mathematics, romanNumbers, clock }

abstract final class AppRoutes {
  static const home = '/';
  static const mathematics = '/mathematics';
  static const mathematicsMap = '/mathematics/map';
  static const mathematicsExercise = '/mathematics/exercise';
  static const romanNumbers = '/roman-numbers';
  static const clock = '/clock';
  static const settings = '/settings';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    if (settings.name == home) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    }
    if (settings.name == AppRoutes.settings) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const SettingsScreen(),
      );
    }

    if (settings.name == mathematics) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const OperationSelectionScreen(),
      );
    }
    if (settings.name == mathematicsMap &&
        settings.arguments is MathOperation) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) =>
            LevelMapScreen(operation: settings.arguments! as MathOperation),
      );
    }
    if (settings.name == mathematicsExercise) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const AdditionLevelOneScreen(),
      );
    }

    final feature = switch (settings.name) {
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
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }
}
