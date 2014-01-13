<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >

      <form onsubmit="return checkit();" action="/<*$controller*>/opadd" method="post" class="form-horizontal" >
        <table class="table">
          <tr>
            <th  class="span2">&nbsp;</th>
            <th  colspan="3"><*$datenow*></th>
          </tr>

          <tr>
            <th  class="span2">商品编号 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" name="goodsno" value="" class="input-xlarge" id="goodsno" placeholder="商品编号或条形码"/>&nbsp;<button type="button" class="btn  btn-small btn-primary" onclick="javascript:;">查询商品信息</button>
              <small id="readme1" class="label-warning"></small></td>
          </tr>
          <tr>
            <th>商品名称 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" name="goodsname" value="" class="input-small span4" id="goodsname"  disabled="disabled"/>
              <small id="readme2" class="label-warning"></small></td>
          </tr>
          <tr>
            <th>单位</th>
            <td colspan="3"><input type="text" name="unitname" value="" class="input-small" id="unitname" placeholder="" disabled="disabled"/></td>
          </tr>
          <tr>
            <th>数量 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" name="goodnum" value="" class="input-small" id="goodnum" placeholder=""/></td>
            
          </tr>
          <tr>
            <th>单价 <i class="icon-star"></i></th>
            <td colspan="3"><label><input type="text" name="inprice" value="" class="input-small " id="outprice" placeholder="采购价格"/>&nbsp;&nbsp;元</label></td>
          </tr>
          <tr>
            <th>合计</th>
            <td colspan="3"><label><input type="text" name="allprice" value="" class="input-small " id="allprice" placeholder="" disabled="disabled"/>&nbsp;&nbsp;元</label></td>
          </tr>
          <tr>
            <th>备注</th>
            <td colspan="3"><input type="text" name="memo" value="" class="input-small span6" id="memo" placeholder="输入备注信息"/></td>
          </tr>
        </table>
          <div class="alert alert-error">
<strong>注意：</strong>&nbsp;&nbsp;每日同种商品只能录入一次
</div>
        <input type="submit" value="保存入库单"  class="btn btn-large btn-primary"/>
        &nbsp;&nbsp;
        <button type="button" class="btn  btn-small" onclick="window.location.reload();">重新录入</button>
      </form>

    </div>
  </div>
</div>
<script type="application/javascript">
function checkit(){
	var goodsno=document.getElementById('goodsno').value;
	var goodsname=document.getElementById('goodsname').value;
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
		
	
	if(!isok){
		document.getElementById(first).focus();
		return false;
	}
	return true;
}
</script>