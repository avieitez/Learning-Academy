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
    final selectedLanguage =
        preferences.languageCode ??
        Localizations.localeOf(context).languageCode;
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
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Widget child;
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
            Icon(icon, color: AppColors.blue),
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

class _MascotOption extends StatelessWidget {
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
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: name,
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE1F7FF) : const Color(0xFFF7FAFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.blue : const Color(0xFFDCE8EF),
            width: selected ? 4 : 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mascot.emoji, style: const TextStyle(fontSize: 40)),
            Text(
              name,
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
