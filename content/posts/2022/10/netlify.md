---
title: "Netlifyの独自ドメイン設定"
date: 2022-10-22T16:20:03+09:00
draft: false
---
今回は前回作成したhugoをnetlifyにデプロイしたいと思います。
手順は前回と同じく[hugo公式の手順](https://gohugo.io/hosting-and-deployment/hosting-on-netlify/)を参考にします。
デプロイ手順に関しては公式の手順に沿って行えば難なくできると思うので、独自ドメインの設定方法を紹介します。
利用するドメインは購入済みのものとします。

私はドメインをおなまえ.comで取得したのでそれに沿ったやり方を紹介します。
まずnetlifyの管理画面を開き、Domainsタブを開きます。
![netlify管理画面](/images/netlify-admin.png)
右上にあるAdd or register domainをクリックします
![domain設定1](/images/setup-domain.png)
購入しているドメインを入力し、Add domainを押します。
![domain設定2](/images/setup-domain2.png)
次の画面はOptionalなので今回は設定せずContinueを押しました。
![domain設定3](/images/setup-domain3.png)
次の画面に行くと、ドメインプロバイダーにログインして、name serverを書き換えるよう指示されます。
netlify側の設定はこれで終わりです。

Doneを押し、ドメインプロバイダーのname serverを書き換えましょう。おなまえ.comにログインして対象のドメインのnameserverを書き換えます。
ほかのネームサーバーを利用にチェックを入れ、先ほどnetlify側で表示された情報を登録していきます。
![domain設定4](/images/setup-domain4.png)

これでドメイン登録作業が終わりました。72時間以内には登録されるみたいです。
私の場合、数分で反映されました。早いですね。

最近テックブログを勧める記事をたくさん読んでいたので、ブログを始めるモチベーションが上がっていました。
週一更新ペースで内容を充実させていけたらいいなあと思ってます。
# 参考
https://gohugo.io/hosting-and-deployment/hosting-on-netlify/