# README
## 概要
RubyonRailsを使用して、Twitterのクローンサイトを作成いたしました。

本家にある主要な機能（ツイート、フォロー、リツイート、いいね、DM、通知）などの実装を行いました。

ログインに関してはメールの他GitHubでもできるようになっております。

## 使用技術一覧
バックエンド: Ruby 3.2.2 / Rails 7.0.8

コード解析 / フォーマッター: Rubocop

テストフレームワーク: RSpec

CSSフレームワーク: Bootstrap

主要パッケージ: devise, RSpec

インフラ: AWS S3 / Heroku

環境構築: Docker / Docker Compose

認証: devise（Github認証、メール認証）

## 主要機能一覧
メールアドレスとパスワードを利用したユーザー登録 / ログイン機能

GitHubアカウントを利用したユーザー登録 / ログイン機能

ユーザー情報変更機能

パスワード再設定機能

ページネーション機能

画像の取得 / アップロード機能

テスト（単体テスト、統合テスト）


## 利用方法

#### 前提
- dockerが必要です。

#### setup
```
docker compose build
```
```
docker compose run --rm web bin/setup
```
```
docker compose run --rm web yarn install
```
#### run
```
docker compose up
```
http://localhost:3000
