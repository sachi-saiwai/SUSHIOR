import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/score_entry.dart';

/// Firestore `scores` コレクションへのアクセスを担う。
///
/// Firebase が初期化されていない/利用不可の場合は [available] が false になり、
/// `submit` / `fetchTopScores` / `fetchRank` は no-op / 空結果を返す。
class ScoreRepository {
  ScoreRepository._(this._firestore);

  final FirebaseFirestore? _firestore;

  /// Firebase 初期化済みかつ Firestore が利用可能なら本物のリポジトリを返す。
  /// 何かしらの理由で利用不可なら、空動作のリポジトリを返す。
  factory ScoreRepository.create() {
    try {
      final fs = FirebaseFirestore.instance;
      return ScoreRepository._(fs);
    } catch (e, st) {
      debugPrint('[ScoreRepository] FirebaseFirestore.instance failed: $e\n$st');
      return ScoreRepository._(null);
    }
  }

  bool get available => _firestore != null;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore!.collection('scores');

  /// スコアを Firestore に追加し、生成された [ScoreEntry] を返す。
  Future<ScoreEntry?> submit({
    required String nickname,
    required int score,
  }) async {
    if (!available) return null;
    final now = DateTime.now();
    final entry = ScoreEntry(
      nickname: nickname,
      score: score,
      createdAt: now,
    );
    try {
      final ref = await _col.add(entry.toMap());
      return ScoreEntry(
        id: ref.id,
        nickname: nickname,
        score: score,
        createdAt: now,
      );
    } catch (e, st) {
      debugPrint('[ScoreRepository] submit failed: $e\n$st');
      return null;
    }
  }

  /// 上位 [limit] 件をスコア降順で取得する。
  Future<List<ScoreEntry>> fetchTopScores({int limit = 10}) async {
    if (!available) return const [];
    try {
      final snap = await _col
          .orderBy('score', descending: true)
          .limit(limit)
          .get();
      return snap.docs.map(ScoreEntry.fromDoc).toList();
    } catch (e, st) {
      debugPrint('[ScoreRepository] fetchTopScores failed: $e\n$st');
      return const [];
    }
  }

  /// 自分のスコアより高いスコアの件数 + 1 を順位として返す。
  /// 取得失敗時は null。
  Future<int?> fetchRank(int score) async {
    if (!available) return null;
    try {
      final agg = await _col.where('score', isGreaterThan: score).count().get();
      final higherCount = agg.count ?? 0;
      return higherCount + 1;
    } catch (e, st) {
      debugPrint('[ScoreRepository] count aggregation failed, falling back: $e\n$st');
      try {
        final snap = await _col.where('score', isGreaterThan: score).get();
        return snap.docs.length + 1;
      } catch (e2, st2) {
        debugPrint('[ScoreRepository] fetchRank fallback failed: $e2\n$st2');
        return null;
      }
    }
  }
}
