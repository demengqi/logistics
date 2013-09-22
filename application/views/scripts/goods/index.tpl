<div id="<*$controller*>">
<script language='JavaScript' type='text/JavaScript'>

function editit(){
	var sValue = 0;
	var sGet = '0';

	var tmpels = document.getElementsByName('goodsid');
	for(var i=0;i<tmpels.length;i++){
	  if(tmpels[i].checked){
	   sValue += 1;
	   sGet = sGet+','+tmpels[i].value;
	  }
	  
	}

	
	if(sValue==0){
		alert('没有任何选择');
		return false;
	}
	
	
		window.location='/<*$controller*>/edit/id/'+sGet;
	
}


function deleteit(){
	var sValue = 0;
	var sGet = '0';

	var tmpels = document.getElementsByName('goodsid');
	for(var i=0;i<tmpels.length;i++){
	  if(tmpels[i].checked){
	   sValue += 1;
	   sGet = sGet+','+tmpels[i].value;
	  }
	  
	}

	
	if(sValue==0){
		alert('没有任何选择');
		return false;
	}
	if(confirm("删除将不能恢复，确认要删除?")){
		window.location='/<*$controller*>/delete/id/'+sGet;
	}
}
</script>

<*include file="<*$controller*>/location.tpl"*>
<div id="search">
<form action="/<*$controller*>/<*$action*>" method="get" class="form-inline">
商品编号:<input name="goodsname" type="text" value="<*$goodsname*>" class="input-small"/>&nbsp;类别：<select name="typeid"  id="type">
<option value="0" selected="selected"> 请选择 </option>
<*foreach from=$typelist item=item key=key*>
<option value="<*$key*>" <*if $key==$typeid*>selected="selected"<*/if*>><*$item*></option>
<*/foreach*>
</select>&nbsp;品牌：<select name="brandid" id="brand">
<option value="0" selected="selected"> 请选择 </option>
<*foreach from=$brandlist item=item key=key*>
<option value="<*$key*>" <*if $key==$brandid*>selected="selected"<*/if*>><*$item*></option>
<*/foreach*>
</select>

<input type="submit" value="搜索"  class="btn btn-primary"/>&nbsp;<a href="/<*$controller*>/<*$action*>">重新搜索</a>
</form>
</div>
<*if $result*>
<div class="c1"><input type="button" value="修改" class="btn  btn-large btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="删除"  class="btn btn-large" onclick="return deleteit();"/></div>
<*$page*>
<table class="table">
  <tr>
    <th>&nbsp;</th>
    <th>商品编号</th>
    <th>商品名称</th>
    <th>单位</th>
    <th>类别</th>
    <th>品牌</th>
    <th>型号</th>
    <th>货号</th>
    <th>商品数量</th>
    <th>规格</th>
    <th>备注</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><input type="checkbox" name="goodsid" value="<*$item.goodsid*>"></td>
    <td><*$item.goodsno*></td>
    <td><*$item.goodsname*></td>
    <td><*$item.unit*></td>
    <td><*$item.type*></td>
    <td><*$item.brand*></td>
    <td><*$item.xinghao*></td>
    <td><*$item.huohao*></td>
    <td><*$item.goodsnum*></td>
    <td><*$item.guige*></td>
    <td><*$item.memo*></td>
  </tr>
  <*/foreach*>
</table>
<*$page*>
<div class="c1"><input type="button" value="修改" class="btn  btn-large btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="删除"  class="btn btn-large" onclick="return deleteit();"/></div>
<*else*>
<h1><a href="/<*$controller*>/add">没有任何商品 ,请先添加商品</a> </h1>
<*/if*>
</div>