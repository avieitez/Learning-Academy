import 'package:flutter/material.dart';

import '../../../ads/banner_ad_widget.dart';
import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/widgets/learning_area_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/learning_area.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onLocaleChanged, super.key});

  final ValueChanged<Locale?> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final areas = _learningAreas(localizations);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6FD5F7), AppColors.sky],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _HomeHeader(
                        localizations: localizations,
                        onLocaleChanged: onLocaleChanged,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(18, 6, 18, 32),
                      sliver: SliverGrid.builder(
                        itemCount: areas.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 360,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 18,
                              childAspectRatio: .92,
                            ),
                        itemBuilder: (context, index) {
                          final area = areas[index];
                          return LearningAreaCard(
                            key: ValueKey('${area.id}-card'),
                            title: area.title,
                            subtitle: area.subtitle,
                            color: area.color,
                            icon: area.icon,
                            onPressed: area.enabled && area.route != null
                                ? () =>
                                      Navigator.pushNamed(context, area.route!)
                                : null,
                          );
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 140)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
                child: BannerAdWidget(label: localizations.adSpace),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<LearningArea> _learningAreas(AppLocalizations localizations) => [
    LearningArea(
      id: 'mathematics',
      route: AppRoutes.mathematics,
      color: AppColors.orange,
      icon: Icons.calculate_rounded,
      title: localizations.mathematics,
      subtitle: localizations.mathematicsSubtitle,
    ),
    LearningArea(
      id: 'roman-numbers',
      route: AppRoutes.romanNumbers,
      color: AppColors.purple,
      icon: Icons.account_balance_rounded,
      title: localizations.romanNumbers,
      subtitle: localizations.romanNumbersSubtitle,
    ),
    LearningArea(
      id: 'clock',
      route: AppRoutes.clock,
      color: AppColors.green,
      icon: Icons.access_time_filled_rounded,
      title: localizations.clock,
      subtitle: localizations.clockSubtitle,
    ),
    LearningArea(
      id: 'coming-soon',
      route: null,
      color: AppColors.blue,
      icon: Icons.question_mark_rounded,
      title: localizations.comingSoon,
      subtitle: localizations.comingSoonSubtitle,
      enabled: false,
    ),
  ];
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.localizations,
    required this.onLocaleChanged,
  });

  final AppLocalizations localizations;
  final ValueChanged<Locale?> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 1024 / 465,
              child: Image.asset(
                'assets/images/common/home_characters.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Material(
                color: Colors.white.withValues(alpha: .95),
                elevation: 4,
                shape: const CircleBorder(),
                child: PopupMenuButton<Locale?>(
                  key: const ValueKey('language-selector'),
                  tooltip: localizations.selectLanguage,
                  icon: const Icon(
                    Icons.language_rounded,
                    color: AppColors.ink,
                  ),
                  onSelected: onLocaleChanged,
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: null, child: Text('Automatic')),
                    PopupMenuItem(value: Locale('en'), child: Text('English')),
                    PopupMenuItem(value: Locale('es'), child: Text('Español')),
                    PopupMenuItem(value: Locale('fr'), child: Text('Français')),
                  ],
                ),
              ),
            ),
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x260D638D),
                  blurRadius: 18,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Text(
              localizations.appTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 34,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
          child: Text(
            localizations.tagline,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
