<div class="main container" id="<*$controller*>">
  <div class="row">
 <div class="span2 bs-docs-sidebar ">
 	 
<*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >

      <form onsubmit="return checkit();" action="/<*$controller*>/opadd" method="post" class="form-horizontal" >
        <table class="table">
          <tr>
            <th  class="span2">&nbsp;</th>
            <th  colspan="3"><*$datenow*>  操作员[<*$this->_user->workid*>]</th>
          </tr>

          <tr>
            <th  class="span2">商品编号 <i class="icon-star"></i></th>
            <td colspan="3"><label><input type="text" name="goodsno" value="" class="input-xlarge" id="goodsno" placeholder="商品编号或条形码" onkeypress="getfocus(event)"/>&nbsp;<button type="button" class="btn  btn-small btn-primary" onclick="getSearch(event)">查询商品信息</button>&nbsp;<button type="button" class="btn  btn-small btn-success" onclick="addgoods()">增加新商品</button>&nbsp;<small id="readme1" class="label-warning"></small></label>
            <div id="ajax" style="text-align:left; padding-left:20px; padding-top:10px; display:none"><img src="/images/ajax_loader.gif" /></div>
</td>
          </tr>
          <tr>
            <th>商品名称 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" name="goodsname" value="" class="input-small span4" id="goodsname"  disabled="disabled"/>
              </td>
          </tr>
          <tr>
            <th>单位</th>
            <td colspan="3"><input type="text" name="unitname" value="" class="input-small" id="unitname" placeholder="" disabled="disabled"/></td>
          </tr>
          <tr>
            <th>数量 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" name="goodsnum" value="1" class="input-small" id="goodsnum" placeholder=""/></td>
            
          </tr>
          <tr>
            <th>单价 <i class="icon-star"></i></th>
            <td colspan="3"><label><input type="text" name="inprice" value="0" class="input-small " id="outprice" placeholder="采购价格"/>&nbsp;&nbsp;元&nbsp;<small id="readme2" class="label-warning"></small></label></td>
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
          <!-- div class="alert alert-error">
<strong>注意：</strong>&nbsp;&nbsp;每日同种商品只能录入一次
</div -->
        <input type="submit" value="保存入库单"  class="btn btn-large btn-primary" />
        &nbsp;&nbsp;
        <button type="button" class="btn  btn-small" onclick="window.location.reload();">重新录入</button>
      </form>

    </div>
  </div>
</div>
<script type="application/javascript">
function checkit(){
	var goodsno=document.getElementById('goodsno').value;
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
	
	if(outprice=='0'){
		document.getElementById('readme2').innerHTML='不能为空';
		isok=0;
		if(''==first)
			first='outprice';
	}else{
		document.getElementById('readme2').innerHTML='';
	}
		
	
	if(!isok){
		document.getElementById(first).focus();
		return false;
	}
	return true;
}


function addgoods(){
	var goodsno=$('#goodsno').val();
	window.location='/goods/add/goodsno/'+goodsno;
}

function checkgoods(){
	 processPost();
}

function getSearch(event){   

		 var tmpEle=document.getElementById('goodsno');
		 if(tmpEle==null){
			   tmpEle=eval('goodsno');
		 }   
		 if(tmpEle.value==null || tmpEle.value==''){
			  alert('请输入商品编号');
			  event.returnValue = false;  
			  $('#goodsno').focus(); 
			  return false;
		 }
		 
		 processPost();
	  
}  

function processPost()
{
	var url = '/ajax/checkgoods';
	var goodsno=$('#goodsno').val();
	var pars = 'goodsno='+goodsno;
	document.getElementById('ajax').style.display='block';
	var myAjax = new Ajax.Request( url, { method: 'post', parameters: pars, onComplete:showResponse_course});
}

function showResponse_course(originalRequest)
{
	document.getElementById('ajax').style.display='none';
	//alert('手动刷新天气成功！');
	window.location.reload(); 	
}


</script>