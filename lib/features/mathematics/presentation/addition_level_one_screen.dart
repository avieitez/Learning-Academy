import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/audio/audio_feedback_service.dart';
import '../../../core/audio/audio_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../progress/domain/exercise_session.dart';
import '../../../settings/domain/app_preferences.dart';
import '../data/generators/addition_exercise_generator.dart';
import '../domain/addition_exercise.dart';

class AdditionLevelOneScreen extends StatefulWidget {
  const AdditionLevelOneScreen({this.audioService, super.key});

  final AudioService? audioService;

  @override
  State<AdditionLevelOneScreen> createState() => _AdditionLevelOneScreenState();
}

class _AdditionLevelOneScreenState extends State<AdditionLevelOneScreen> {
  late final List<AdditionExercise> _exercises;
  int _exerciseIndex = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  int? _selectedAnswer;
  bool? _isCorrect;
  bool _answering = false;
  late final AudioService _audioService;
  late final bool _ownsAudioService;
  DateTime _startedAt = DateTime.now();
  bool _sessionChecked = false;
  bool _exiting = false;

  AdditionExercise get _exercise => _exercises[_exerciseIndex];

  @override
  void initState() {
    super.initState();
    _exercises = AdditionExerciseGenerator.levelOne();
    _ownsAudioService = widget.audioService == null;
    _audioService = widget.audioService ?? AudioFeedbackService();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_sessionChecked) return;
    _sessionChecked = true;
    final session = AppPreferencesScope.of(
      context,
    ).value.session('mathematics', 'addition', 1);
    if (session != null && session.exerciseIndex < _exercises.length) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _offerResume(session),
      );
    }
  }

  @override
  void dispose() {
    if (_ownsAudioService) unawaited(_audioService.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mascot = AppPreferencesScope.of(context).value.mascot;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) unawaited(_exitLevel());
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF84DCFA), Color(0xFFE9FAFF)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _ExerciseHeader(
                  title: l10n.additionLevelOne,
                  current: _exerciseIndex + 1,
                  total: _exercises.length,
                  onClose: _exitLevel,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
                    child: Column(
                      children: [
                        Text(
                          l10n.howManyAltogether,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: 18),
                        _VisualAddition(exercise: _exercise),
                        const SizedBox(height: 18),
                        Text(
                          '${_exercise.left} + ${_exercise.right} = ?',
                          key: const ValueKey('addition-question'),
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            for (final answer in _exercise.answers)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: _AnswerButton(
                                    answer: answer,
                                    selectedAnswer: _selectedAnswer,
                                    correctAnswer: _exercise.correctAnswer,
                                    enabled: !_answering,
                                    onPressed: () => _answer(answer),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: _isCorrect == null
                              ? _MascotCoach(
                                  key: const ValueKey('mascot-waiting'),
                                  emoji: mascot.emoji,
                                  message: l10n.chooseAnAnswer,
                                )
                              : _MascotCoach(
                                  key: ValueKey(_isCorrect),
                                  emoji: mascot.emoji,
                                  message: _isCorrect!
                                      ? l10n.correctAnswer
                                      : l10n.keepTrying,
                                  celebrating: _isCorrect!,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _answer(int answer) async {
    if (_answering) return;
    final correct = _exercise.checkAnswer(answer);
    unawaited(
      correct ? _audioService.playCorrect() : _audioService.playIncorrect(),
    );
    setState(() {
      _answering = true;
      _selectedAnswer = answer;
      _isCorrect = correct;
      if (correct) {
        _correctAnswers++;
      } else {
        _incorrectAnswers++;
      }
    });
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    if (_exerciseIndex == _exercises.length - 1) {
      await AppPreferencesScope.of(
        context,
      ).clearSession(area: 'mathematics', activity: 'addition', level: 1);
      await _showResults();
      return;
    }
    final nextIndex = _exerciseIndex + 1;
    await _saveSession(exerciseIndex: nextIndex);
    if (!mounted) return;
    setState(() {
      _exerciseIndex = nextIndex;
      _selectedAnswer = null;
      _isCorrect = null;
      _answering = false;
    });
  }

  Future<void> _offerResume(ExerciseSession session) async {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    final resume = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.orange,
          size: 42,
        ),
        title: Text(l10n.resumeTitle),
        content: Text(
          '${l10n.resumeMessage}\n${session.exerciseIndex + 1}/${_exercises.length}',
        ),
        actions: [
          TextButton(
            key: const ValueKey('restart-session'),
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.startAgain),
          ),
          FilledButton(
            key: const ValueKey('resume-session'),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.continueSession),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (resume == true) {
      setState(() {
        _exerciseIndex = session.exerciseIndex.clamp(0, _exercises.length - 1);
        _correctAnswers = session.correctAnswers;
        _incorrectAnswers = session.incorrectAnswers;
        _startedAt = session.startedAt;
      });
    } else {
      await AppPreferencesScope.of(
        context,
      ).clearSession(area: 'mathematics', activity: 'addition', level: 1);
    }
  }

  Future<void> _saveSession({int? exerciseIndex}) =>
      AppPreferencesScope.of(context).saveSession(
        ExerciseSession(
          area: 'mathematics',
          activity: 'addition',
          level: 1,
          exerciseIndex: exerciseIndex ?? _exerciseIndex,
          correctAnswers: _correctAnswers,
          incorrectAnswers: _incorrectAnswers,
          startedAt: _startedAt,
        ),
      );

  Future<void> _exitLevel() async {
    if (_exiting || !mounted) return;
    _exiting = true;
    await _saveSession();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _showResults() async {
    final l10n = AppLocalizations.of(context);
    final passed = _correctAnswers >= 7;
    if (passed) {
      await AppPreferencesScope.of(
        context,
      ).unlockLevel(area: 'mathematics', activity: 'addition', level: 2);
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Text(passed ? '🏆' : '💪', style: const TextStyle(fontSize: 58)),
        title: Text(
          passed ? l10n.greatJob : l10n.goodTry,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_correctAnswers / ${_exercises.length}',
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Text(passed ? '⭐⭐⭐' : '⭐', style: const TextStyle(fontSize: 30)),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            key: const ValueKey('return-to-map'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(l10n.returnToMap),
          ),
        ],
      ),
    );
  }
}

class _ExerciseHeader extends StatelessWidget {
  const _ExerciseHeader({
    required this.title,
    required this.current,
    required this.total,
    required this.onClose,
  });
  final String title;
  final int current;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(10, 8, 16, 6),
    child: Row(
      children: [
        IconButton.filledTonal(
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: current / total,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
                color: AppColors.green,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$current/$total',
          style: const TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    ),
  );
}

class _VisualAddition extends StatelessWidget {
  const _VisualAddition({required this.exercise});
  final AdditionExercise exercise;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: Color(0x220C5D82),
          blurRadius: 16,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(child: _ObjectGroup(count: exercise.left)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '+',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 42,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(child: _ObjectGroup(count: exercise.right)),
      ],
    ),
  );
}

class _ObjectGroup extends StatelessWidget {
  const _ObjectGroup({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center,
    spacing: 2,
    runSpacing: 2,
    children: List.generate(
      count,
      (index) => const Text('🍎', style: TextStyle(fontSize: 34)),
    ),
  );
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.answer,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.enabled,
    required this.onPressed,
  });
  final int answer;
  final int? selectedAnswer;
  final int correctAnswer;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final selected = selectedAnswer == answer;
    final showCorrect = selectedAnswer != null && answer == correctAnswer;
    final color = showCorrect
        ? AppColors.green
        : selected
        ? const Color(0xFFF04462)
        : AppColors.blue;
    return SizedBox(
      height: 78,
      child: FilledButton(
        key: ValueKey('answer-$answer'),
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Colors.white, width: 4),
          ),
        ),
        child: Text(
          '$answer',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _MascotCoach extends StatelessWidget {
  const _MascotCoach({
    required this.emoji,
    required this.message,
    this.celebrating = false,
    super.key,
  });
  final String emoji;
  final String message;
  final bool celebrating;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TweenAnimationBuilder<double>(
        tween: Tween(begin: celebrating ? .7 : 1, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        builder: (context, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Text(emoji, style: const TextStyle(fontSize: 54)),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    ],
  );
}
