import 'package:shared_preferences/shared_preferences.dart';

/// 端末ローカルにベストスコアと前回のニックネームを保存する。
class LocalPrefs {
  static const _kBestScore = 'best_score';
  static const _kNickname = 'last_nickname';

  Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kBestScore) ?? 0;
  }

  /// 新しいスコアがベストを更新したら保存し、true を返す。
  Future<bool> updateBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_kBestScore) ?? 0;
    if (score > current) {
      await prefs.setInt(_kBestScore, score);
      return true;
    }
    return false;
  }

  Future<String?> getLastNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kNickname);
  }

  Future<void> setLastNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kNickname, nickname);
  }
}
