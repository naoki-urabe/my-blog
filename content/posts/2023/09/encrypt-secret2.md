---
title: "secretのetcd保存時に暗号化を行う"
date: 2023-09-26T07:53:04+09:00
draft: false
tags:
  - kubernetes
  - セキュリティ
toc: true
---
今回は前回のsecretリソースが平文のままectdに保存されてしまう問題について暗号化を有効にすることによって対処します。

<!--more-->

# 暗号化のためのマニフェストファイルを作成する
ectdを暗号化するためには以下のマニフェストファイルを作成し、kube-apiにオプションとして渡さなければなりません。
```
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  # 暗号化を行うリソースを指定する
  - resources:
      - secrets
    # 暗号化の方法を指定する。
    providers:
      - aescbc:
          # 暗号化に利用される鍵
          keys:
            - name: key1
              # See the following text for more details about the secret value
              secret: <BASE 64 ENCODED SECRET>
      # 暗号化を行わない
      - identity: {}
```

resourcesでetcd保存時に暗号化したいkubernetesリソースの指定を行います。今回はsecretsを暗号化したいため、secretsを指定します。

providersで暗号化の方法について指定を行います。ここではaescbcの指定を行います。またkeysは暗号化に利用する鍵の指定を行い、nameで鍵の名前、secretで鍵の指定を行います。secretについてはbase64でエンコードを行う必要があります。
providersの記述順は行いたい暗号化が一番上に来るようにする必要があります。一番上の暗号方法で暗号化を行うためです。例えば、identityが一番上に来ている場合、identityは暗号化を行わないものであるため、暗号化が無効となります。なので記述順は気を付ける必要があります。

# 参考
- [Certified Kubernetes Administrator (CKA) with Practice Tests
](https://www.udemy.com/share/101Xtg3@9kgL1M3PCKMcvnTyg1Vo19DMBpX5_DsqiXDVRmAUf1p_ua0LuMnQjGwJILDpwIzQow==/)
- https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/
