
<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >

<div id="search">
<form action="/<*$controller*>/<*$action*>" method="get" class="form-inline">
<label><input name="goodsno" type="text" value="<*$goodsno*>" class="input-small span3"  placeholder="商品编号或名称"/></label>
&nbsp;&nbsp;
<input type="submit" value="搜索商品"  class="btn btn-primary btn-samll"/>&nbsp;&nbsp;&nbsp;&nbsp;<small><a href="/<*$controller*>/<*$action*>">重新搜索</a></small>
</form>
<hr />
</div>
<*if $result*>
<div style="float:left"><input type="button" value="修改" class="btn  btn-small btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="删除"  class="btn btn-small" onclick="return deleteit();"/></div>
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
    <th>数量</th>
    <th>零售价</th>
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
    <td><*$item.outprice*></td>
    <td><*$item.guige*></td>
    <td><*$item.memo*></td>
  </tr>
  <*/foreach*>
</table>
<div style="float:left"><input type="button" value="修改" class="btn  btn-small btn-primary" onclick="return editit();" />
&nbsp;&nbsp;<input type="button"  value="删除"  class="btn btn-small" onclick="return deleteit();"/></div>
<*$page*>

<*else*>
<h1><a href="/<*$controller*>/add">没有任何入库单 ,请先添加入库单</a> </h1>
<*/if*>
    </div>
  </div>
</div>
