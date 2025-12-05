---
title: "cert-managerとingress"
date: 2024-03-07T19:56:10+09:00
draft: false
tags:
  - Kubernetes
  - メモ
toc: true
---
cert-managerとingressがどのような関係なのかあやふやなので書いておきます。
<!--more-->
cert-managerはKubernetesクラスタ上で自動でTLS証明書を取得、更新してくれるツールです。  
cert-managerはingressを保護するため、TLS証明書の取得を行います。  
ingressリソースのmetadata.annotationsに  
```cert-manager.io/cluster-issuer: <clusterissuerリソースの名前>```  
と設定することでclusterissuerで指定したメールアドレスで署名を行ったTLS証明書の発行を行うことができます。

## 感想
まだ証明書発行についてザックリとしかわかってないので引き続き勉強します

## 参考
- https://cert-manager.io/docs/usage/ingress/
