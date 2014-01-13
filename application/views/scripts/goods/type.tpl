<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span6 clearfix " >
<form action="/<*$controller*>/optype" method="post">
<table class="table">
<*if $result*>
  <tr>
    <th  class="span1">编号</th>
    <th  class="span4">分类</th>
    <th>&nbsp;</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><*$item.typeid*></td>
    <td><input type="text" name="typename[<*$item.typeid*>]" value="<*$item.typename*>" class="input-medium span3" /></td>
    <td><a href="#" onclick="deleteit(<*$item.typeid*>)"><i class="icon-remove"></i></a></td>
  </tr>
  <*/foreach*>
  <*/if*>
   <tr>
    <td>新增</td>
    <td><input type="text" name="addtypename" value=""  class="input-medium span3" placeholder="输入类别名称"/></td>
    <td>&nbsp;</td>
  </tr> 
</table>
<input type="submit" value="保存输入的信息"  class="btn btn-large btn-primary"/>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃返回</button>
</form>

    </div>
  </div>
</div>
<script type="application/javascript">
function deleteit(id){
	  if(confirm("删除将不能恢复，确认要删除?")){
   window.location='/<*$controller*>/deletetype/id/'+id;
  }

}
</script>