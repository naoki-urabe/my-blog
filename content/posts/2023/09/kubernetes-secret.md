---
title: "Kubernetes Secretリソースについて学習"
date: 2023-09-23T16:45:06+09:00
draft: false
tags:
  - kubernetes
toc: true
---
CKA資格取得に向けて学習中なので勉強内容をまとめます。
<!--more-->
# Secretリソースについて
Podに環境変数を設定する方法として、マニフェストに直接記載する、ConfigMapを利用する方法などがありますが、これらの方法では秘密鍵など秘匿にしたい情報をそのまま表示してしまうため、秘匿情報には向きません。
そこでSecretリソースが用意されています。Secretを利用することで内容を秘匿することができます。

# 注意点
Secret情報はbase64でエンコードして保存されます。しかしbase64は簡単にデコードできてしまうため、Secretにbase64をエンコードしたファイルをそのままインターネット上に公開してしまうとセキュリティリスクとなります。

# 感想
知識がなければ、base64でエンコードしてそのままインターネットに公開してしまうため、使用を知るということは大事なのだなと実感しました。

# 参考
- [Certified Kubernetes Administrator (CKA) with Practice Tests
](https://www.udemy.com/share/101Xtg3@9kgL1M3PCKMcvnTyg1Vo19DMBpX5_DsqiXDVRmAUf1p_ua0LuMnQjGwJILDpwIzQow==/)
- Kubernetes完全ガイド 第2版 (Top Gear) | 青山 真也 |本 | 通販
