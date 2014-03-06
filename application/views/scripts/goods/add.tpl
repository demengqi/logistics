<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
        <h2>添加新商品</h2>

      <form onsubmit="return checkit();" action="/<*$controller*>/opadd" method="post" class="form-horizontal" >
        <table class="table">
          <tr class="text-error">
            <th  class="span2 ">商品编号 <i class="icon-star"></i></th>
            <td colspan="3"><label class="control-group error"><input type="text" name="goodsno" value="<*$goodsno*>" class="input-xlarge" id="goodsno" placeholder="商品编号或条形码"/>
              <small id="readme1" class="label-warning"></small></label>
              <small class="text-info">保存后将不能修改</small>
              </td>
          </tr>
          <tr class="text-error">
            <th>商品名称 <i class="icon-star"></i></th>
            <td colspan="3"><label class="control-group error"><input type="text" name="goodsname" value="" class="input-xlarge" id="goodsname"  placeholder="商品名称"/>
              <small id="readme2" class="label-warning"></small></label>
              <small class="text-info">保存后将不能修改</small>
              </td>
          </tr>
          <tr class="text-error">
            <th>销售价格 <i class="icon-star"></i></th>
            <td colspan="3"><label class="control-group error"><input type="text" name="outprice" value="" class="input-small span2" id="outprice" placeholder="零售价"/>&nbsp;&nbsp;元 <small id="readme3" class="label-warning"></small></label> 
            </td>
          </tr>
          
          <tr>
            <th>单位</th>
            <td class="span3"><select name="unitid" id="unit" >
                <option value="0" selected="selected">选择单位</option>
                <*foreach from=$unitlist item=item key=key*>
                <option value="<*$key*>"><*$item*></option>
                <*/foreach*>
              </select></td>
            <th class="span2">规格或颜色</th>
            <td><input type="text" name="guige" value="" class="input-small"  id="guige" placeholder="规格或颜色"/></td>
          </tr>
          <tr>
            <th>类别</th>
            <td><select name="typeid"  id="type">
                <option value="0" selected="selected"> 请选择类别 </option>
                <*foreach from=$typelist item=item key=key*>
                <option value="<*$key*>"><*$item*></option>
                <*/foreach*>
              </select></td>
            <th>型号或尺码</th>
            <td><input type="text" name="xinghao" value="" class="input-small" id="xinghao" placeholder="型号或尺码"/></td>
          </tr>
          <tr>
            <th>品牌</th>
            <td><select name="brandid" id="brand" >
                <option value="0" selected="selected"> 请选择品牌 </option>
                <*foreach from=$brandlist item=item key=key*>
                <option value="<*$key*>"><*$item*></option>
                <*/foreach*>
              </select></td>
            <th>货号</th>
            <td><input type="text" name="huohao" value="" class="input-small" id="huohao" placeholder="货号"/></td>
          </tr>
          <tr>
            <th>备注</th>
            <td colspan="3"><input type="text" name="memo" value="" class="input-xxlarge" id="memo" placeholder="输入备注信息"/></td>
          </tr>
        </table>
        <input type="submit" value="保存商品信息"  class="btn btn-large btn-primary"/>
        &nbsp;&nbsp;
        <button type="button" class="btn  btn-large" onclick="window.location='/<*$controller*>/<*$action*>'">重新录入</button>
      </form>
    </div>
  </div>
</div>
<script type="application/javascript">
function checkit(){
	var goodsno=document.getElementById('goodsno').value;
	var goodsname=document.getElementById('goodsname').value;
	var outprice=document.getElementById('outprice').value;
	var isok=1;
	var first='';
	if(goodsno==''){
		document.getElementById('readme1').innerHTML='不能为空';
		isok=0;
		first='goodsno';
	}else{
		document.getElementById('readme1').innerHTML='';
	}
	if(goodsname==''){
		document.getElementById('readme2').innerHTML='不能为空';
		isok=0;
		if(''==first)
			first='goodsname';
	}else{
		document.getElementById('readme2').innerHTML='';
	}
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