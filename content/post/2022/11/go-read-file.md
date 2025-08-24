---
title: "Goでのファイル読み込み"
date: 2022-11-26T21:42:43+09:00
draft: false
tags:
  - Go
toc: true
---
Goでのfile読み込み方法がわからなかったので調べました。
<!--more-->
# 利用パッケージを調査
「Go file読み込み」で調べてみると`ioutil` packageを利用する方法が結構ヒットしますが、こちらはdeprecatedになったようです。  
https://github.com/golang/go/issues/42026

今は`os` packageを使うのが良いみたいです。
以下に`os` packageを使ったコードを示します。
```
package main

import (
        "fmt"
        "log"
        "os"
)

func main() {
        // filenameを引数から読み出す
        args := os.Args
        // filanameが引数に設定されていなかったらエラーログ出力
        if len(args) != 2 {
                log.Fatal("not found filename")
        }
        // filename設定
        filename := args[1]
        bin, err := os.ReadFile(filename)
        // error handling: os.ReadFileでerrがnil出なかった場合、エラーログを表示する
        if err != nil {
                log.Fatal(err)
        }
        // 読み込んだ[]byteをstringでキャストし表示する
        fmt.Println(string(bin))        
}
```
このコード中でファイル読み込みをしている箇所は
```
bin, err := os.ReadFile(filename)
```
`os.ReadFile`の返り値は`[]byte`です。
従って、`fmt`でそのまま表示しようとすると想定通り出力にならないので、以下のように型変換する必要があります。
```
string(bin)
```
上記のコードをmain.goと名付け保存します。
# 実行
以下のような内容のファイルを用意し、helloworld.txtと名付け保存します。
```
hello
world
```

以下のコマンドを実行します。
```
go run main.go helloworld.txt
hello
world
```
ファイル内容が表示されました。
# 感想
ファイル読み込みしたとき`[]byte`で返ってくるので、それを型変換しなければならないところが、ちょっと面倒だなと感じました。
他の言語ではどうやってたか、ちょっと気になったので調べてみたいと思います。
# 参考
- https://pkg.go.dev/os#ReadFile 
