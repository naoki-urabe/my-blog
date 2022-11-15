---
title: "Hugoで作るブログ"
date: 2022-10-19T21:40:39+09:00
draft: false
---

ブログ記事をgit管理して作成から公開まで完結したいな～と思っていたところ、こんな記事を見つけました。
https://engineering.visional.inc/blog/_49/process-to-build-tech-blog/

これぞ自分が求めていたもの！ということで家に帰ってから早速試してみました。
<!--more-->

とりあえず公式の[QuickStart](https://gohugo.io/getting-started/quick-start/)から始めていきます

# hugo cliをinstallする
まずはhugo cliをinstallする必要があります。私はasdfでcli群を管理しているため、以下でinstallを行いました
```
asdf plugin add hugo
asdf install hugo latest
asdf global hugo latest
```

これでhugo cliがインストールされました。
# hugo newを利用し、サイトの土台を作成する
続いてhugoを利用してblogの土台を作っていきます
```
hugo new site 作りたいサイト名
```
以上でサイトの大まかな構造が作成されます

# サイトのthemeをインストールする
次にブログの装飾を行うthemeをインストールします。
今回はQuickStart通りに[Ananke](https://themes.gohugo.io/themes/gohugo-theme-ananke/)をインストールします
下記の手順では
1. hugo new siteで作成されたサイトのリポジトリをgit initでgit管理を行う
2. リポジトリ内にブログのテーマをサブモジュールとしてインストールする。
3. インストールしたテーマを使うようにconfig.tomlに設定を書き込む

という手順を取っています。
```
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo theme = \"ananke\" >> config.toml
```
これでサイトにテーマが適用されました。

# 投稿内容を作成する
サイトの準備ができたので、投稿を作成しましょう！
投稿を作成するには以下のコマンドを利用します。パス、投稿内容名は適宜変更してください
```
hugo new 作成したいパス/投稿内容名.md
```
上記のコマンドを打つとcontent配下に新しく投稿用のmdファイルができているはずです。
出来上がったmdファイルに投稿記事を書いていきましょう。markdownで記述できます。

この記述ファイルがどのように見えるかは以下のコマンドを打ち、http://localhost:1313にアクセスすることで確認ができます。
```
hugo server -D
```
以上で実際に公開する方法は次回の記事「netlifyでブログを公開する」で紹介します！

## 参考
https://engineering.visional.inc/blog/_49/process-to-build-tech-blog/
https://gohugo.io/getting-started/quick-start/