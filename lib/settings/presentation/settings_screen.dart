import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/constants/app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../domain/app_preferences.dart';
import '../domain/mascot.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = AppPreferencesScope.of(context);
    final preferences = controller.value;
    final selectedLanguage = preferences.languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFCBF2FF), AppColors.sky],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 40),
          children: [
            _SettingsSection(
              title: l10n.language,
              icon: Icons.language_rounded,
              child: SegmentedButton<String>(
                key: const ValueKey('settings-language'),
                segments: const [
                  ButtonSegment(value: 'en', label: Text('English')),
                  ButtonSegment(value: 'es', label: Text('Español')),
                  ButtonSegment(value: 'fr', label: Text('Français')),
                ],
                selected: {selectedLanguage},
                onSelectionChanged: (selection) =>
                    controller.setLanguage(selection.first),
                showSelectedIcon: false,
              ),
            ),
            const SizedBox(height: 18),
            _SettingsSection(
              title: l10n.chooseMascot,
              icon: Icons.pets_rounded,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Mascot.values.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .9,
                ),
                itemBuilder: (context, index) {
                  final mascot = Mascot.values[index];
                  return _MascotOption(
                    key: ValueKey('mascot-${mascot.id}'),
                    mascot: mascot,
                    name: _mascotName(l10n, mascot),
                    selected: mascot.id == preferences.mascot.id,
                    onPressed: () => controller.setMascot(mascot),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            _SettingsSection(
              title: l10n.about,
              icon: Icons.info_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.aboutDescription),
                  const SizedBox(height: 12),
                  Text('${l10n.version}: ${AppConstants.version}'),
                  const SizedBox(height: 16),
                  Text(
                    l10n.contactSupport,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  const SelectableText(
                    AppConstants.supportEmail,
                    key: ValueKey('support-email'),
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _SettingsSection(
              title: l10n.resetData,
              icon: Icons.delete_sweep_rounded,
              iconColor: const Color(0xFFD83B4D),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.resetDataDescription),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    key: const ValueKey('reset-app-data'),
                    onPressed: () => _confirmReset(context, controller),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFD83B4D),
                      side: const BorderSide(color: Color(0xFFD83B4D)),
                    ),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: Text(l10n.deleteData),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _mascotName(AppLocalizations l, Mascot mascot) => switch (mascot.id) {
    'owl' => l.owl,
    'fox' => l.fox,
    'panda' => l.panda,
    'lion' => l.lion,
    'bunny' => l.bunny,
    'unicorn' => l.unicorn,
    _ => mascot.id,
  };

  Future<void> _confirmReset(
    BuildContext context,
    AppPreferencesController controller,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.delete_sweep_rounded,
          color: Color(0xFFD83B4D),
          size: 42,
        ),
        title: Text(l10n.resetDataTitle),
        content: Text(l10n.resetDataQuestion),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            key: const ValueKey('confirm-reset-app-data'),
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD83B4D),
            ),
            child: Text(l10n.deleteData),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await controller.resetAll();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).dataDeleted)),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = AppColors.blue,
  });
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x220D5E83),
          blurRadius: 16,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

class _MascotOption extends StatefulWidget {
  const _MascotOption({
    required this.mascot,
    required this.name,
    required this.selected,
    required this.onPressed,
    super.key,
  });
  final Mascot mascot;
  final String name;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<_MascotOption> createState() => _MascotOptionState();
}

class _MascotOptionState extends State<_MascotOption>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _celebrating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
  }

  Future<void> _selectMascot() async {
    if (_controller.isAnimating) return;
    widget.onPressed();
    _controller.stop();
    setState(() => _celebrating = true);
    await _controller.forward(from: 0);
    if (!mounted) return;
    setState(() => _celebrating = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: widget.selected,
    label: widget.name,
    child: InkWell(
      onTap: _selectMascot,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: widget.selected || _celebrating
              ? const Color(0xFFE1F7FF)
              : const Color(0xFFF7FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.selected || _celebrating
                ? AppColors.blue
                : const Color(0xFFDCE8EF),
            width: widget.selected || _celebrating ? 4 : 2,
          ),
          boxShadow: widget.selected || _celebrating
              ? const [
                  BoxShadow(
                    color: Color(0x6632B8F2),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              key: const ValueKey('mascot-selection-animation'),
              animation: _controller,
              builder: (context, child) {
                final value = _controller.value;
                final jump = -22 * sin(value * pi);
                final turn = sin(value * pi * 4) * .16 * (1 - value);
                final scale = 1 + sin(value * pi) * .3;
                final sparkleOpacity = sin(value * pi).clamp(0.0, 1.0);
                return SizedBox(
                  width: 76,
                  height: 62,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        left: 2,
                        child: Opacity(
                          opacity: sparkleOpacity,
                          child: Transform.rotate(
                            angle: value * pi,
                            child: const Text(
                              '✨',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 0,
                        child: Opacity(
                          opacity: sparkleOpacity,
                          child: const Text(
                            '⭐',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Transform.translate(
                        key: const ValueKey('mascot-jump-transform'),
                        offset: Offset(0, jump),
                        child: Transform.rotate(
                          angle: turn,
                          child: Transform.scale(scale: scale, child: child),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                widget.mascot.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            Text(
              widget.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ),
  );
}
