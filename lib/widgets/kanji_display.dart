import 'package:flutter/material.dart';

/// 出題中の難読漢字を大きく表示する角丸グレーボックス。
class KanjiDisplay extends StatelessWidget {
  final String kanji;

  const KanjiDisplay({super.key, required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(24),
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
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
