<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
    <h2>库存查询</h2>

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
	if(confirm("停售将不能恢复，确认此操作?")){
		window.location='/<*$controller*>/delete/id/'+sGet;
	}
}
</script>

<div id="search">
<form action="/<*$controller*>/<*$action*>" method="get" class="form-inline">
<label>商品编号：<input name="goodsname" type="text" value="<*$goodsname*>" class="input-small span3"/></label>&nbsp;&nbsp;&nbsp;<label>类别：<select name="typeid"  id="type" class="input-small"> 
<option value="0" selected="selected"> 请选择 </option>
<*foreach from=$typelist item=item key=key*>
<option value="<*$key*>" <*if $key==$typeid*>selected="selected"<*/if*>><*$item*></option>
<*/foreach*>
</select></label><label>&nbsp;&nbsp;&nbsp;品牌：<select name="brandid" id="brand" class="input-small">
<option value="0" selected="selected"> 请选择 </option>
<*foreach from=$brandlist item=item key=key*>
<option value="<*$key*>" <*if $key==$brandid*>selected="selected"<*/if*>><*$item*></option>
<*/foreach*>
</select></label>
&nbsp;&nbsp;
<input type="submit" value="搜索商品"  class="btn btn-primary btn-samll"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="全部商品"  class="btn btn-primary btn-samll btn-warning" name="all"/>&nbsp;&nbsp;&nbsp;&nbsp;<small><a href="/<*$controller*>/<*$action*>">重新搜索</a></small>
</form>
<hr />
</div>
<*if $issearch*>
<*if $result*>
<!-- h5 style="float:left"><input type="button" value="修改" class="btn  btn-small btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="停售"  class="btn btn-small" onclick="return deleteit();"/></h5 -->
<table class="table table-hover table-striped table-bordered table-condensed">
  <tr>
    <th>&nbsp;</th>
    <th>商品编号</th>
    <th>商品名称</th>
    <th>单位</th>
    <th>数量</th>
    <th>进货总价</th>
    <th>零售总价</th>
  </tr>
  <*foreach from=$result item=item key=key name=foo*>
  <tr style="cursor:pointer;  <*if $item.isover*>text-decoration:line-through<*/if*>" onclick="window.location='/<*$controller*>/edit/goodsid/<*$item.goodsid*>'"  <*if $item.isover*>class="error"<*/if*>>
    <td><*$smarty.foreach.foo.iteration*><!-- input type="checkbox" name="goodsid" value="<*$item.goodsid*>" --></td>
    <td><*$item.goodsno*></td>
    <td><*$item.goodsname*></td>
    <td><*$item.unitname*></td>
    <td><*$item.goodsnum*></td>
    <td><span title="进货单价<*$item.inprice*>"><*$item.inpriceall*></span></td>
    <td><span title="零售单价<*$item.outprice*>"><*$item.outpriceall*></span></td>
  </tr>
  <*/foreach*>
    <tr>
    <th>&nbsp;</th>
    <th>合计</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th><*$sum.goodsnum*></th>
    <th><*$sum.inprice*></th>
    <th><*$sum.outprice*></th>
  </tr>

</table>
<div class="alert alert-error"><small><strong>点击商品名称可以进行商品属性的修改</strong></small></div>
<!-- h5 style="float:left"><input type="button" value="修改" class="btn  btn-small btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="停售"  class="btn btn-small" onclick="return deleteit();"/></h4 -->

<*else*>
<h1>未找到指定条件的商品库存，请更改搜索条件</h5>

<*/if*>
<*else*>
<h1><a href="/<*$controller*>/add">请先输入搜索条件</a> </h5>
<*/if*>
    </div>
  </div>
</div>
