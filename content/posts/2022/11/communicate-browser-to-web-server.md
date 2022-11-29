---
title: "ブラウザからWeb Serverへアクセスするまでの流れ"
date: 2022-11-29T20:10:42+09:00
draft: false
tags:
  - ネットワーク
  - Web技術
toc: true
---
ブラウザからWeb Serverまでアクセスするまでの流れについて説明できる自信がなかったのでまとめてみました。
<!--more-->
# Overview
<img src="/images/browser-to-webserver.drawio.png" alt="browser to webserber" width="1000"/>
かなり簡単に流れを示したのが上の図です。

## ブラウザにURLを入力する
まずはブラウザの検索窓にアクセスしたいサイトへのURLを入力します。
入力後、ブラウザはURLをもとにWeb Serverへ送るためのリクエストを構築します。構築したリクエストはOSのネットワーク制御用ソフトウェア（プロトコルスタック）に渡します。
## プロトコルスタックによるデータ送信
プロトコルスタックがデータをパケットに分け、それぞれのパケットにデータの宛先などのヘッダを付与します。
その後、これらのパケットをLANアダプタへ送信します。
## LANアダプタによるデータ送信
LANアダプタがパケットを電気的信号に変換し、LANケーブルへデータを流します。

## インターネット接続用ルータにデータを渡す
LANケーブルに流れたデータはインターネット接続用ルータに流れていきます。
この後のデータの送信についてはプロバイダーが役割を担ってくれます。

## Web Serverがデータを受け取る
送られてきたデータは、ファイアウォールのチェックを受けた後、Web Serverに渡されます。
受け取ったデータはプロトコルスタックによって、再構築され元のリクエストを読み出します。
リクエストに応じてレスポンスを構築します。
レスポンスの送信処理はリクエスト送信処理と同様のフローです。
# 感想
最近、自分の知識にちょっと自信なくなってきたので改めて基礎から学びなおしています。ブラウザからWeb Serverにアクセスが届いて画面が表示されるまでのフローを図、文章で表してみると自分の知識抜けがはっきりわかるので、やはり、このようなことを記事にしてみるのは大事だなと感じました。どんどん基礎的なことも記事にしていきたいと思います。
# 参考
<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoeng-22&language=en_US&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4822283119&linkId=63582a486301a954e9f3991bba24907d"></iframe>
