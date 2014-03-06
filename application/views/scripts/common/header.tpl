<div class="navbar navbar-fixed-top navbar-inverse">
  <div class="navbar-inner">
    <div class="container">
      <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
      <a class="brand" href="/"><*$nowdate*></a>
      <div class="nav-collapse collapse">
        <ul class="nav">
          <*foreach from=$setting.actionlist item=item key=key*>
          <*if in_array($item,$user_can_action)*><li <*if $item==$controller*>class="active"<*/if*>><a href="/<*$item*>"><*$actionname.$item*></a>
          </li>
          <*/if*>
          <*/foreach*>
        </ul>
        <div class="btn-group pull-right dropdown"> <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="icon-user icon-white"></i> <*$_user->username*>[<*$_user->workid*>] <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
            <li><a href="/user/index"> 帐户信息</a></li>
            <li><a href="/login/out">退出</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="main container">
<*if $controller<>'index' && $controller<>'goods' && $controller<>'history'*>
<h1><*$actionname.$controller*></h1>
<*/if*> 


