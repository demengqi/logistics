<div id="<*$controller*>" class="span10">
  <form action="/<*$controller*>/saveorder" method="post" class="form-horizontal" onsubmit="return saveit();">
    <div class="form-inline">
          <label>单据编号：
            <input name="orderno" class="input-small uneditable-input span2 disabled" value="<*$orderno*>">
          </label>
       &nbsp;<label>操作员：
          <input name="adduserid" class="input-small uneditable-input span2 disabled" value="<*$this->_user->workid*>"></label>
        &nbsp;<label>日期：
          <input name="day" class="input-small uneditable-input span2 disabled" value="<*$date*>"></label>
       </div>
       
      <table id="tb1" class="table table-striped table-bordered table-hover" >
        <tbody id="tbody1">
          <tr>
            <th>编号</th>
            <th>名称</th>
            <th>单位</th>
            <th>数量</th>
            <th>品牌</th>
            <th>型号(尺码)</th>
            <th>售价</th>
            <th>合计</th>
            <th>&nbsp;</th>
          </tr>
        </tbody>
      </table>
      <p style="text-align:right;">
    <strong> 合计数量 ：<span id="allnum">0</span> &nbsp;&nbsp;&nbsp; 应收金额：&yen;<span id="alltrueprice">0</span>&nbsp;&nbsp;&nbsp;
    实收金额：<span style="color:#F30">&yen;<span id="allprice" >0</span></span></strong>&nbsp;&nbsp;&nbsp;
      <button class="btn btn-success" onclick="shoukuan();" id="shoukuanbtn" disabled="disabled" type="button"/><i class="icon-pencil icon-white"></i> 确认&收款 </button>
    </p>
    
     <!-- div class="alert alert-error"><small><strong>注意：</strong>&nbsp;&nbsp;说明：数量必须大于0</small></div -->
<div id="total" class="text-right">
<small id="readme3" class="label-warning"></small>     <input  type="text" class="input-xlarge"  placeholder="商品编号或条形码"  value="" id="goodsno" onkeyup="getfocus(event)"/> <button class="btn btn-primary" id="searchBtn" onclick="checkgoods(event)" type="button"><i class="icon-search icon-white"></i> 输入商品编号</button>
<div style="text-align:right; padding-right:40px;  height:13px;"><div id="ajax" style="display:none;" ><img src="/images/ajax_loader.gif" /></div></div>
</div>
    <script type="text/javascript" >
var maxArray=new Array()
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
			  $('#goodsno').focus(); 
			  $('#goodsno').select(); 

				event.returnValue = false;  
				  return false;
				
			}else if(data == -2){
				$('#readme3').html('输入不能为空');
				event.returnValue = false;  
				  return false;
				
			}else if(data == -3){
			//	alert('基本信息中无此编号的商品');
				$('#readme3').html('无此编号的商品，请先添加商品信息');
				event.returnValue = false;  
			  $('#goodsno').focus(); 
			  $('#goodsno').select(); 
 						  return false;
				
			}else{
				//alert(data);
				var jsonArray =eval('(' + data + ')'); 
			//	alert(jsonArray.result);
				if(jsonArray.count==1){
					//var result =eval('(' + jsonArray.result + ')'); 
					//alert(result);
					
					//缺货
					if(jsonArray.result[0].goodsnum<=0){
						$('#readme3').html('该商品没有库存，不能销售');
							event.returnValue = false;  
						  $('#goodsno').focus(); 
						  $('#goodsno').select(); 
						  return false;
			  		}
					if(jsonArray.result[0].isover==1){
						$('#readme3').html('该商品已停售');
							event.returnValue = false;  
						  $('#goodsno').focus(); 
						  $('#goodsno').select(); 
 						  return false;
			  		}					
					
					var  tabObj = document.getElementById("tbody1");
					
					var tdcontent='<tr>';
					tdcontent +='<td>'+jsonArray.result[0].goodsno+'</td>';
					tdcontent +='<td>'+jsonArray.result[0].goodsname+'</td>';
					tdcontent +='<td>'+jsonArray.result[0].unitname+'</td>';
					tdcontent +='<td><input type="text" class="input-small" style="width:40px;text-align:center" value="1"  id="goodsnum_'+jsonArray.result[0].goodsid+'" name="goodsnum[]" onKeyUp="cal(\''+jsonArray.result[0].goodsid+'\')"></td>';
					tdcontent +='<td>'+jsonArray.result[0].brandname+'</td>';
					tdcontent +='<td>'+jsonArray.result[0].xinghao+'</td>';
					tdcontent +='<td><input type="text" class="input-small" style="text-align:right" value="'+jsonArray.result[0].outprice+'"  id="price_'+jsonArray.result[0].goodsid+'" name="price[]" onKeyUp="cal(\''+jsonArray.result[0].goodsid+'\')" > <input type="hidden"  value="'+jsonArray.result[0].outprice+'"  name="trueprice[]" ></td>';
					tdcontent +='<td id="allprice_'+jsonArray.result[0].goodsid+'">'+jsonArray.result[0].outprice+'</td>';
					tdcontent +='<td><button onclick="del(this)" type="button" class="btn btn-link" title="删除"><i class="icon-remove"></i></button><input type="hidden" name="goodsid[]" value="'+jsonArray.result[0].goodsid+'"><input type="hidden" name="goodsno[]" id="goodsno_'+jsonArray.result[0].goodsid+'" value="'+jsonArray.result[0].goodsno+'"><input type="hidden" id="maxnum_'+jsonArray.result[0].goodsid+'" value="'+jsonArray.result[0].goodsnum+'"></td></tr>';
					
					maxArray[jsonArray.result[0].goodsid]=jsonArray.result[0].goodsnum;
				//	alert(maxArray[jsonArray.result[0].goodsid]);
					
					//var rowLength = tabObj.rows.length;
	
					//var lastTr = tabObj.rows[rowLength-1];
					//lastTr.parentNode.insertBefore(tdcontent,lastTr);
	
					tabObj.insertRow(tabObj.rows.length).innerHTML = tdcontent;
					 calAll();	
			  $('#goodsno').focus(); 
			  $('#goodsno').val(''); 
				
				}else{
					$('#readme3').html('多于一个商品，请确认');
				}
				
			}
			//
		 });

	  
}  

  /*
  
			}else if(jsonArray.count>1){

				
					divwindow=dhtmlmodal.open('EmailBox', 'div', 'showFrame', '商品选择', 'width=600px, height=300px, center=1, resize=0, scrolling=1')

					//弹出选择窗口
				var popwindow='<table id="tb2" ><table id="tb2" ><tbody id="tbody2"><tr><th>编号</th><th>名称</th><th>型号(尺码)</th><th>数量</th><th>单位</th><th>品牌</th><th>售价</th><th>折扣</th><th>金额</th><th>&nbsp;</th></tr></tbody></table>';
				
				$('showgoods').innerHTML=popwindow;
				
				var  tabObj = document.getElementById("tbody2");   
				for(i=0;i<jsonArray.count;i++){
					var tdcontent='<tr id="g'+jsonArray.result[i].goodsid+'">';
				tdcontent +='<td>'+jsonArray.result[i].goodsno+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].goodsname+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].xinghao+'</td>';
				tdcontent +='<td>1</td>';
				tdcontent +='<td>'+jsonArray.result[i].unitname+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].brandname+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].price+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].discount+'</td>';
				tdcontent +='<td>'+jsonArray.result[i].price+'</td>';
				tdcontent +='<td><input type="button" value="选择" name="B1" class="btn" onclick="selected(\''+jsonArray.result[i].goodsno+'\')"</td></tr>';
				

				tabObj.insertRow(tabObj.rows.length).innerHTML = tdcontent;
				}

			divwindow.onclose=function(){
										processPost();
										return true;
								}

			
				
				 
				
			}else{
				alert(originalRequest.responseText);    
			}
			
				$('goodsno').value='';
				$('goodsno').focus(); 
		}
	} 
*/
	
function del(obj){
	if(confirm("确认要删除?")){
	//	var t=document.getElementById('tbody1')
	//	t.deleteRow(obj.parentNode.parentNode.rowIndex);
		$(obj).closest('tr').remove()
		calAll();
	//$(obj).parent().parent().remove();
	//alert(id);
	//$(obj).parent('td').parent('tr').remove();  
		$('#goodsno').val('');
		$('#goodsno').focus(); 

	}
}

function selected(goodsno){
	parent.document.getElementById('goodsno').value=goodsno;
	parent.divwindow.hide();
}


window.onload = function() {
  $('#goodsno').focus(); 
}

function calAll(){
	var  goodsnum = document.getElementsByName("goodsnum[]") ;
	var  price = document.getElementsByName("price[]") ;
	var  trueprice = document.getElementsByName("trueprice[]") ;
	
        var allnum=0;
        var allprice=0;
        var alltrueprice=0;
        for (var i=0;i<goodsnum.length;i++ )
        {   
			var goodsnum_tmp= Number(goodsnum[i].value);      
			if (goodsnum_tmp<0)
				goodsnum_tmp=0-goodsnum_tmp;
				
            allnum +=Number(goodsnum_tmp);
			allprice +=Number(Number(goodsnum[i].value))*Number(price[i].value);
			alltrueprice +=Number(Number(goodsnum[i].value))*Number(trueprice[i].value);
        }
	
	$('#allnum').html(Number(allnum));
	$('#allprice').html(Number(allprice).toFixed(2));
	$('#alltrueprice').html(Number(alltrueprice).toFixed(2));

	if(Number(allnum)>0 ){
		$('#shoukuanbtn').prop("disabled",false);
	}else{
		$('#shoukuanbtn').prop("disabled","disabled");
	}
}

function cal(id){
	var id_price=parseInt($('#price_'+id).val());
	var id_num=parseInt($('#goodsnum_'+id).val());
	
	if(id_price<0){
		alert('金额不能为负数');
		$('#price_'+id).val(0);
		return false;
	}
		if(id_num<=0){
		alert('数量必须大于零的整数');
		$('#goodsnum_'+id).val(0);
		return false;
	}
	
	//parseInt($('valuemaxnum_'+id).
	//获取每产品最大数
	//var goodsidlist=$F('goodsid');
	/*
	var goodsidlist=documnet.getElementByName('goodsid');
	for (i=0;i<goodsidlist.length;i++){
		var xid=goodsidlist[i];
		alert(xid);
		*/
		/*
		maxArray[id]=parseInt(maxArray[id])-parseInt($('goodsnum_'+xid).value);
		if(parseInt(maxArray[id])<=0){
			alert($('goodsno_'+xid).value+'超过数量，请修改');
			return false;
		}
		
	}
	*/

	var allproce=parseInt($('#goodsnum_'+id).val())*parseInt($('#price_'+id).val());
	$('#allprice_'+id).html(allproce.toFixed(2));
	calAll();
}


function showGoods(){

} 

function shoukuan(){
	$(document).ready(function(){
	 //  $(".addnew").click(function(){ // Click to only happen on announce links
	 var shishou=$('#allprice').html();
	 var alltrueprice=$('#alltrueprice').html();
	 
	 //统计商品数量 超过最大值则报错
	 
	 
	 
		 $("#yingshou").val(alltrueprice);
		 $("#shishou").val(shishou);
		 $("#laikuan").val('');
		 $("#zhaohui").val('');
 		 $('#laikuan').focus(); 
		 $('#myModal').modal('show');
		 $('#readme4').html('');

	  // });
	});
				
}


function saveit(){
	var laikuan=$('#laikuan').val();
	var shishou=$('#shishou').val();
	if(laikuan==0){
		$('#readme4').html('请填写来款金额');
		$('#laikuan').focus(); 
		return false;	}
	if(Number(laikuan)<Number(shishou)){
			$('#readme4').html('来款小于实收,不允许欠款');
	//	if(!confirm('来款金额小于实收金额，是否允许欠款？')){
			$('#laikuan').focus(); 
			$('#laikuan').select(); 
			return false;
	//	}
	}
	
	//alert('保存操作');
	$('order').submit();
	return true;
}

function zhaohuikuan(){   
		$('#readme4').html('');
		var laikuan=$('#laikuan').val();
		var shishou=$('#shishou').val();
		var zhaohui=Number(laikuan)-Number(shishou);
		$('#zhaohui').val(zhaohui.toFixed(2));
		if(laikuan==0){
			$('#readme4').html('请填写来款金额');
		}else if(Number(laikuan)<Number(shishou)){
			$('#readme4').html('来款小于实收,不允许欠款');
		}
		/*if(Number(laikuan)<Number(shishou)){
			if(!confirm(laikuan+'来款金额小于实收金额'+shishou+'，是否允许欠款？')){
				$('laikuan').focus(); 
				$('laikuan').select(); 
				return false;
			}
		}
		*/
} 



</script> 
    <!-- 动态弹出窗口代码 结束 -->
    
    <!-- Modal -->
<div id="myModal" class="modal hide fade sailbox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
      <h3 id="myModalLabel">收款过账</h3>
    </div>
    <div class="modal-body">
      <div class="control-group">
        <label class="control-label" for="yingshou">应收金额：</label>
        <div class="controls">
          <label><input type="text" name="yingshou" value=""  class="input-medium" id="yingshou" placeholder="0"  readonly="readonly"/> 元</label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="shishou">实收金额：</label>
        <div class="controls">
          <label><input type="text" name="shishou" value=""  class="input-medium" id="shishou" placeholder="0" readonly="readonly" /> 元</label>
        </div>
      </div>
      <div class="control-group error">
        <label class="control-label" for="laikuan">现金来款：</label>
        <div class="controls">
          <label><input type="text" name="laikuan" value="" class="input-medium" id="laikuan" placeholder="输入现金来款" onkeyup="zhaohuikuan()"/> 元</label>
          <div><small id="readme4" class="label-warning"></small></div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="zhaohui">找回金额：</label>
        <div class="controls">
          <label><input type="text" name="zhaohui" value="0" class="input-medium" id="zhaohui" placeholder="0" readonly="readonly" /> 元</label>
        </div>
      </div>

      <div class="control-group error">
        <label class="control-label"> 支付方式：</label>
        <div class="controls">
         <label for="paytype1" class="radio inline"><input type="radio" name="paytype" id="paytype1"  value="cash" checked="checked"/>
         <strong>现金</strong></label>
          <label for="paytype2" class="radio inline" ><input type="radio" name="paytype" id="paytype2"  value="card" />
          <strong>刷卡</strong></label>
        </div>
      </div>
    </div>
    <div class="modal-footer">
        <input value="废弃此单" type="button" class="btn" onclick="if(confirm('要废弃此单?')){window.location.reload();}else return false;" />
        &nbsp;&nbsp;&nbsp;
        <button class="btn" data-dismiss="modal" aria-hidden="true">返回修改</button>
        &nbsp;&nbsp;&nbsp;
      <button type="submit" class="btn btn-primary">确认过账</button>
    </div>
</div>



  </form>
</div>