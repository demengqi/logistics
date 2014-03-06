<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
        <h2>修改商品: <*$result.goodsname*>(<*$result.goodsno*>)</h2>

      <form onsubmit="return checkit();" action="/<*$controller*>/opedit" method="post"  class="form-horizontal" >
        <table class="table">
          <tr>
            <th  class="span2">商品编号 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text"   value="<*$result.goodsno*>" class="input-xlarge readonly" id="goodsno" placeholder="商品编号或条形码" readonly/>
             &nbsp;&nbsp;<button type="button" class="btn  btn-small btn-success" onclick="window.location='/<*$controller*>/entryadd/goodsno/<*$result.goodsno*>'">增加进货单</button></td>
          </tr>
          <tr>
            <th>商品名称 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text"   value="<*$result.goodsname*>" class="input-xlarge readonly" id="goodsname"  placeholder="商品名称" readonly/></td>
          </tr>
          <tr>
            <th>销售价格</th>
            <td colspan="3"><label><input type="text" name="outprice" value="<*$result.outprice*>" class="input-small span2" id="outprice" placeholder="零售价"/>&nbsp;&nbsp;元 <small id="readme3" class="label-warning"></small></label></td>
          </tr>
          <tr>
            <th>零售价</th>
            <td colspan="3">&yen; <strong class="text-info"><*$result.inprice*></strong> 元，现有数量是 <strong class="text-info"><*$result.goodsnum*></strong> ，进货价格及数量在进货单中录入</small> </td>
          </tr>
          
          
          <tr>
            <th>单位</th>
            <td class="span3"><select name="unitid" id="unit" >
                <option value="0" selected="selected">选择单位</option>
                    <*foreach from=$unitlist item=item1 key=key1*>
                    <option value="<*$key1*>" <*if $result.unitid== $key1*>selected="selected"<*/if*>><*$item1*></option>
                    <*/foreach*>
              </select></td>
            <th class="span2">规格或颜色</th>
            <td><input type="text" name="guige" value="<*$result.guige*>" class="input-small"  id="guige" placeholder="规格或颜色"/></td>
          </tr>
          <tr>
            <th>类别</th>
            <td><select name="typeid"  id="type">
                <option value="0" selected="selected"> 请选择类别 </option>
                    <*foreach from=$typelist item=item1 key=key1*>
                    <option value="<*$key1*>" <*if $result.typeid== $key1*>selected="selected"<*/if*>><*$item1*></option>
                    <*/foreach*>
              </select></td>
            <th>型号或尺码</th>
            <td><input type="text" name="xinghao" value="<*$result.xinghao*>" class="input-small" id="xinghao" placeholder="型号或尺码"/></td>
          </tr>
          <tr>
            <th>品牌</th>
            <td><select name="brandid" id="brand" >
                <option value="0" selected="selected"> 请选择品牌 </option>
                    <*foreach from=$brandlist item=item1 key=key1*>
                    <option value="<*$key1*>" <*if $result.brandid== $key1*>selected="selected"<*/if*>><*$item1*></option>
                    <*/foreach*>
              </select></td>
            <th>货号</th>
            <td><input type="text" name="huohao" value="<*$result.huohao*>" class="input-small" id="huohao" placeholder="货号"/></td>
          </tr>
          <tr>
            <th>备注</th>
            <td colspan="3"><input type="text" name="memo" value="<*$result.memo*>" class="input-xxlarge" id="memo" placeholder="输入备注信息"/></td>
          </tr>
          <tr>
            <th>&nbsp;</th>
            <td colspan="3"><label><input type="checkbox" class="checkbox btn-large" value="1" name="isover" <*if $result.isover*>checked<*/if*> />&nbsp;该商品停售</label></td>
          </tr>
        </table>
        <input type="submit" value="保存修改的商品信息"  class="btn btn-large btn-primary"/>
        &nbsp;&nbsp;
        <button type="button" class="btn  btn-large btn-success" onclick="window.location='/<*$controller*>/entryadd/goodsno/<*$result.goodsno*>'">增加进货单</button>&nbsp;&nbsp;
        <button type="button" class="btn  btn-large" onclick="window.history.back();">返回列表</button>
        <input type="hidden" name="goodsid" value="<*$result.goodsid*>"/>
      </form>
    </div>
  </div>
</div>
<script type="application/javascript">
function checkit(){
	var outprice=document.getElementById('outprice').value;
	var isok=1;
	var first='';
	if(outprice==''){
		document.getElementById('readme3').innerHTML='零售价不能为空';
		isok=0;
		if(''==first)
			first='outprice';
	}else{
		document.getElementById('readme3').innerHTML='';
	}
		
	
	if(!isok){
		document.getElementById(first).focus();
		return false;
	}
	return true;
}
</script>
