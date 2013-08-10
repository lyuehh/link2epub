<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html style="font-family: Georgia, serif;" xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN">
<head>
<title></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>
<body>
<ul>
    <% @titles.each_with_index do |i, n| %>
    <li><%= n+1 %>: <%= i %></li>
    <% end %>
</ul>
</body>
