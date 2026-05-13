import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// 出題中の難読漢字を大きく表示する角丸パネル。
class KanjiDisplay extends StatelessWidget {
  final String kanji;

  const KanjiDisplay({super.key, required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kanjiPanel,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              kanji,
              style: const TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
