---
title: "3層スキーマについて"
date: 2023-01-16T23:09:55+09:00
draft: false
tags:
  - データベース
toc: true
---
データベースの設計方法について学びなおしたかったため、調べました。
<!--more-->
# 3層スキーマとは
3層スキーマとはデータベースを設計するときの三つの段階のことを言います。
3層スキーマの構成要素として、外部スキーマ、概念スキーマ、内部スキーマがあります。
## 外部スキーマ
外部スキーマは、ユーザから見たデータベースです。
ユーザから見てどんなデータを持つのか、どんな役割を持つのかを設計します。
## 概念スキーマ
概念スキーマは開発者から見たデータベースです。
データの要素、データ同士の関連などの設計を行います。
概念スキーマの設計を行うことを論理設計といいます。
## 内部スキーマ
内部スキーマは、DBMSから見たデータベースです。
概念スキーマで設計した論理データモデルをDBMS上でどのようにデータを保存するかを設計します。
内部スキーマの設計を行うことを物理設計といいます。

## 感想
普段アプリ開発から離れていると、どんどんデータベースなどの知識が抜けていくので見直していきたいなと思いました。
使わない力は衰えていくっていうし。
# 参考
-<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoeng-22&language=en_US&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4798124702&linkId=271651c9c558c935b7f4aaafce78a6e1"></iframe> 
