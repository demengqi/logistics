<div class="navbar clearfix navbar-fixed-top">
 <a class="brand" href="/">&nbsp;&nbsp;&nbsp;&nbsp;<*$setting.company*></a>
    <ul class="nav">
	<*foreach from=$setting.actionlist item=item key=key*>
	  <*if in_array($item,$user_can_action)*><li <*if $item==$controller*>class="active"<*/if*>><a href="/<*$item*>"><*$actionname.$item*></a></li><*/if*>
  <*/foreach*>
    </ul>
     <div class="btn-group pull-right dropdown">
     <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="icon-user icon-white"></i> <*$_user->username*>[<*$_user->workid*>] <span class="caret"></span></a>
     <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
     <li><a href="#myModal" role="button" data-toggle="modal"><i class="i"></i> 修改密码</a></li>
     <li><a href="/login/out">退出</a></li>
     </ul>
	</div>
</div>

<div class="container">
<ul class="breadcrumb">
<*if $controller<>'index'*>
<li><a href="/"><i class="icon-home"></i> 首页</a><span class="divider">/</span></li>
<li class="active"><*$this->actionname[$controller]*></li>
<*else*>
<li  class="active"><i class="icon-home"></i> 首页</li>
<*/if*>
</ul>

<*if $controller<>'index'*>
<h1><*$actionname.$controller*></h1>
<*/if*>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <form action="/user/opchangepassword" method="post" class="form-horizontal">

  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">修改密码</h3>
  </div>
  <div class="modal-body">
        <div class="control-group">
	  <label class="control-label" for="oldpassword">旧密码</label>
     <div class="controls">
     <input type="password" name="oldpassword" value=""  class="input-medium" id="oldpassword" placeholder="输入旧密码" /> <label class="help-inline"></label>
       </div>
	   </div>

        <div class="control-group">
	  <label class="control-label" for="newpassword">新密码</label>
     <div class="controls">
     <input type="password" name="newpassword" value=""  class="input-medium" id="newpassword" placeholder="输入新密码" /> <label class="help-inline"></label>
       </div>
	   </div>

        <div class="control-group">
	  <label class="control-label" for="repassword">重复密码</label>
     <div class="controls">
     <input type="password" name="repassword" value="" class="input-medium" id="repassword" placeholder="重复密码" /> <label class="help-inline"></label>
       </div>
	   </div>


  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button type="submit" class="btn btn-primary">保存修改</button>
  </div>
  </form>
</div>