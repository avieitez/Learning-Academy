import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/mathematics_catalog.dart';
import '../domain/math_operation.dart';
import 'widgets/operation_card.dart';

class OperationSelectionScreen extends StatelessWidget {
  const OperationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF70D8FA), Color(0xFFEAFBFF)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Header(title: l10n.chooseOperation)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 36, 20, 36),
                sliver: SliverGrid.builder(
                  itemCount: MathematicsCatalog.operations.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 360,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 18,
                    childAspectRatio: .88,
                  ),
                  itemBuilder: (context, index) {
                    final operation = MathematicsCatalog.operations[index];
                    return OperationCard(
                      key: ValueKey('${operation.name}-operation'),
                      symbol: operation.symbol,
                      title: _title(l10n, operation),
                      subtitle: _subtitle(l10n, operation),
                      color: _color(operation),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.mathematicsMap,
                        arguments: operation,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _title(AppLocalizations l, MathOperation o) => switch (o) {
    MathOperation.addition => l.addition,
    MathOperation.subtraction => l.subtraction,
    MathOperation.multiplication => l.multiplication,
    MathOperation.division => l.division,
  };
  String _subtitle(AppLocalizations l, MathOperation o) => switch (o) {
    MathOperation.addition => l.additionSubtitle,
    MathOperation.subtraction => l.subtractionSubtitle,
    MathOperation.multiplication => l.multiplicationSubtitle,
    MathOperation.division => l.divisionSubtitle,
  };
  Color _color(MathOperation o) => switch (o) {
    MathOperation.addition => AppColors.green,
    MathOperation.subtraction => const Color(0xFFF04462),
    MathOperation.multiplication => AppColors.orange,
    MathOperation.division => AppColors.blue,
  };
}

class _Header extends StatelessWidget {
  const _Header({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      AspectRatio(
        aspectRatio: 1024 / 465,
        child: Image.asset(
          'assets/images/common/home_characters.png',
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: 8,
        left: 8,
        child: IconButton.filledTonal(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      Transform.translate(
        offset: const Offset(0, 18),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 42),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB229), Color(0xFFF27C12)],
            ),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: const [
              BoxShadow(color: Color(0x55000000), offset: Offset(0, 6)),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    ],
  );
}
