---
title: "RustでHello World"
date: 2022-11-22T21:22:12+09:00
draft: false
tags:
  - Rust 
toc: true
---
徐々に低レイヤの分野で採用が増えてきているRustについて、`Hello World`が表示できるまで試してみました。
<!--more-->
# Hello Worldをやってみる
`Hello World`を出力するコードは以下です
```
fn main() {
    println!("Hello World!");
}
```
上記のコードでやっているのは、関数mainを宣言し、printlnマクロを呼んでいます。マクロ呼び出しの際は`!`を後ろに付けます。printlnマクロに`"Hello World!"`という文字列を引数として渡して、Terminalに`Hello World!`の文字列を表示させています。
処理の終わりには`;`を付けています。ここはC/C++と同じ記法ですね。

上記のコードをファイルにmain.rsという名前で保存します。Rustのファイル拡張子は.rsです。
以下のコマンドでコンパイルを行います
```
rustc main.rs
```
上記コマンドを実行すると実行ファイルmainが出来上がります。
このファイルを実行するには以下を実行します。
```
./main
```

```
Hello, World!
```
表示されました！
# 感想
前からRustは自作OS、自作DBなど低レイヤ分野での実装に用いられる言語として気になっていました。とりあえず、Hello Worldはできましたが、まだなにもわかってないので引き続き学習していきたいと思います。
# 参考
- https://doc.rust-lang.org/book 
