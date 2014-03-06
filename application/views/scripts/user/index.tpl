<div id="<*$controller*>">
<script type="text/javascript" >
function checkit(){
	var oldpassword=$('#oldpassword').val();
	var newpassword=$('#newpassword').val();
	var repassword=$('#repassword').val();
	var isok=1;

	$('#readme1').html('');
	$('#readme2').html('');
	$('#readme3').html('');

	if(oldpassword==''){
		$('#readme1').html('旧密码不能为空');
		isok=0;
	}
	if(newpassword==''){
		$('#readme2').html('新密码不能为空');
		isok=0;
	}
	if(newpassword != repassword){
		$('#readme3').html('两次输入密码不一致');
		isok=0;
	}
	if(isok==1)	
		return true;
	else
		return false;
}
</script> 

  <form method="post" onsubmit="return checkit()" action="/<*$controller*>/op">
    <dl class="dl-horizontal">
      <dt>用户编号</dt>
      <dd><*$result.workid*> </dd>
      <dt>用户名</dt>
      <dd><*$result.username*></dd>
      <dt>最后登录于</dt>
      <dd><*$result.lasttime*> </dd>
      <dt>登录次数</dt>
      <dd><*$result.login_num*> </dd>
      <dt>操作权限</dt>
      <dd><*foreach from=$setting.actionlist item=result1 key=key1*>
        <*if in_array($result1,$result.action)*><*$actionname.$result1*><*/if*>&nbsp;
        <*/foreach*> </dd>
      <dt>原密码</dt>
      <dd>
        <input type="password" name="oldpassword" id="oldpassword" value=""  class="input-medium"  />&nbsp;<small id="readme1" class="label-warning"></small> 
      </dd>
      <dt>新密码</dt>
      <dd>
        <input type="password" name="newpassword" id="newpassword" value=""  class="input-medium"  />&nbsp;<small id="readme2" class="label-warning"></small> 
      </dd>
      <dt>再次输入新密码</dt>
      <dd>
        <input type="password" name="repassword" id="repassword" value=""  class="input-medium"  />&nbsp;<small id="readme3" class="label-warning"></small> 
      </dd>
      <dt>&nbsp;</dt>
      <dd>
        <button type="submit" class="btn btn-primary btn-large">保存密码</button>&nbsp;&nbsp;<button type="reset" class="btn btn-large">重置</button>
      </dd>
    </dl>
  </form>
</div>
