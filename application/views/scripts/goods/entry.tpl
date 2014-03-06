
<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
<h2>进货单查询</h2>
<div id="search">
<form action="/<*$controller*>/<*$action*>" method="get" class="form-inline">
<label><input name="goodsno" type="text" value="<*$goodsno*>" class="input-small span3"  placeholder="商品编号或名称"/></label>
&nbsp;&nbsp;
<input type="submit" value="搜索商品"  class="btn btn-primary btn-samll"/>&nbsp;&nbsp;&nbsp;&nbsp;<small><a href="/<*$controller*>/<*$action*>">重新搜索</a></small>
</form>
<hr />
</div>
<*if $result*>
<*$page*>
<table class="table table-hover table-striped table-bordered table-condensed">
  <tr>
    <th>采购日期</th>
    <th>商品编号</th>
    <th>商品名称</th>
    <th>单位</th>
    <th>数量</th>
    <th>单价</th>
    <th>合计</th>
  </tr>
  <*foreach from=$result item=item key=key*>
  <tr>
    <td><*$item.adddate*></td>
    <td><*$item.goodsno*></td>
    <td><*$item.goodsname*></td>
    <td><*$item.unitname*></td>
    <td><*$item.goodsnum*></td>
    <td><*$item.inprice*></td>
    <td><*$item.inprice*$item.goodsnum*></td>
  </tr>
  <*/foreach*>
</table>
<*$page*>

<*elseif $goodsno*>
<h1><a href="/<*$controller*>/<*$action*>">搜索结果不存在，请重新搜索</a> </h1>

<*else*>
<h1><a href="/<*$controller*>/add">没有任何入库单 ,请先添加入库单</a> </h1>
<*/if*>
    </div>
  </div>
</div>
