---
title: "secretリソースをetcd保存する際の問題点ついての学習"
date: 2023-09-24T21:23:39+09:00
draft: false
tags:
  - kubernetes
  - セキュリティ
toc: true
---
kubernetesのsecretリソースをetcdに保存する際の問題点ついて学んだので書いていきます。
<!--more-->
# secretリソースのetcd保存時の問題点
kubernetesにおいて、secretを作成した場合、暗号化を行わなければ平文としてsecretがetcdに保存されることとなります。

実際に確認を行ってみます。
1. 以下コマンドでsecretの作成を行います

```
k create secret generic my-secret --from-literal=key1=himitsu
```

2. etcd-clietをインストールします
```
apt install etcd-client
```

3. etcdクライアントで保存されているsecret情報を取得します
```
ETCDCTL_API=3 etcdctl    
--cacert=/etc/kubernetes/pki/etcd/ca.crt      
--cert=/etc/kubernetes/pki/etcd/server.crt    
--key=/etc/kubernetes/pki/etcd/server.key     
get /registry/secrets/default/my-secret | hexdump -C
```

以下のような結果が返ってきます
```
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6d 79 2d 73 65 63  |s/default/my-sec|
00000020  72 65 74 0a 6b 38 73 00  0a 0c 0a 02 76 31 12 06  |ret.k8s.....v1..|
00000030  53 65 63 72 65 74 12 cc  01 0a b0 01 0a 09 6d 79  |Secret........my|
00000040  2d 73 65 63 72 65 74 12  00 1a 07 64 65 66 61 75  |-secret....defau|
00000050  6c 74 22 00 2a 24 31 33  37 65 61 62 33 33 2d 33  |lt".*$137eab33-3|
00000060  66 38 63 2d 34 61 32 30  2d 61 32 66 66 2d 66 61  |f8c-4a20-a2ff-fa|
00000070  36 66 65 37 65 39 34 65  38 30 32 00 38 00 42 08  |6fe7e94e802.8.B.|
00000080  08 eb 89 c3 a8 06 10 00  8a 01 61 0a 0e 6b 75 62  |..........a..kub|
00000090  65 63 74 6c 2d 63 72 65  61 74 65 12 06 55 70 64  |ectl-create..Upd|
000000a0  61 74 65 1a 02 76 31 22  08 08 eb 89 c3 a8 06 10  |ate..v1"........|
000000b0  00 32 08 46 69 65 6c 64  73 56 31 3a 2d 0a 2b 7b  |.2.FieldsV1:-.+{|
000000c0  22 66 3a 64 61 74 61 22  3a 7b 22 2e 22 3a 7b 7d  |"f:data":{".":{}|
000000d0  2c 22 66 3a 6b 65 79 31  22 3a 7b 7d 7d 2c 22 66  |,"f:key1":{}},"f|
000000e0  3a 74 79 70 65 22 3a 7b  7d 7d 42 00 12 0f 0a 04  |:type":{}}B.....|
000000f0  6b 65 79 31 12 07 68 69  6d 69 74 73 75 1a 06 4f  |key1..himitsu..O|
00000100  70 61 71 75 65 1a 00 22  00 0a                    |paque.."..|
0000010a
```

見ての通りsecret情報"key1:himitsu"がそのまま見えてしまっています。つまりectdにアクセスできる人はすべてのsecretを閲覧することができるようになってしまっています。

そこでsecretリソースに暗号化を行い、平文で見ることができないようにします。
暗号化方法は次回にします。

# 感想
etcdへのsecret保存時に、特に何もしなかった場合は、平文でデータが保存されてしまうということを今回学べてよかったです。
セキュリティ知識は知らなければ意図せずセキュリティホールを生み出してしまうものなのでしっかり学んでいきたいです。

# 参考
- [Certified Kubernetes Administrator (CKA) with Practice Tests
](https://www.udemy.com/share/101Xtg3@9kgL1M3PCKMcvnTyg1Vo19DMBpX5_DsqiXDVRmAUf1p_ua0LuMnQjGwJILDpwIzQow==/)
- https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/
