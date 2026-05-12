# sushior — 寿司か寿司じゃないか

難読漢字を「寿司ネタかどうか」でタップ判別するFlutterゲーム。

## ゲームルール

- 難読漢字が次々に表示され、「寿司」「寿司じゃない」の2択でタップ
- 制限時間は60秒
- 1問でも間違えるとゲームオーバー
- ニックネームと最終スコアはFirebase Firestoreに保存され、ランキングが表示される

## セットアップ

### 1. パッケージインストール

```bash
flutter pub get
```

### 2. Firebase プロジェクトのセットアップ

ランキング機能を使うには Firebase の設定が必要です。

1. [Firebase コンソール](https://console.firebase.google.com/) で新規プロジェクトを作成
2. Firestore Database を有効化(ロケーションは `asia-northeast1` 推奨)
3. FlutterFire CLI を入れる(まだ無ければ):

```bash
dart pub global activate flutterfire_cli
```

4. プロジェクト直下で以下を実行し、`lib/firebase_options.dart` を生成:

```bash
flutterfire configure
```

5. Firestore のセキュリティルールを以下のように設定(開発用の最低限の例):

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /scores/{doc} {
      allow read: if true;
      allow create: if request.resource.data.keys().hasAll(['nickname','score','createdAt'])
        && request.resource.data.nickname is string
        && request.resource.data.nickname.size() <= 20
        && request.resource.data.score is int
        && request.resource.data.score >= 0
        && request.resource.data.score <= 200;
      allow update, delete: if false;
    }
  }
}
```

`firebase_options.dart` が無い状態でも起動できますが、ランキング表示はオフラインフォールバックになります。

### 3. 実行

```bash
flutter run
```

## Firestore のスキーマ

- コレクション `scores`
  - `nickname`: string
  - `score`: int (正解数)
  - `createdAt`: Timestamp

## ディレクトリ構成

```
lib/
  main.dart
  firebase_options.dart   # flutterfire configure で生成
  models/
    kanji_question.dart
    score_entry.dart
  data/
    kanji_data.dart
  services/
    local_prefs.dart
    score_repository.dart
  screens/
    title_screen.dart
    nickname_screen.dart
    game_screen.dart
    game_over_screen.dart
  widgets/
    timer_bar.dart
    answer_button.dart
    kanji_display.dart
```
