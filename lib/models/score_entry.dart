import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreEntry {
  final String? id;
  final String nickname;
  final int score;
  final DateTime createdAt;

  const ScoreEntry({
    this.id,
    required this.nickname,
    required this.score,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'score': score,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory ScoreEntry.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    final ts = data['createdAt'];
    return ScoreEntry(
      id: doc.id,
      nickname: (data['nickname'] as String?) ?? '',
      score: (data['score'] as num?)?.toInt() ?? 0,
      createdAt: ts is Timestamp ? ts.toDate() : DateTime.now(),
    );
  }
}
