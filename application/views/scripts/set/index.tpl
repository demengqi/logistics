
<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >

<form action="/<*$controller*>/op" method="post" class="form-horizontal">
  <*foreach from=$settinglist item=item key=key*>
      <div class="control-group">
	  <label class="control-label" for="<*$key*>"><*$item.readme*></label>
     <div class="controls">
     <input type="text" name="old[<*$key*>]" value="<*$item.value*>" class="input-xlarge" id="<*$key*>" placeholder="输入内容" /> <label class="help-inline"><i class="icon-edit"></i> <*$key*></label>
       </div>
	   </div>
  <*/foreach*>
         <div class="control-group">
          <div class="controls">
			<button type="submit" class="btn btn-primary btn-large">保存修改</button>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃修改</button>
		   </div>
		</div>
  <!-- hr />
  <fieldset>
        <div class="control-group">
	  <label class="control-label" for="<*$key*>">字段变量</label>
     <div class="controls">
     <input type="text" name="new[key]" value=""  class="input-medium" id="<*$key*>" placeholder="输入字段变量" /> <label class="help-inline"><i class="icon-edit"></i> 无重复英文</label>
       </div>
	   </div>

        <div class="control-group">
	  <label class="control-label" for="<*$key*>">设置值</label>
     <div class="controls">
     <input type="text" name="new[value]" value=""  class="input-xlarge" id="<*$key*>" placeholder="输入设置值" /> <label class="help-inline"></label>
       </div>
	   </div>

        <div class="control-group">
	  <label class="control-label" for="<*$key*>">说明</label>
     <div class="controls">
     <input type="text" name="new[readme]" value=""  class="input-xlarge" id="<*$key*>" placeholder="输入说明" /> <label class="help-inline"><i class="icon-edit"></i> 输入中文说明</label>
       </div>
	   </div>
         <div class="control-group">
          <div class="controls">
			<button type="submit" class="btn btn-primary btn-large">保存新增</button>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃修改</button>
		   </div>
		</div>

  </fieldset -->


</form>

    </div>
  </div>
</div>
