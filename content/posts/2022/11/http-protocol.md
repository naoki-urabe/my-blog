---
title: "HTTPについて大まかにまとめる"
date: 2022-11-20T12:22:30+09:00
draft: false
tags:
  - 基礎
  - Web技術
toc: true
---
HTTPとはWeb上のデータの送受信を行うときの通信規則を定義したものです。この記事ではHTTPについての大まかな内容をまとめます。

※勉強中なので誤った記述があるかもしれません。もし見つけた場合はコメント欄で指摘お願いします。
<!--more-->
# HTTP概要
HTTPとはHyperText Transfer Protocolの頭文字をとっています。HyperTextとは他のテキストへのリンクを含んだテキストのことを言います。HyperTextの転送用プロトコルとは名づけられているものの、それ以外の音声、動画などWeb上で表現できるあらゆるデータの送受信が可能なプロトコルとなっています。
したがって普段私たちが、インターネットサーフィンしたり、動画を見たり音楽を聞いたりしているとき、その後ろではHTTPを用いてデータ通信を行っています。


# HTTPのデータ通信
HTTPではデータのやり取りのアーキテクチャとして、サーバ・クライアントモデルを採用しています。
情報の要求(リクエスト)を行う方をクライアント、要求を受けて情報の提供を行う方（レスポンス）をサーバといいます。
データ通信の流れとしては以下です。
1. クライアントがリクエスト送信する
2. サーバがリクエストを受信する
3. サーバが受け取ったリクエストをもとにレスポンスデータを用意する
4. サーバがクライアント宛にデータを返送する
5. クライアントがサーバからのレスポンスを受け取る

# 感想
HTTPについては、普段仕事では意識せず、なんとなくの理解のままでした。説明しようとするとぱっと出てこなかったので、理解を深めるため今回この記事を書くことにしました。HTTPは奥深く、この記事では書ききることはできなかったので、何回かに分割して書きたいと思います。

# 参考
https://www.w3.org/WhatIs.html#:~:text=Hypertext%20is%20text%20which%20contains,to%20use%20this%20term%20too.
<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoeng-22&language=en_US&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B07JK7FZH2&linkId=3e9a55a986b336835033bca46c81ee5e"></iframe>
