---
title: "SQLで複数テーブルを指定する"
date: 2024-03-03T00:10:24+09:00
draft: false
tags:
  - データベース
toc: true
---
応用情報のSQL文の読解のための知識を書いておきます
<!--more-->
FROM句で複数のテーブルを指定することができる。
例えば以下のように記述できます。  
```SELECT * FROM test A, test B```
# 感想
SQL文をしばらく書いてないので複数指定できることをすっかり忘れていました。
応用情報受けるまでには知識をしっかり押さえておきたいです。
# 参考
- https://ichilv.com/sql-language-from/