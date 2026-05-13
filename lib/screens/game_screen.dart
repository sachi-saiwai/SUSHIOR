import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../data/kanji_data.dart';
import '../theme/app_colors.dart';
import '../models/kanji_question.dart';
import '../widgets/answer_button.dart';
import '../widgets/kanji_display.dart';
import '../widgets/timer_bar.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  final String nickname;
  const GameScreen({super.key, required this.nickname});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _gameDuration = Duration(seconds: 60);
  static const _tick = Duration(milliseconds: 100);

  late final List<KanjiQuestion> _queue;
  int _index = 0;
  int _score = 0;
  Duration _remaining = _gameDuration;
  Timer? _timer;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _queue = [...KanjiData.all]..shuffle(Random());
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) {
      if (!mounted) return;
      setState(() {
        _remaining -= _tick;
        if (_remaining.inMilliseconds <= 0) {
          _remaining = Duration.zero;
          _endGame(timeUp: true);
        }
      });
    });
  }

  KanjiQuestion get _current {
    if (_index >= _queue.length) {
      _queue.shuffle(Random());
      _index = 0;
    }
    return _queue[_index];
  }

  void _answer(bool answerSushi) {
    if (_finished) return;
    final correct = _current.isSushi == answerSushi;
    if (!correct) {
      _endGame(timeUp: false, missed: _current);
      return;
    }
    setState(() {
      _score += 1;
      _index += 1;
    });
  }

  void _endGame({required bool timeUp, KanjiQuestion? missed}) {
    if (_finished) return;
    _finished = true;
    _timer?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => GameOverScreen(
            nickname: widget.nickname,
            score: _score,
            timeUp: timeUp,
            missedKanji: missed,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.header,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.header.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 16),
                    const Text(
                      '寿司か寿司じゃないか',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onHeader,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        '$_score 問',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onHeader.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 140,
                child: Row(
                  children: [
                    Expanded(
                      child: AnswerButton(
                        label: '寿司',
                        onPressed: () => _answer(true),
                        backgroundColor: AppColors.sushiYes,
                        foregroundColor: AppColors.onChoice,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AnswerButton(
                        label: '寿司じゃない',
                        onPressed: () => _answer(false),
                        backgroundColor: AppColors.sushiNo,
                        foregroundColor: AppColors.onSushiNo,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TimerBar(remaining: _remaining),
              const SizedBox(height: 16),
              Expanded(
                child: KanjiDisplay(kanji: _current.kanji),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
