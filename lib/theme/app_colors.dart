import 'package:flutter/material.dart';

/// アプリ全体の配色（寿司・和風トーン）。
abstract final class AppColors {
  static const scaffold = Color(0xFFF5F0E8);
  /// 落ち着いたミントティール（白みのある緑寄り）。
  static const header = Color(0xFF9BC4BC);
  /// パステルヘッダー上の文字色。
  static const onHeader = Color(0xFF2D3D3B);

  static const surfaceMuted = Color(0xFFE8E0D4);
  static const surfaceCard = Color(0xFFEDE6DC);
  static const surfaceList = Color(0xFFE5DDD2);

  static const kanjiPanel = Color(0xFFE6F3EF);
  static const timerBar = Color(0xFFDDD4C8);

  static const textPrimary = Color(0xFF1C1917);
  static const textSecondary = Color(0xFF57534E);

  static const sushiYes = Color(0xFFC94C3D);
  /// くすんだ水色（白みのある青）。
  static const sushiNo = Color(0xFF8BB4C9);
  static const onSushiNo = Color(0xFF2A3F4D);
  static const onChoice = Color(0xFFFFFFFF);

  /// ヘッダーより少しだけ濃いソフトティール（CTA用）。
  static const primaryCta = Color(0xFF86B5AD);
  static const onPrimaryCta = Color(0xFF263330);

  /// ベージュ系カードの上に載せるティール文字（アクセント・強調）。
  static const tealOnSurface = Color(0xFF5C827B);

  static const outline = Color(0xFF9C8F82);
  static const divider = Color(0xFFC4B8A8);

  static const accentBest = Color(0xFFB45309);
}
