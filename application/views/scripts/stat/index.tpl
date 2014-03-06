
<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >

<div id="search">
<form action="/<*$controller*>/<*$action*>" method="get" class="form-inline">
<script language="javascript" type="text/javascript" src="/js/DatePicker/WdatePicker.js"></script>
开始日期：<input type="text" class="Wdate" id="start_date" onclick="WdatePicker()" style="width:110px"  name="start_date" class="Wdate" value="<*$start_date*>" autocomplete="off"/> 
                   ~  结束日期：<input type="text" class="Wdate" id="end_date" onclick="WdatePicker()" style="width:110px"  name="end_date" class="Wdate" value="<*$end_date*>" autocomplete="off"/>  
<label><input name="goodsno" type="text" value="<*$goodsno*>" class="input-small span3"  placeholder="商品编号或名称"/></label>
&nbsp;&nbsp;
<input type="submit" value="搜索商品"  class="btn btn-primary btn-samll"/>&nbsp;&nbsp;&nbsp;&nbsp;<small><a href="/<*$controller*>/<*$action*>">重新搜索</a></small>
</form>
<hr />
</div>
<*if $result*>
<h2>销售统计时间段：<*$start_date*> ~ <*$end_date*></h2>
<table class="table table-hover table-striped table-bordered table-condensed ">
  <tr>
    <th>&nbsp;</th>
    <th>商品编号</th>
    <th>商品名称</th>
    <th>单位</th>
    <th>数量</th>
    <!-- th>成本</th>
    <th>应收款</th -->
    <th>实收款</th>
    <th>利润</th>
  </tr>
  <*foreach from=$result item=item key=key name=foo*>
  <tr>
    <td><*$smarty.foreach.foo.iteration*></td>
    <td><*$item.goodsno*></td>
    <td><*$item.goodsname*></td>
    <td><*$item.unitname*></td>
    <td><*$item.goodsnum*></td>
    <!-- td><*$item.inprice*></td>
    <td><*$item.trueprice*></td -->
    <td><*$item.price*></td>
    <td><*$item.lirun*></td>
  </tr>
  <*/foreach*>
  <tr>
    <th>&nbsp;</th>
    <th>合计</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th><*$sum.goodsnum*></th>
    <!-- th><*$sum.inprice*></th>
    <th><*$sum.trueprice*></th -->
    <th><*$sum.price*></th>
    <th><*$sum.lirun*></th>
  </tr>
  
</table>

<*elseif $goodsno || $start_date*>
<h1><a href="/<*$controller*>/<*$action*>">搜索结果不存在，请更换搜索条件</a> </h1>

<*else*>
<h1>先输入搜索条件 </h1>
<*/if*>
    </div>
  </div>
</div>
