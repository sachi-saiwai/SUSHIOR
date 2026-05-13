import 'package:flutter/material.dart';

import '../models/kanji_question.dart';
import '../models/score_entry.dart';
import '../services/local_prefs.dart';
import '../services/score_repository.dart';
import '../theme/app_colors.dart';
import 'game_screen.dart';
import 'title_screen.dart';

class GameOverScreen extends StatefulWidget {
  final String nickname;
  final int score;
  final bool timeUp;
  final KanjiQuestion? missedKanji;

  const GameOverScreen({
    super.key,
    required this.nickname,
    required this.score,
    required this.timeUp,
    this.missedKanji,
  });

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  final _prefs = LocalPrefs();
  final _repo = ScoreRepository.create();

  bool _loading = true;
  bool _isNewBest = false;
  int? _rank;
  List<ScoreEntry> _topScores = const [];

  @override
  void initState() {
    super.initState();
    _submit();
  }

  Future<void> _submit() async {
    final isNewBest = await _prefs.updateBestScore(widget.score);

    int? rank;
    List<ScoreEntry> top = const [];
    if (_repo.available) {
      await _repo.submit(nickname: widget.nickname, score: widget.score);
      rank = await _repo.fetchRank(widget.score);
      top = await _repo.fetchTopScores(limit: 10);
    }

    if (!mounted) return;
    setState(() {
      _isNewBest = isNewBest;
      _rank = rank;
      _topScores = top;
      _loading = false;
    });
  }

  void _retry() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => GameScreen(nickname: widget.nickname),
      ),
    );
  }

  void _backToTitle() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const TitleScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reasonText = widget.timeUp ? 'タイムアップ!' : 'ざんねん!';
    final headerColor =
        widget.timeUp ? AppColors.header : AppColors.sushiYes;
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: headerColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: headerColor.withValues(alpha: 0.28),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    reasonText,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: widget.timeUp
                          ? AppColors.onHeader
                          : AppColors.onChoice,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (widget.missedKanji != null)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.divider.withValues(alpha: 0.55),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        widget.missedKanji!.kanji,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.missedKanji!.reading}・${widget.missedKanji!.isSushi ? "寿司ネタでした" : "寿司じゃありませんでした"}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              _buildScoreCard(),
              const SizedBox(height: 16),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.tealOnSurface,
                        ),
                      )
                    : _buildRanking(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton(
                        onPressed: _backToTitle,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.outline),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'タイトルへ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _retry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryCta,
                          foregroundColor: AppColors.onPrimaryCta,
                          elevation: 2,
                          shadowColor: AppColors.header.withValues(alpha: 0.35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'もう一度',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.45),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Text(
            widget.nickname,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${widget.score}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '問正解',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (_isNewBest)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'ベストスコア更新!',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.accentBest,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (!_loading && _rank != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '現在 $_rank 位',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRanking() {
    if (!_repo.available) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceList,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.divider.withValues(alpha: 0.4),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Firebase が設定されていないため\nランキングは表示できません',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }
    if (_topScores.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceList,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.divider.withValues(alpha: 0.4),
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: const Text(
          'まだランキングがありません',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceList,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.4),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'ランキング TOP 10',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.tealOnSurface,
              ),
            ),
          ),
          Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.7)),
          Expanded(
            child: ListView.builder(
              itemCount: _topScores.length,
              itemBuilder: (context, i) {
                final e = _topScores[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.nickname,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        '${e.score}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealOnSurface,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
