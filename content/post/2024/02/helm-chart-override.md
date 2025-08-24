---
title: "Helm Chartの設定値を環境ごとに変える"
date: 2024-02-28T22:24:51+09:00
draft: false
tags:
  - Kubernetes
toc: true
---
業務で環境ごとにHelm Chartの値を変えたくなったので、その方法を書きます。
<!--more-->
```
helm install --upgrade <release名>　<chart> -f <valueファイルのテンプレート> -f <ある環境向けのvalueファイル>
```
valueファイルは一番右にあるファイルによって、その前にあるファイルの値を上書きします。  
valueファイルのテンプレートには環境共通の値を書き、ある環境向けのvalueファイルには環境ごとの値を設定することにより、ファイルの見通しが良くなります。

# 参考
- https://qiita.com/Naoto_Ito/items/c01fd4b44dcb8fbbebcc
