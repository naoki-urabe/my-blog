---
title: "Helmについて調べる"
date: 2022-11-21T21:33:32+09:00
draft: false
tags:
  - Kubernetes
  - 基礎
toc: true
---
仕事でHelmfileを触るのですが、その前にHelmとの関係がよくわからなかったので調べてみました。
<!--more-->
# Helmとは
Helmとはkubernetesのpackage managerのことを言います。Ubuntuでいうapt,CentOSでいうyumですね。HelmはChartsと呼ばれる、関連するKubernetesリソース群単位を管理します。
# QuickStartをやってみる
以下のコマンドを実行することにより、Helmにリポジトリを登録します。リポジトリを登録することにより、そのリポジトリに登録してあるChartsを参照できるようになります。
```
helm repo add bitnami https://charts.bitnami.com/bitnami
```
以下のコマンドで登録したリポジトリのChartsを参照できます
```
helm search repo bitnami
```
以下のコマンドにより、最新のChartsリストが参照できるようになります。後述するhelm installを行う前にはやっておいたほうがよさそうです。
```
helm repo update
```
以下のコマンドでmysql Chartsをreleaseします。以下のコマンドを実行するたびに新たにreleaseが行われます。これらreleaseに関しては独立に管理がされます。
```
helm install bitnami/mysql --generate-name
```
以下のコマンドを行うことにより、releaseのuninstallが行われ関連リソースが削除されます。
```
helm uninstall mysql-xxxxx 
```
# Helmを使うことによるメリット
Helmを利用することにより、誰かが作ったChartsを再利用できます。任せられるところは他に任して、自分はより本質的な部分に集中できます。
# 感想
Helm Chartsが登録してある[ArtifactHUB](https://artifacthub.io/packages/search?kind=0)を見てみましたが、かなりの数が登録してあり、Kubernetesのエコシステムの巨大さを感じました。次は本来知りたかったHelmfileが何をするものなのかを調べていきたいと思います。
# 参考
- https://helm.sh/docs/
<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoeng-22&language=en_US&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B08FZX8PYW&linkId=e0a4ea937867cc0a3978b670cdfa7eb9"></iframe>
