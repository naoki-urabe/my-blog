---
title: "Goで競プロするときの入力方法"
date: 2022-11-30T23:00:55+09:00
draft: false
tags:
  - Go
  - 競プロ
toc: true
---
Goで競プロするとき、入力方法がよくわからなかったので調べました。
<!--more-->
```
import (
	"bufio"
	"strconv"
)

var sc = bufio.NewScanner(os.Stdin)
// int型
func inputI() int {
	sc.Scan()
	i, e := strconv.Atoi(sc.Text())
	if e != nil {
		fmt.Println(e)
	}
	return i
}

// float型
func inputF() float64 {
	sc.Scan()
	i, e := strconv.ParseFloat(sc.Text(), 64)
	if e != nil {
		fmt.Println(e)
	}
	return i
}

// string型
func inputS() string {
	sc.Scan()
	return sc.Text()
}
```
# 参考
- 
