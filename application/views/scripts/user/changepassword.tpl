<div id="<*$controller*>">
<form action="/<*$controller*>/op<*$action*>" method="post" class="form-horizontal">
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

         <div class="control-group">
          <div class="controls">
			<button type="submit" class="btn btn-primary btn-large">保存修改</button>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃修改</button>
		   </div>
		</div>

</form>
</div>