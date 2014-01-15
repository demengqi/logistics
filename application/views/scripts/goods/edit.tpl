<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
<form onsubmit="return checkit();" action="/<*$controller*>/opedit" method="post" >
<style type="text/css">
dt{ position: absolute; z-index:10; float:left; width:150px; text-align:right}
dd{ padding-left:155px; margin-bottom:6px;}
</style>
<*foreach from=$result item=item key=key*>
<input type="hidden" name="goodsid[<*$item.goodsid*>]" value="<*$item.goodsid*>"d/>
<dl>
<dt>商品编号或条形码<span class="red">*</span></dt>
<dd><input type="text" readonly="readonly" disabled="disabled" name="goodsno[<*$item.goodsid*>]" value="<*$item.goodsno*>" class="txt" id="goodsno<*$key*>"/><span id="readme1_<*$key*>" class="red"></span></dd>
<dt>商品名称<span class="red">*</span></dt>
<dd><input type="text" name="goodsname[<*$item.goodsid*>]" value="<*$item.goodsname*>" class="txt" id="goodsname<*$key*>"/><span id="readme2_<*$key*>" class="red"></span></dd>
<dt>&nbsp;</dt>
<dd><label class="checkbox"><input type="checkbox" name="isover[<*$item.goodsid*>]" value="1" id="isover<*$key*>" <*if $item.isover*> checked="checked"<*/if*>/> 停售</label></dd>

<dt>单位</dt>
<dd><select name="unitid[<*$item.goodsid*>]" id="unit<*$key*>">
<option value="0" selected="selected"> 请选择单位 </option>
<*foreach from=$unitlist item=item1 key=key1*>
<option value="<*$key1*>" <*if $item.unitid== $key1*>selected="selected"<*/if*>><*$item1*></option>
<*/foreach*>
</select>
</dd>
<dt>类别</dt>
<dd><select name="typeid[<*$item.goodsid*>]"  id="type<*$key*>">
<option value="0" selected="selected"> 请选择类别 </option>
<*foreach from=$typelist item=item1 key=key1*>
<option value="<*$key1*>" <*if $item.typeid== $key1*>selected="selected"<*/if*>><*$item1*></option>
<*/foreach*>
</select></dd>
<dt>品牌</dt>
<dd><select name="brandid[<*$item.goodsid*>]" id="brand<*$key*>">
<option value="0" selected="selected"> 请选择品牌 </option>
<*foreach from=$brandlist item=item1 key=key1*>
<option value="<*$key1*>" <*if $item.brandid== $key1*>selected="selected"<*/if*>><*$item1*></option>
<*/foreach*>
</select></dd>
<dt>型号或尺码</dt>
<dd><input type="text" name="xinghao[<*$item.goodsid*>]" value="<*$item.xinghao*>" class="txt" id="xinghao<*$key*>" /></dd>
<dt>货号</dt>
<dd><input type="text" name="huohao[<*$item.goodsid*>]" value="<*$item.huohao*>" class="txt" id="huohao<*$key*>" /></dd>
<dt>商品数量</dt>
<dd><*$item.goodsnum*></dd>
<dt>零售价</dt>
<dd><input type="text" name="outprice[<*$item.goodsid*>]" value="<*$item.outprice*>" class="txt" id="outprice<*$key*>" /></dd>
<dt>规格或颜色</dt>
<dd><input type="text" name="guige[<*$item.goodsid*>]" value="<*$item.guige*>" class="txt"  id="guige<*$key*>"/></dd>
<dt>备注</dt>
<dd><input type="text" name="memo[<*$item.goodsid*>]" value="<*$item.memo*>" class="txt" id="memo<*$key*>"/></dd>
<dt>&nbsp;</dt>
<dd><input type="submit" value="保存"  class="btn"/>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/<*$controller*>">返回商品列表</a></dd>
</dl>
<hr />
<*/foreach	*>
</form>
    </div>
  </div>
</div>

<script type="application/javascript">
function checkit(){
	for(var i=0;i<<*$num*>; i++){
	var goodsno=document.getElementById('goodsno'+i).value;
	var goodsname=document.getElementById('goodsname'+i).value;
	var price=document.getElementById('price'+i).value;
	var isok=1;
	var first='';
	if(goodsno==''){
		document.getElementById('readme1_'+i).innerHTML='不能为空';
		isok=0;
		first='goodsno'+i;
	}else{
		document.getElementById('readme1_'+i).innerHTML='';
	}
	if(goodsname==''){
		document.getElementById('readme2_'+i).innerHTML='不能为空';
		isok=0;
		if(''==first)
			first='goodsname'+i;
	}else{
		document.getElementById('readme2_'+i).innerHTML='';
	}
		if(price==''){
		document.getElementById('readme3_'+i).innerHTML='不能为空';
		isok=0;
				if(''==first)
			first='price'+i;

	}else{
		document.getElementById('readme3_'+i).innerHTML='';
	}
	
	if(!isok){
		document.getElementById(first).focus();
		return false;
	}
	
	}
	return true;
}
</script>