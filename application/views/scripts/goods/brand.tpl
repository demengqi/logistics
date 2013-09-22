<div id="<*$controller*>">
<*include file="<*$controller*>/location.tpl"*>

<form action="/<*$controller*>/opbrand" method="post">
<table class="table">
<*if $result*>
  <tr>
    <th class="span1">编号</th>
    <th class="span2">品牌</th>
    <th>&nbsp;</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><*$item.brandid*></td>
    <td><input type="text" name="brandname[<*$item.brandid*>]" value="<*$item.brandname*>" class="input-medium" /></td>
    <td><a href="#" onclick="deleteit(<*$item.brandid*>)"><i class="icon-remove"></i></a></td>
  </tr>
  <*/foreach*>
  <*/if*>
   <tr>
    <td>新增</td>
    <td><input type="text" name="addbrandname" value="" class="input-medium" placeholder="输入品牌名称"/></td>
    <td>&nbsp;</td>
  </tr> 
</table>
<input type="submit" value="保存"  class="btn btn-large btn-primary"/>&nbsp;&nbsp;<button type="button" class="btn  btn-large" onclick="history.back()">放弃返回</button>
</form>

</div>
<script brand="application/javascript">
function deleteit(id){
	  if(confirm("删除将不能恢复，确认要删除?")){
   window.location='/<*$controller*>/deletebrand/id/'+id;
  }

}
</script>