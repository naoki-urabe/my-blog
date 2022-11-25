---
title: "Reusable Workflowについてまとめる"
date: 2022-11-25T22:49:19+09:00
draft: false
tags:
  - Github Actions
  - CI/CD
  - "便利"
toc: true
---
Github ActionsはReusable workflowというworkflowをモジュール化する機能を備えています。Reusable workflowを利用することにより、workflowの共通部分を括り出し、何度も同じ記述を行う必要がなくなります。
<!--more-->
# Reusable workflow
Reusable workflowを利用したworkflowは以下です。
```
on:
  # Reusable workflowは発動トリガーにworkflow_callを指定します
  workflow_call:
    # Reusable workflowへの引数を設定します。
    inputs:
      first_name:
        # 引数が渡ってこなかったときのデフォルト値を設定できます
        default: "nobita"
        # 引数が必須であるかを設定します
        required: false
        # 引数の型を設定します
        type: string
    # secret情報を渡します
    secrets:
      last_name:
        # secretが必須であるかを設定します
        required: false

jobs:
  reusable_workflow_job:
    runs-on: ubuntu-latest
    steps:
      - name: print name
        # 引数、secretは以下の記述で読み込めます
        run: echo "I'm" ${{ inputs.first_name }} ${{ secrets.last_name }}
```
workflowの発動トリガーには`workflow_call`を指定します。  
Reusable workflowには引数、secretを渡すことが可能です。  
## 引数
引数は以下のオプションなどを持ちます。  
`default`を指定することにより値が渡ってこなかった場合のデフォルト値を設定できます。  
`required`を設定することにより、引数が必須かどうかを設定できます。  
`type`を設定することにより、引数の型を設定できます。
## secret
secretは以下のオプションなどを持ちます。  
`required`はsecretを渡すことが必須かどうかを設定できます

## 引数、secret参照方法
上記で渡ってきた引数、secretなどを利用してjobを実行します。  
引数を参照するには`${{ inputs.*** }}`  
secretを参照するには
`${{ secrets.*** }}`  
という記法を用いて参照します。
# Caller(Reusable workflowを呼び出す側)
次にReusable workflowを呼び出す側についてみていきます。  
Reusable workflowを呼び出すCaller workflowは以下です。
```
on:
  workflow_dispatch

jobs:
  call-reusable-workflow:
    # 作成したReusable workflowへのpathを指定し、Reusable workflowをチェックアウトします
    uses: naoki-urabe/playground/.github/workflows/reusable-workflow.yml@master
    # 引数、secretをReusable workflowへ渡します
    with:
      first_name: "John"
    secrets:
      last_name: "Connor"
```
Reusable workflowを利用するには、対象のReusable workflowをチェックアウトする必要があります。`uses`で対象のReusable workflowへのパス、ブランチを指定します。  
`with`で渡す引数の設定をします  
`secrets`で渡すsecretの設定をします

# 実行結果
<img src="/images/reusable-workflow-res.png" alt="subnet" width="1000"/>

引数として渡した`John`とsecretとして渡した`Conner`（マスクされてますが）が表示されていることがわかります。
# 感想
Github Actionsは本当に便利で触るたびに新しい発見があります。
今回紹介したReusable workflowは仕事で重複するworkflowの処理をなんとか共通化できないかということで見つけた機能です。
この機能を用いてworkflowのリファクタリングを行ったおかげ、かなりworkflowの見通しが良くなりました。また便利機能見つけたら紹介したいと思います。
# 参考
- https://docs.github.com/en/actions/using-workflows/reusing-workflows
