import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// 残り時間 (`残り00:SS`) を表示する角丸バー。
class TimerBar extends StatelessWidget {
  final Duration remaining;

  const TimerBar({super.key, required this.remaining});

  @override
  Widget build(BuildContext context) {
    final totalSeconds = remaining.inMilliseconds <= 0
        ? 0
        : (remaining.inMilliseconds / 1000).ceil();
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    final urgent = totalSeconds <= 10 && totalSeconds > 0;
    return Container(
      decoration: BoxDecoration(
        color: urgent
            ? const Color(0xFFFFE4D6)
            : AppColors.timerBar,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: urgent
              ? AppColors.sushiYes.withValues(alpha: 0.45)
              : AppColors.divider.withValues(alpha: 0.4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '残り',
            style: TextStyle(
              fontSize: 12,
              color: urgent ? AppColors.sushiYes : AppColors.textSecondary,
              fontWeight: urgent ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$minutes:$seconds',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: urgent ? AppColors.sushiYes : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
