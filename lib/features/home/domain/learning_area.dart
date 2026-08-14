import 'package:flutter/material.dart';

class LearningArea {
  const LearningArea({
    required this.id,
    required this.route,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.enabled = true,
  });

  final String id;
  final String? route;
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool enabled;
}
