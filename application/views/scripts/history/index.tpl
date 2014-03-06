<div class="main container" id="<*$controller*>">
  <h2>日结单（<*$nowday*>） -- <*$current_username*></h2>
  <*if !$result*>
  <div class="alert alert-error"> <strong><a href="/sail" class="text-error">当日还没有任何销售记录，返回销售</a></strong> </div>
  <*else*>
  <table class="table table-hover table-bordered table-condensed span6 clearfix">
    <tr>
      <th>商品编号</th>
      <th>商品名称(单位)</th>
      <th>商品数量</th>
      <th>单价</th>
      <th>应收</th>
      <th>实收</th>
    </tr>
    <*foreach from=$result item=item key=key*>
    <*foreach from=$item.goodslist item=item1 key=key1 name=foo*>
        <tr <*if $item1.truepriceall<>$item1.priceall*>class="error" <*/if*>>
          <td><*$item1.goodsno*></td>
          <td><*$item1.goodsname*>(<*$item1.unitname*>)</td>
          <td><*$item1.goodsnum*></td>
          <td><*$item1.outprice*></td>
          <td><*$item1.truepriceall*></td>
          <td><*$item1.priceall*></td>
        </tr>
    <*/foreach*>

    <*/foreach*>
    <tr class="info">
      <td colspan="2">合计</td>
      <td><*$sum.sailnum*></td>
      <td>&nbsp;</td>
      <td><*$sum.yingshou*></td>
      <td><*$sum.shishou*></td>
    </tr>
  </table>
  
    <dl class="dl-horizontal span8">
  <dt>截至时间：</dt><dd><*$printdatetime*></dd>
  <dt>现金收取：</dt><dd><*$sum.cash*>元</dd>
  <dt>刷卡收取：</dt><dd><*$sum.card*>元</dd>
  <dt>&nbsp;</dt><dd>&nbsp;</dd>
  <dt>&nbsp;</dt><dd><*$current_username*> (<*$nowday*>)</dd>

 </dl> 
 
  <*/if*> </div>
