import '../models/kanji_question.dart';

/// 寿司か寿司じゃないかゲームで使う難読漢字のマスターデータ。
///
/// 判定基準は「一般的な寿司屋のお品書きに並ぶネタかどうか」。
/// 海産物でも寿司ネタとして提供されないもの(海月/海驢など)は `isSushi = false`。
class KanjiData {
  KanjiData._();

  /// 寿司ネタ(魚介類) 40問
  static const List<KanjiQuestion> _sushi = [
    KanjiQuestion(kanji: '鮪', reading: 'まぐろ', isSushi: true),
    KanjiQuestion(kanji: '鮭', reading: 'さけ', isSushi: true),
    KanjiQuestion(kanji: '鯛', reading: 'たい', isSushi: true),
    KanjiQuestion(kanji: '鰤', reading: 'ぶり', isSushi: true),
    KanjiQuestion(kanji: '鰹', reading: 'かつお', isSushi: true),
    KanjiQuestion(kanji: '鯖', reading: 'さば', isSushi: true),
    KanjiQuestion(kanji: '鯵', reading: 'あじ', isSushi: true),
    KanjiQuestion(kanji: '鰯', reading: 'いわし', isSushi: true),
    KanjiQuestion(kanji: '鯡', reading: 'にしん', isSushi: true),
    KanjiQuestion(kanji: '鱸', reading: 'すずき', isSushi: true),
    KanjiQuestion(kanji: '鰈', reading: 'かれい', isSushi: true),
    KanjiQuestion(kanji: '鮃', reading: 'ひらめ', isSushi: true),
    KanjiQuestion(kanji: '鱚', reading: 'きす', isSushi: true),
    KanjiQuestion(kanji: '鱒', reading: 'ます', isSushi: true),
    KanjiQuestion(kanji: '鰆', reading: 'さわら', isSushi: true),
    KanjiQuestion(kanji: '鮟鱇', reading: 'あんこう', isSushi: true),
    KanjiQuestion(kanji: '鰻', reading: 'うなぎ', isSushi: true),
    KanjiQuestion(kanji: '穴子', reading: 'あなご', isSushi: true),
    KanjiQuestion(kanji: '烏賊', reading: 'いか', isSushi: true),
    KanjiQuestion(kanji: '蛸', reading: 'たこ', isSushi: true),
    KanjiQuestion(kanji: '海老', reading: 'えび', isSushi: true),
    KanjiQuestion(kanji: '蝦蛄', reading: 'しゃこ', isSushi: true),
    KanjiQuestion(kanji: '雲丹', reading: 'うに', isSushi: true),
    KanjiQuestion(kanji: '鮑', reading: 'あわび', isSushi: true),
    KanjiQuestion(kanji: '海鼠', reading: 'なまこ', isSushi: true),
    KanjiQuestion(kanji: '帆立', reading: 'ほたて', isSushi: true),
    KanjiQuestion(kanji: '栄螺', reading: 'さざえ', isSushi: true),
    KanjiQuestion(kanji: '数の子', reading: 'かずのこ', isSushi: true),
    KanjiQuestion(kanji: '鱧', reading: 'はも', isSushi: true),
    KanjiQuestion(kanji: '鯔', reading: 'ぼら', isSushi: true),
    KanjiQuestion(kanji: '鯏', reading: 'あさり', isSushi: true),
    KanjiQuestion(kanji: '蜆', reading: 'しじみ', isSushi: true),
    KanjiQuestion(kanji: '鮗', reading: 'このしろ', isSushi: true),
    KanjiQuestion(kanji: '鯒', reading: 'こち', isSushi: true),
    KanjiQuestion(kanji: '鰰', reading: 'はたはた', isSushi: true),
    KanjiQuestion(kanji: '鮒', reading: 'ふな', isSushi: true),
    KanjiQuestion(kanji: '公魚', reading: 'わかさぎ', isSushi: true),
    KanjiQuestion(kanji: '飛魚', reading: 'とびうお', isSushi: true),
    KanjiQuestion(kanji: '鱲子', reading: 'からすみ', isSushi: true),
    KanjiQuestion(kanji: '鯣', reading: 'するめ', isSushi: true),
  ];

  /// 寿司じゃない難読漢字 40問
  /// 植物 / 陸生動物 / 海獣(寿司ネタにならない) / 鳥 / 虫 など
  static const List<KanjiQuestion> _notSushi = [
    KanjiQuestion(kanji: '蒲公英', reading: 'たんぽぽ', isSushi: false),
    KanjiQuestion(kanji: '向日葵', reading: 'ひまわり', isSushi: false),
    KanjiQuestion(kanji: '紫陽花', reading: 'あじさい', isSushi: false),
    KanjiQuestion(kanji: '躑躅', reading: 'つつじ', isSushi: false),
    KanjiQuestion(kanji: '薔薇', reading: 'ばら', isSushi: false),
    KanjiQuestion(kanji: '菖蒲', reading: 'あやめ', isSushi: false),
    KanjiQuestion(kanji: '桔梗', reading: 'ききょう', isSushi: false),
    KanjiQuestion(kanji: '撫子', reading: 'なでしこ', isSushi: false),
    KanjiQuestion(kanji: '女郎花', reading: 'おみなえし', isSushi: false),
    KanjiQuestion(kanji: '芙蓉', reading: 'ふよう', isSushi: false),
    KanjiQuestion(kanji: '仙人掌', reading: 'さぼてん', isSushi: false),
    KanjiQuestion(kanji: '罌粟', reading: 'けし', isSushi: false),
    KanjiQuestion(kanji: '鳳仙花', reading: 'ほうせんか', isSushi: false),
    KanjiQuestion(kanji: '木通', reading: 'あけび', isSushi: false),
    KanjiQuestion(kanji: '山茶花', reading: 'さざんか', isSushi: false),
    KanjiQuestion(kanji: '麒麟', reading: 'きりん', isSushi: false),
    KanjiQuestion(kanji: '駱駝', reading: 'らくだ', isSushi: false),
    KanjiQuestion(kanji: '蝙蝠', reading: 'こうもり', isSushi: false),
    KanjiQuestion(kanji: '土竜', reading: 'もぐら', isSushi: false),
    KanjiQuestion(kanji: '河馬', reading: 'かば', isSushi: false),
    KanjiQuestion(kanji: '樹懶', reading: 'なまけもの', isSushi: false),
    KanjiQuestion(kanji: '鼯鼠', reading: 'むささび', isSushi: false),
    KanjiQuestion(kanji: '海驢', reading: 'あしか', isSushi: false),
    KanjiQuestion(kanji: '海豹', reading: 'あざらし', isSushi: false),
    KanjiQuestion(kanji: '海獺', reading: 'らっこ', isSushi: false),
    KanjiQuestion(kanji: '河獺', reading: 'かわうそ', isSushi: false),
    KanjiQuestion(kanji: '駝鳥', reading: 'だちょう', isSushi: false),
    KanjiQuestion(kanji: '縞馬', reading: 'しまうま', isSushi: false),
    KanjiQuestion(kanji: '豪猪', reading: 'やまあらし', isSushi: false),
    KanjiQuestion(kanji: '食蟻獣', reading: 'ありくい', isSushi: false),
    KanjiQuestion(kanji: '啄木鳥', reading: 'きつつき', isSushi: false),
    KanjiQuestion(kanji: '鸚鵡', reading: 'おうむ', isSushi: false),
    KanjiQuestion(kanji: '鶺鴒', reading: 'せきれい', isSushi: false),
    KanjiQuestion(kanji: '蜻蛉', reading: 'とんぼ', isSushi: false),
    KanjiQuestion(kanji: '蟋蟀', reading: 'こおろぎ', isSushi: false),
    KanjiQuestion(kanji: '蜘蛛', reading: 'くも', isSushi: false),
    KanjiQuestion(kanji: '蜥蜴', reading: 'とかげ', isSushi: false),
    KanjiQuestion(kanji: '蟷螂', reading: 'かまきり', isSushi: false),
    KanjiQuestion(kanji: '蝸牛', reading: 'かたつむり', isSushi: false),
    KanjiQuestion(kanji: '鳶', reading: 'とび', isSushi: false),
    // 「魚」がつくけど寿司ネタじゃない引っ掛け
    KanjiQuestion(kanji: '金魚', reading: 'きんぎょ', isSushi: false),
    KanjiQuestion(kanji: '木魚', reading: 'もくぎょ', isSushi: false),
    KanjiQuestion(kanji: '人魚', reading: 'にんぎょ', isSushi: false),
    KanjiQuestion(kanji: '雑魚', reading: 'ざこ', isSushi: false),
    KanjiQuestion(kanji: '山椒魚', reading: 'さんしょううお', isSushi: false),
    KanjiQuestion(kanji: '鯱', reading: 'しゃち', isSushi: false),
  ];

  /// 全問。ゲーム開始時にシャッフルして使う。
  static const List<KanjiQuestion> all = [..._sushi, ..._notSushi];
}
