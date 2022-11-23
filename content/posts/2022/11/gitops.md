---
title: "GitOpsについて調べてみた"
date: 2022-11-23T13:07:27+09:00
draft: false
tags:
  - Kubernetes
  - CI/CD
toc: true
---
普段のデプロイツールとしてArgoCDを利用していているのですが、ArgoCDのデプロイ手法であるGitOpsについてよく知らなかったので調べてみました。
<!--more-->
# GitOpsとは
GitOpsとはKubernetesクラスタへの操作をGitリポジトリを通じて行う`CI/CD`手法です。
Gitリポジトリを通じてクラスタ操作を行うため、manifest file専用のリポジトリを用意する必要があります。
## GitOpsフロー
<img src="/images/GitOps.drawio.png" alt="GitOps" width="500"/>

GitOpsを採用した際のデプロイフローは以下のようになります。
1. Applicationに対して変更を行う
2. Applicationの変更を反映したコンテナimageを作成し、Container Registryにpushする
3. manifestを管理しているrepositoryでimage versionを変更したmanifestのPRを作成する
4. 開発者はmanifestを確認し、問題なければマージを行う。
5. Kubernetesクラスタのデプロイエージェントがマージをトリガーにデプロイ作業を行う
# GitOpsのメリット
GitOpsを採用することにより、デプロイをコード管理できるようになります。
コード管理することにより、デプロイした後に問題があることが分かった場合、該当するデプロイPRをrevertすることにより、容易に問題が発生する前の状態に戻すことができます。

また、GitOpsを採用しているデプロイツールを採用することにより、デプロイエージェントに作業を任せることができます。
開発者は手作業によるデプロイ作業から解放され、より本質的な作業に専念できます。手作業による誤操作も減ることが期待されます。
# 感想
普段、KubernetesのデプロイにはArgoCDを利用しているのですが、そのArgoCDが採用しているGitOpsとは何なのかぼんやりとしかわからなかったので調べてみました。Gitリポジトリでデプロイを管理するシンプルな方法であることがわかりました。次はこのデプロイ手法を採用しているArgoCDについて調べてみます。
# 参考
- https://argo-cd.readthedocs.io/en/stable/
<iframe sandbox="allow-popups allow-scripts allow-modals allow-forms allow-same-origin" style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoeng-22&language=en_US&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=4295009792&linkId=688a7156d636c0f059f8c3ad35b26344"></iframe>
