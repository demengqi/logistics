<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><*$setting.company*></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="<*$setting.company*>  Inc." name="Copyright" />
<meta name="viewport" content="width=device-width"/>
<link rel="stylesheet" href="/css/all.css" type="text/css" media="all" />
</head>
<body>
<div id="wrap">
<div class="header">
  <div id="userinfo">当前操作员：<*$_user->username*>[<*$_user->workid*>]&nbsp;&nbsp;<a href="/user/changepassword">修改密码</a>&nbsp;&nbsp;<a href="/login/out">退出</a></div><a href="/">首页</a>
</div>
<div class="content">
<*if $controller<>'index'*><h1><a href="/">首页</a>&nbsp;>&nbsp;<*$this->actionname[$controller]*></h1><*/if*>
