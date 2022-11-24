---
title: "Helmfileについて調べてみる"
date: 2022-11-24T21:22:27+09:00
draft: false
tags:
  - Kubernetes
  - CI/CD
toc: true
---
仕事でHelmfileを使っているのですが、それがどのようなものなのかを把握してないので調べてみました。
<!--more-->
# HelmfileのREADMEを読んでみる
HelmfileとはHelm chartの設定を宣言的に管理するものです。
Helmfileを利用することにより
1. chartの設定変更をバージョン管理する。
2. 設定変更をCI/CDで反映する
3. 定期的にsyncすることにより環境ごとの差分をなくす

などが可能となります。
# Getting Startedを試してみる
```
# chartを持ってくるリポジトリを指定します。
repositories:
  - name: prometheus-community
    url: https://prometheus-community.github.io/helm-charts

# 自分が望むクラスタの状態を記述します。
releases:
  - name: prom-norbac-ubuntu
    # chartが動くnamespace
    namespace: prometheus
    # repositoriesで指定したchart repoから利用するchartを選択します
    chart: prometheus-community/prometheus
    # chartに渡すkey-valueを設定します
    set:
      - name: rbac.create
        value: false
```
コードは主に二つの部分からなります。
一つ目は`repositories`フィールドで、urlで指定したドメインからchartを持ってくるように設定を行います。

二つ目は`releases`フィールドで、自分が望むクラスタの状態を記述します。
こうすることにより、helmfileの内容が常にクラスタの状態を表していることになります。
`namespace`,`chart`,`set`など細かな設定を行うことができます。
記述ができたら`helmfile.yml`と命名して保存します。
以下のコマンドでデプロイを行います。
```
helmfile apply -f helmfile
```
上記コマンド実行後のKubernetesクラスターのnamespaceを確認してみます。
```
k get namespace
NAME              STATUS   AGE
default           Active   50d
kube-node-lease   Active   50d
kube-public       Active   50d
kube-system       Active   50d
prometheus        Active   68m
```
新しくprometheus namespaceが作成されていることがわかります。
現在のnamespaceをprometheusに切り替えた後、podの状態を確認すると
```
k get po
NAME                                                          READY   STATUS              RESTARTS     AGE
prom-norbac-ubuntu-kube-state-metrics-9dd59b966-mt6cl         1/1     Running             0            2m28s
prom-norbac-ubuntu-prometheus-alertmanager-6ddfd8d7bb-bbvw8   2/2     Running             0            2m28s
prom-norbac-ubuntu-prometheus-node-exporter-kh2tc             0/1     RunContainerError   0 (5s ago)   6s
prom-norbac-ubuntu-prometheus-pushgateway-746756b4-8bnsm      1/1     Running             0            2m28s
prom-norbac-ubuntu-prometheus-server-545dcc7d76-dfp6w         2/2     Running             0            2m28s
```
となっており、確かにprometheus chartがデプロイされていることが確認できました。
このprometheus chartを破棄する場合は以下のコマンドを用います。
```
helmfile destory -f helmfile.yml
```
上記コマンドを実行後`k get po`を実行すると
```
No resources found in prometheus namespace.
```
と表示されchartが破棄されていることがわかります。
# 感想
インフラ管理はやはりIaCが主流になってきているなあと感じました。コード管理することによって、
- 現在のインフラの状態が明示されている
- 環境が壊れても戻しやすい

といったメリットがあるのでhelmfileもこの思想に乗っかったのかなあと思います。helmfileに関わらず、terraform,ansibleなど様々なツールについても理解を深めていきたいなあと思いました。
# 参考
- https://github.com/helmfile/helmfile
