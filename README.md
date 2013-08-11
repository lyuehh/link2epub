## introduction
Link2epub can make a epub book based on a list of links (url)..

## install
```shell
$ gem install link2epub
```

## how to use
First make a `conf.yaml` file, like this:
```
link: http://coolshell.cn/
title: 酷壳 – CoolShell.cn
subtitle: 陈浩的博客
author: 陈浩
description: 陈浩的博客
links_file: links2.txt
file_name: coolshell.epub
rule:
    title: .post h2
    author: .post .author
    date: .post .date
    content: .post .content
```
then make a `links2.txt` file:
```
http://coolshell.cn/articles/10249.html
http://coolshell.cn/articles/10217.html
```

and then:
```
$ link2epub conf.yaml
```
that's all, you will get a epub file in the current directory.
