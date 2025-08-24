---
title: "IAMについて"
date: 2022-11-01T21:57:16+09:00
draft: false
tags:
  - "AWS"
toc: true
---
IAMとはAWSにおいて、リソースをセキュアに操作するために認証、認可の仕組みを提供するサービスです。
IAMの理解なしにAWSリソース操作を開始してしまうと、強力すぎる権限を与えるなどセキュリティ的によくないことになってしまうため、最初にしっかり内容を抑えておきたいサービスです。
<!--more-->
<img src="/images/iam-policy.png" alt="IAM policy" width="400"/>

リソースに対するアクセス権限管理の設定はIAM policyと呼ばれるjson形式のファイルによって管理されます。このpolicyをユーザ、グループ、ロールに付与することにより、これらがリソースへのアクセス、操作が可能となります。権限を付与する際には、セキュリティの観点から、必要最低限のものを与えるのがベストプラクティスとなっています

上の説明でさらっとユーザ、グループ、ロールに対して権限を付与すると書きましたが、それぞれの違いは以下です

## ユーザ
AWS上の利用者はすべてIAMユーザとして設定されます。ユーザは
大きく3種類があります
### ルートユーザ
<img src="/images/root-user.png" alt="root user" width="300"/>

AWSアカウントが作成されるとデフォルトで作成されるユーザです。こちらはIAMユーザではないですが、すべてのリソースの操作権限があります。また、アカウントの削除などいくつかルートユーザにしかできない操作が可能となっています。
 
### 管理者ユーザ
<img src="/images/admin-user.png" alt="admin user" width="200"/>

IAM操作とリソース操作ができるユーザです。IAMの操作が必要となったときは、ルートユーザではなく管理者ユーザで操作をしましょう。
### パワーユーザ
<img src="/images/power-user.png" alt="power user" width="100"/>

パワーユーザはIAM操作以外すべてのリソースに対して操作が許可されたユーザです。開発時にはIAM操作を除いたユーザで操作を行うのが良いです

## グループ
<img src="/images/iam-group.png" alt="iam group" width="400"/>

あるIAMユーザのグループに対してIAM policyを付与するとグループに所属しているIAMユーザすべてに対してpolicyに記述してあるリソースに対するアクセス許可/不許可が設定できます。

## ロール
<img src="/images/iam-role.png" alt="iam role" width="400"/>

AWSリソースに権限をロールとして与えるものです。サービス間通信にもIAM policyが設定されていない限り通信不可です。

# 感想
IAMはAWSを使いこなすうえでとても重要なサービスです。今回記事をまとめたことで知識が整理されました。まだ知らないこともありそうなので、引き続き学びたいと思います。

# 参考
- https://aws.amazon.com/jp/blogs/news/webinar-bb-aws-iam-part1-2019/
- https://www.udemy.com/course/aws-associate/
