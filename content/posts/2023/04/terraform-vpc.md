---
title: "TerraformでVPCを学ぶ"
date: 2023-04-19T22:10:36+09:00
draft: false
tags:
  - Terraform
  - AWS
  - ネットワーク
toc: true
---
AWS Solution Architect Associateの試験を受けようと思いたち、AWS勉強を進めています。
最近は業務でterraformでインフラをコード管理をしているのでterraformの勉強もかねてAWSネットワーク構築をやっていこうと思います。
<!--more-->
# TerraformでVPCを管理する
## VPCの定義
VPCは以下のコードです
```
resource "aws_vpc" "book_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "book_vpc"
  }
}
```
上記のコードではcidr_blockを定義しており、`10.0.0.0/16`をネットワークのCIDRとして定義しています。
これはつまり`10.0.0.0`~`10.0.255.255`をネットワーク範囲として利用するということを意味しています。

また、tagsではこのVPCを指すNameとしてbook_vpcという名前を付けています。
## Subnetの定義
以下ではインターネットと接続を持つpublic subnetとインターネットと接続を持たないprivate subnetを定義しています。
```
resource "aws_subnet" "book_public" {
  vpc_id     = aws_vpc.book_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "book-public-0"
  }
}
```
```
resource "aws_subnet" "book_private" {
  vpc_id     = aws_vpc.book_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "book-private-1"
  }
}
```
vpc_idにてどのvpc内でsubnetを切るかを定義しています。VPCの定義で示したリソースをidで指定します。
また、CIDR blockを定義しsubnet内で利用するIPアドレスの範囲を定義します。
public subnetでは`10.0.0.0`~`10.0.0.255`の範囲を持ち、private subnetでは`10.0.1.0`~`10.0.1.255`の範囲を持つと定義しています。

public subnetはインターネットとの通信が必要なため、インターネットゲートウェイとのルーティングが必要となります。
まず、以下のようにインターネットゲートウェイを定義します。
```
resource "aws_internet_gateway" "book_igw" {
  vpc_id = aws_vpc.book_vpc.id
  tags = {
    Name = "book-igw"
  }
}
```
vpc_idでインターネットゲートウェイを配置するVPCを指定します。

その次にインターネットからのアクセスを通すため、ルートテーブルを用意します。
```
resource "aws_route_table" "book_rt" {
  vpc_id = aws_vpc.book_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.book_igw.id
  }
  tags = {
    Name = "book_rt"
  }
}
```
cidr_blockでどこからのアクセスを受け入れるかを指定しています。
ここでは`0.0.0.0/0`と指定し、すべてのインターネットからのアクセスを受け入れるように指定しています。
最後にルートテーブルをサブネットと関連付けます
```
resource "aws_route_table_association" "book_public_association" {
  subnet_id      = aws_subnet.book_public.id
  route_table_id = aws_route_table.book_rt.id
}
```
subnet_idでpublic subnetとしたいサブネットを指定し、route_table_idで先ほど作成したroute tableと関連付けを行います。

これでpublic subnetとprivate subnetが作成できました。
# 感想
やはりリソースのコード管理はかっちりしてて個人的に好きです。引き続き勉強していきたいと思います。
# 参考
- 
