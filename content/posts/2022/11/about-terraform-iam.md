---
title: "TerraformでIAMユーザを作成する"
date: 2022-11-27T17:51:38+09:00
draft: false
tags:
  - AWS
  - Terraform
toc: true
---
業務でTerraformを触りますが、体系的に学んでいないので、個人用アカウントでIAMユーザを作成してみました。
<!--more-->
# Terraformとは
TerraformとはAWSリソースを宣言的に管理するツールです。
宣言的に管理を行うことにより、コードによってインフラの状態が明示されます。また、インフラが壊れてしまったとしても、コードで管理されていることから、容易に復旧が可能です。
# TerraformでIAMを設定する
IAMユーザを作成するにあたりいくつかのステップがあります。
## IAM policy documentを作成する
まず最初に、アカウントが操作できる範囲をIAM policy documentに定義する必要があります。
```
data "aws_iam_policy_document" "develop-doc" {
  statement {
    effect = "Allow"
    not_actions = [
      "iam:*",
      "organizations:*",
      "account:*"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:DeleteServiceLinkedRole",
      "iam:ListRoles",
      "organizations:DescribeOrganization",
      "account:ListRegions"
    ]
    resources = ["*"]
  }
}
```
上記の設定での権限の範囲はパワーユーザです。アカウント管理以外のAWSリソースの操作について、すべての権限を有しています。
# IAM policyを設定する
```
resource "aws_iam_user_policy" "develop" {
  name   = "develop"
  user   = aws_iam_user.develop.name
  policy = data.aws_iam_policy_document.develop-doc.json
}
```
上記のIAM policyでは`develop`というIAM policyを作成しています。権限の範囲としては先ほど作成したパワーユーザ権限を有しています。  
`policy`に先ほど作成したdocumentをattachすることでパワーユーザ権限を持つ`develop`というpolicyができました。
# IAMユーザを作成する
```
resource "aws_iam_user" "develop" {
  name = "develop"
}
```

次に`develop`という名前をもつIAMユーザを作成しています。  
`name`に作成するIAMユーザ名を指定します。
# IAMユーザにAccess Keyを割り当てる
```
resource "aws_iam_access_key" "develop" {
  user    = aws_iam_user.develop.name
  pgp_key = "keybase:nao_e"
}
```
上記ではIAM User developにAccess Keyを割り当てています。  
`user`に鍵を割り当てるユーザを指定します
`pgp_key`にはbase64でエンコードされたPGP公開鍵、または、keybaseを利用している場合は、`keybase:{username}`を指定します。
今回はkeybaseを利用することとしました。

# IAMユーザにログインパスワードを割り当てる
```
resource "aws_iam_user_login_profile" "develop" {
  user    = aws_iam_user.develop.name
  pgp_key = "keybase:nao_e"
}
```
上記ではログインパスワードを設定しています。
記法としては先ほどの、Access Keyの割り当てと同様です。

# 暗号化されたAccess key,ログインパスワードを出力する
```
output "secret" {
  value = aws_iam_access_key.develop.encrypted_secret
}

output "password" {
  value = aws_iam_user_login_profile.develop.encrypted_password
}
```
IAMユーザにログインパスワードを割り当てるまでの記述が終わったら、それを`iam.tf`という名前で保存をします。そして以下のコマンドで今まで作成したリソースの反映を行います。
```
terraform apply
```
するとTerraformのログが流れ、最後にoutput出力がなされます。
それをbase64でdecodeし、pgpでdecryptすると、Access key,ログインパスワードが得られます。

# IAMユーザが作成されているかを確認
<img src="/images/iam-develop.png" alt="iam develop" width="3600"/>
新たにdevelopという名前のIAMユーザが作成されていることを確認できました。

# 感想
TerraformはDocumentが充実していて、やりたいことはだいたい公式Docを見ればわかるようになっていました。
また、記法もわかりやすく、かなり開発者体験の良いツールだと思います。
インフラのコード管理は個人的にかなり好きなので、どんどんIaC化やっていきたいと思います。
# 参考
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
