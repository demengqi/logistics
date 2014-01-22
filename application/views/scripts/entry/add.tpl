\
<div class="main container" id="<*$controller*>">
  <div class="row">
    <div class="span2 bs-docs-sidebar "> <*include file="<*$controller*>/location.tpl"*> </div>
    <div class="span10 clearfix " >
      <form onsubmit="return checkit();" action="/<*$controller*>/opadd" method="post" class="form-horizontal" >
        <table class="table">
          <tr>
            <th  class="span2">&nbsp;</th>
            <th  colspan="3"><*$datenow*>  操作员[<*$this->_user->workid*>]</th>
          </tr>
          <tr>
            <th  class="span2">商品编号 <i class="icon-star"></i></th>
            <td colspan="3"><label>
                <input type="text" name="goodsno" value="" class="input-xlarge" id="goodsno" placeholder="商品编号或条形码" onkeyup="getfocus(event)"/>
                &nbsp;
                <button type="button" class="btn  btn-small btn-primary" onclick="checkgoods(event)">查询商品信息</button>
                &nbsp;
                <button type="button" class="btn  btn-small btn-success" onclick="addgoods()">增加新商品</button>
                </label>
              <div id="ajax" style="text-align:left; padding-left:20px; padding-top:10px; display:none"><img src="/images/ajax_loader.gif" /></div>
              <small id="readme3" class="label-warning"></small>
            </td>
          </tr>
          <tr>
            <th>商品名称 <i class="icon-star"></i></th>
            <td colspan="3"><input type="text" value="" class="input-small span4" id="goodsname"  disabled="disabled"/></td>
          </tr>
          <tr>
            <th>单位</th>
            <td colspan="3"><input type="text" value="" class="input-small" id="unitname" placeholder="" disabled="disabled"/></td>
          </tr>
          <tr>
            <th>零售价</th>
            <td colspan="3"><input type="text" value="" class="input-small" id="outprice" placeholder="" disabled="disabled"/>&nbsp;&nbsp;元&nbsp;</td>
          </tr>
          <tr>
            <th>数量 <i class="icon-star"></i></th>
            <td colspan="3"><label><input type="text" name="goodsnum" value="1" class="input-small" id="goodsnum" placeholder="" onkeyup="calAll()"/></label><div><small id="readme4" class="label-warning"></small></div></td>
          </tr>
          <tr>
            <th>单价 <i class="icon-star"></i></th>
            <td colspan="3"><label>
                <input type="text" name="inprice" value="0" class="input-small " id="inprice" placeholder="采购价格" onkeyup="calAll()"/>
                &nbsp;&nbsp;元&nbsp;<small id="readme5">&nbsp;&nbsp;(进货价不能大于零售价)</small></label>
                <div><small id="readme2" class="label-warning"></small></div>
              
                </td>
          </tr>
          <tr>
            <th>合计</th>
            <td colspan="3"><label>
                <input type="text" value="0" class="input-small " id="allprice" placeholder="" disabled="disabled"/>
                &nbsp;&nbsp;元</label></td>
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
        <button type="reset" class="btn  btn-small" onclick="window.location.reload();">重新录入</button>
      </form>
    </div>
  </div>
</div>
<script type="application/javascript">
function checkit(){
	var goodsno=$('#goodsno').val().trim();
	var inprice=$('#inprice').val().trim();
	var goodsnum=$('#goodsnum').val().trim();
	var outprice=$('#outprice').val();
	
	var isok=1;
	var first='';
	$('#readme3').html('');
	$('#readme2').html('');
	$('#readme4').html('');
	
	if(goodsno==''){
		$('#readme3').html('不能为空');
		isok=0;
		first='goodsno';
	}

	if(goodsnum=='0' || goodsnum==''){
		$('#readme4').html('不能为0');
		
		isok=0;
		if(''==first)
			first='goodsnum';
	}
	
	if(inprice=='0' || inprice==''){
		$('#readme2').html('不能为0');
		
		isok=0;
		if(''==first)
			first='inprice';
	}
	
	if(Number(outprice)<Number(inprice)){
		$('#readme2').html('进货价不能高于零售价'+outprice+'元');
		
		isok=0;
		if(''==first)
			first='inprice';

	}

	 
	if(!isok){
		document.getElementById(first).focus();
		document.getElementById(first).select();
		
		return false;
	}
	 checkgoods();
	 calAll();
	 
	if(confirm("保存后将不能更改确定保存?")){
		return true;
	}else
		return false;
	
}


function addgoods(){
	var goodsno=$('#goodsno').val();
	window.location='/goods/add/goodsno/'+goodsno;
}

function getfocus(event){   
	e = event ? event :(window.event ? window.event : null);

    if(e.keyCode==13){
		 var tmpEle=document.getElementById('goodsno');
		 if(tmpEle==null){
			   tmpEle=eval('goodsno');
		 }   
		 if(tmpEle.value==null || tmpEle.value==''){
			 $('#readme3').html('请输入商品编号');
			  $('goodsno').focus(); 
			  event.returnValue = false;  
			  return false;
		 }
		 
		 checkgoods(event);

	}
	  
}  

function calAll(){
	var  goodsnum = $('#goodsnum').val();
	var  inprice = $('#inprice').val() ;
	var allprice =Number(goodsnum)*Number(inprice);
	$('#allprice').val(Number(allprice).toFixed(2));
}


function checkgoods(event){   

		 var tmpEle=document.getElementById('goodsno');
		 if(tmpEle==null){
			   tmpEle=eval('goodsno');
		 }   
		 if(tmpEle.value==null || tmpEle.value.trim()==''){
			$('#readme3').html('请输入商品编号');
			  event.returnValue = false;  
			  $('#goodsno').focus(); 
			  return false;
		 }
		 
		var url = '/ajax/checkgoods';
		var postdata = '';
		document.getElementById('ajax').style.display='block';
		//document.getElementById('readme2').innerHTML='';
		$('#readme3').html('');
		//var myAjax = new Ajax.Request( url, { method: 'post', parameters: pars, onComplete:showResponse_course});
	
		$.post(url,{goodsno:$('#goodsno').val().trim()},function(data){
			document.getElementById('ajax').style.display='none';
			
			if(data == -1){
				$('#readme3').html('系统方法错误');
				event.returnValue = false;  
			}else if(data == -2){
				$('#readme3').html('输入不能为空');
				event.returnValue = false;  
			}else if(data == -3){
			//	alert('基本信息中无此编号的商品');
				$('#readme3').html('无此编号的商品，请先添加商品信息');
				event.returnValue = false;  
				
			}else{
				//alert(data);
				var jsonArray =eval('(' + data + ')'); 
			//	alert(jsonArray.result);
				if(jsonArray.count==1){
					//var result =eval('(' + jsonArray.result + ')'); 
					//alert(result);
					$('#goodsname').val(jsonArray.result[0].goodsname);
					$('#unitname').val(jsonArray.result[0].unitname);
					$('#outprice').val(jsonArray.result[0].outprice);
					
				}else{
					$('#readme3').html('多于一个商品，请确认');
				}
				
			}
			//
		 });

	  
}  

window.onload=function(){
	//checkgoods(event);
	calAll();
}

</script>