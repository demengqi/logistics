<div id="<*$controller*>">
<*include file="<*$controller*>/location.tpl"*>

<form action="/<*$controller*>/opunit" method="post">
<table class="table">
<*if $result*>
  <tr>
    <th  class="span1">编号</th>
    <th class="span2">单位</th>
    <th>&nbsp;</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><*$item.unitid*></td>
    <td><input type="text" name="unitname[<*$item.unitid*>]" value="<*$item.unitname*>" class="input-medium" /></td>
    <td><a href="#" onclick="deleteit(<*$item.unitid*>)"><i class="icon-remove"></i></a></td>
  </tr>
  <*/foreach*>
  <*/if*>
   <tr>
    <td>新增</td>
    <td><input type="text" name="addunitname" value=""  class="input-medium" placeholder="输入单位名称"/></td>
    <td>&nbsp;</td>
  </tr> 
</table>
<input type="submit" value="保存"  class="btn btn-large btn-primary"/>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃返回</button>
</form>

</div>
<script unit="application/javascript">
function deleteit(id){
	  if(confirm("删除将不能恢复，确认要删除?")){
   window.location='/<*$controller*>/deleteunit/id/'+id;
  }

}
</script>