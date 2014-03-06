<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span6 clearfix " >
    <h2>单位管理</h2>

<form action="/<*$controller*>/opunit" method="post">
<table class="table">
<*if $result*>
  <tr>
    <th  class="span1">编号</th>
    <th class="span4">单位</th>
    <th>&nbsp;</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><*$item.unitid*></td>
    <td><input type="text" name="unitname[<*$item.unitid*>]" value="<*$item.unitname*>" class="input-medium span3" /></td>
    <td><a href="#" onclick="deleteit(<*$item.unitid*>)"><i class="icon-remove"></i></a></td>
  </tr>
  <*/foreach*>
  <*/if*>
   <tr>
    <td>新增</td>
    <td><input type="text" name="addunitname" value=""  class="input-medium span3" placeholder="输入单位名称"/></td>
    <td>&nbsp;</td>
  </tr> 
</table>
<input type="submit" value="保存输入的信息"  class="btn btn-large btn-primary"/>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃返回</button>
</form>

    </div>
  </div>
</div>
<script unit="application/javascript">
function deleteit(id){
	  if(confirm("删除将不能恢复，确认要删除?")){
   window.location='/<*$controller*>/deleteunit/id/'+id;
  }

}
</script>