<div id="<*$controller*>">
<form action="/<*$controller*>/op" method="post" class="form-horizontal">
   <*foreach from=$result item=item key=key*>
   <fieldset>
   <legend>用户编号[<*$item.workid*>]:</legend>
      <div class="control-group">
	  <label class="control-label" for="username_<*$item.id*>">用户名</label>
     <div class="controls">
     <input type="text" name="username[<*$item.id*>]" value="<*$item.username*>" id="username_<*$item.id*>" class="input-medium" /><label class="help-inline"><i class="icon-edit"></i> <*$key*></label>
       </div>
	   </div>
       
       
       <div class="control-group">
	  <label class="control-label" for="password_<*$item.id*>">密码</label>
     <div class="controls">
     <*if $item.id==1*>
         <span class="input-medium uneditable-input">***</span>
      <*else*>

     <input type="text" name="password[<*$item.id*>]" value=""  id="password_<*$item.id*>" class="input-medium"  /><label class="help-inline"><i class="icon-edit"></i> <*$key*></label>
      <*/if*>    
      </div>
	   </div>
       
      <div class="control-group">
	  <label class="control-label" for="password_<*$item.id*>">操作权限</label>
     <div class="controls">
    <*foreach from=$setting.actionlist item=item1 key=key1*><label class="checkbox inline"><input  name="actionlist[<*$item.id*>][]" type="checkbox" value="<*$item1*>" id="actionlist_<*$key*>_<*$key1*>" class="checkbox" <*if $item.id==1*>disabled="disabled"<*/if*> <*if in_array($item1,$item.action)*>checked="checked"<*/if*>/><*$actionname.$item1*></label><*/foreach*>
      </div>
	   </div>

      <div class="control-group">
	  <label class="control-label" >最后登录时间</label>
     <div class="controls">
         <span class="input-medium uneditable-input"><*$item.lasttime*></span>
      </div>
	   </div>
       
      <div class="control-group">
	  <label class="control-label" >登录次数</label>
     <div class="controls">
         <span class="input-medium uneditable-input"><*$item.login_num*></span>
      </div>
	   </div>

         <div class="control-group">
          <div class="controls">
			<button type="submit" class="btn btn-primary btn-large">保存新增</button>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃修改</button>
		   </div>
		</div>

       </fieldset>
  <*/foreach*>
</form>

</div>