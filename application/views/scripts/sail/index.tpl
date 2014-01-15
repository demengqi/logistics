<style type="text/css">
#<*$controller*> ul{ width:780px;}
#<*$controller*> li{ float:left; width:250px; text-align:right; margin-left:10px; margin-bottom:5px;}
#formlist { clear:both; padding:20px 5px; text-align:right;width:780px;}
#formlist table{ width:780px; clear:both}
#formlist th,td{ text-align:center}
#total { clear:both; width:780px; text-align:center; font-size:24px;}
.readme{clear:both; padding-left:30px}
#jiesuan { margin:0px auto; width:375px; text-align:left; }
#jiesuan h1{ font-size:24px; color:#F30; font-weight:bold; text-align:center; margin:25px auto; }
#jiesuan dl{ width:375px; margin:5px 0px;}
#jiesuan dt{ float:left; width:100px; position:absolute; text-align:right; font-size:16px;margin-bottom:5px;}
#jiesuan dd{ padding-left:100px; text-align:left;margin-bottom:5px;}
#jiesuan .opbtn{ padding-left:20px; margin-top:20px;}

</style>
<div id="<*$controller*>">
<form action="/<*$controller*>/saveorder" method="post" name="order" id="order">
<div id="title">
<ul class="clear">
<li>单据编号：<input type="text" readonly="readonly" value="<*$orderno*>" name="orderno" class="txt gray"></li>
<li>操作员：<input type="text"   readonly="readonly" value="<*$this->_user->workid*>" class="txt"></li>
<li>日期：<input type="text"  readonly="readonly" name="day"  value="<*$date*>" class="txt gray"></li>
<!-- li>会员：<input type="text" name="vip" value="" class="txt"></li>
<li>折扣：<input type="text" name="discount" value="1" class="txt"></li>
<li>业务员：<input type="text" name="sailer" value="" class="txt"></li -->
</ul>

</div>
<div id="formlist"  >
<input  type="text" class="txt"  value="" id="goodsno" onkeypress="getfocus(event)"/>&nbsp;&nbsp;<input class="btn" type="button"  id="searchBtn" value="输入商品编号" onclick="getSearch(event)"/>
<table id="tb1" >
<tbody id="tbody1">
<tr>
<th>编号</th>
<th>名称</th>
<th>型号(尺码)</th>
<th>数量</th>
<th>单位</th>
<th>品牌</th>
<th>售价</th>
<th>折扣</th>
<th>金额</th>
<th>&nbsp;</th>
</tr>
</tbody>
</table>
</div>
<div class="readme">说明：数量为负数表示退货</div>
<div id="total"  >
合计数量 ：<span id="allnum">0</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;合计金额：&yen;<span id="allprice">0</span>&nbsp;&nbsp;&nbsp;<input type="button" style="font-size:24px;" class="btn" value=" 收款 " onclick="shoukuan();"/>
</div>
<script type="text/javascript" src="/js/prototype.js"></script>
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
			  alert('请输入商品编号或名称');
			  $('goodsno').focus(); 
			  event.returnValue = false;  
			  return false;
		 }
		 
		 processPost();

	}
	  
}  
function getSearch(event){   

		 var tmpEle=document.getElementById('goodsno');
		 if(tmpEle==null){
			   tmpEle=eval('goodsno');
		 }   
		 if(tmpEle.value==null || tmpEle.value==''){
			  alert('请输入商品编号或名称');
			  event.returnValue = false;  
			  $('goodsno').focus(); 
			  return false;
		 }
		 
		 processPost();
	  
}  

  
  
   	function processPost()
	{

		var v = $F('goodsno');

		var url = '/<*$controller*>/checkgoods';
		var pars = 'goodsno=' + v;

		var myAjax = new Ajax.Request( url, { method: 'post', parameters: pars, onComplete:showResponse_button});
	}
	function showResponse_button(originalRequest)
	{
		
		if(originalRequest.responseText==-1 ){
			 alert('系统方法错误');
			$('goodsno').focus(); 
			$('goodsno').select(); 
			event.returnValue = false;  
		}else if(originalRequest.responseText==-2 ){
			 alert('输入不能为空');
			$('goodsno').focus(); 
			$('goodsno').select(); 
			event.returnValue = false;  
		}else if(originalRequest.responseText==-3){
		 //查询数据库
			 alert('基本信息中无此编号的商品,或没有库存');
			$('goodsno').focus(); 
			$('goodsno').select(); 
			event.returnValue = false;  
			
    	}else{
			

			var jsonArray =eval('(' + originalRequest.responseText + ')');       
			if(jsonArray.count==1){
				//增加 行
				
				var  tabObj = document.getElementById("tbody1");
				
				var tdcontent='<tr id="g'+jsonArray.result[0].goodsid+'">';
				tdcontent +='<td>'+jsonArray.result[0].goodsno+'</td>';
				tdcontent +='<td>'+jsonArray.result[0].goodsname+'</td>';
				tdcontent +='<td>'+jsonArray.result[0].xinghao+'</td>';
				tdcontent +='<td><input type="text" class="txt" style="width:40px;text-align:center" value="1"  id="goodsnum_'+jsonArray.result[0].goodsid+'" name="goodsnum[]" onKeyUp="cal(\''+jsonArray.result[0].goodsid+'\')"></td>';
				tdcontent +='<td>'+jsonArray.result[0].unitname+'</td>';
				tdcontent +='<td>'+jsonArray.result[0].brandname+'</td>';
				tdcontent +='<td><input type="text" class="txt" style="width:80px;text-align:right" value="'+jsonArray.result[0].price+'"  id="price_'+jsonArray.result[0].goodsid+'" name="price[]" onKeyUp="cal(\''+jsonArray.result[0].goodsid+'\')" ></td>';
				tdcontent +='<td>'+jsonArray.result[0].discount+'</td>';
				tdcontent +='<td id="allprice_'+jsonArray.result[0].goodsid+'">'+jsonArray.result[0].price+'</td>';
				tdcontent +='<td><input type="button" value="删除" name="B1" class="btn" onclick="del(this)"><input type="hidden" name="goodsid[]" value="'+jsonArray.result[0].goodsid+'"><input type="hidden" name="goodsno[]" id="goodsno_'+jsonArray.result[0].goodsid+'" value="'+jsonArray.result[0].goodsno+'"><input type="hidden" name="discount[]" value="'+jsonArray.result[0].discount+'"><input type="hidden" id="maxnum_'+jsonArray.result[0].goodsid+'" value="'+jsonArray.result[0].goodsnum+'"></td></tr>';
				
				maxArray[jsonArray.result[0].goodsid]=jsonArray.result[0].goodsnum;
			//	alert(maxArray[jsonArray.result[0].goodsid]);
				
				//var rowLength = tabObj.rows.length;

				//var lastTr = tabObj.rows[rowLength-1];
				//lastTr.parentNode.insertBefore(tdcontent,lastTr);

				tabObj.insertRow(tabObj.rows.length).innerHTML = tdcontent;
				 calAll();
				
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

	
function del(o){
	if(confirm("确认要删除?")){
		var t=document.getElementById('tbody1')
		t.deleteRow(o.parentNode.parentNode.rowIndex);
		calAll();
		$('goodsno').value='';
		$('goodsno').focus(); 
	}
}

function selected(goodsno){
	parent.document.getElementById('goodsno').value=goodsno;
	parent.divwindow.hide();
}


window.onload = function() {
  document.getElementById("goodsno").focus();
}
function calAll(){
	var  goodsnum = document.getElementsByName("goodsnum[]") ;
	var  price = document.getElementsByName("price[]") ;
        var allnum=0;
        var allprice=0;
        for (var i=0;i<goodsnum.length;i++ )
        {           
            allnum +=Number(goodsnum[i].value);
			allprice +=Number(goodsnum[i].value)*Number(price[i].value);
        }
	

	$('allnum').innerHTML=Number(allnum);
	$('allprice').innerHTML=Number(allprice).toFixed(2);

}

function cal(id){
	if(parseInt($('price_'+id).value)<0){
		alert('金额不能为负数');
		$('price_'+id).value=0;
		return false;
	}
	//parseInt($('valuemaxnum_'+id).
	//获取每产品最大数
	//var goodsidlist=$F('goodsid');
	var goodsidlist=documnet.getElementByName('goodsid');
	for (i=0;i<goodsidlist.length;i++){
		var xid=goodsidlist[i];
		alert(xid);
		/*
		maxArray[id]=parseInt(maxArray[id])-parseInt($('goodsnum_'+xid).value);
		if(parseInt(maxArray[id])<=0){
			alert($('goodsno_'+xid).value+'超过数量，请修改');
			return false;
		}
		*/
	}
	

	var allproce=parseInt($('goodsnum_'+id).value)*parseInt($('price_'+id).value);
	$('allprice_'+id).innerHTML=parseInt(allproce).toFixed(2);
	calAll();
}
</script>

<link rel="stylesheet" href="/css/modal.css" type="text/css" />
<script type="text/javascript" src="/js/dhtmlwindow.js"></script>
<script type="text/javascript" src="/js/modal.js"></script>
<script type="text/javascript">

function showGoods(){

} 
function shoukuan(){
		var  goodsnum = document.getElementsByName("goodsnum[]") ;
        var allprice=0;
		if(goodsnum.length==0){
        	alert('请先选择商品');
			$('goodsno').focus(); 
			return false;
        }

	
	
	divwindow1=dhtmlmodal.open('EmailBox1', 'div', 'showFrame1', '结算中心', 'width=380px, height=380px, center=1, resize=0, scrolling=0');
	$('yingshou').setValue($('allprice').innerHTML);
	$('shishou').setValue($('allprice').innerHTML);
	
		$('laikuan').focus(); 
		$('laikuan').select(); 
	divwindow1.onclose=function(){
		//document.getElementById('yingshou').value=yingshou;
		//alert($('yingshou').value);
		return true;
	}
} 

function saveit(){
	var laikuan=$('laikuan').value;
	var shishou=$('shishou').value;
	if(laikuan==0){
		alert('请填写来款金额！');
		$('laikuan').focus(); 
		return false;	}
	if(Number(laikuan)<Number(shishou)){
		if(!confirm('来款金额小于实收金额，是否允许欠款？')){
			$('laikuan').focus(); 
			$('laikuan').select(); 
			return false;
		}
	}
	
	//alert('保存操作');
	$('order').submit();
	return true;
}
function getfocusMoney(event){   
	e = event ? event :(window.event ? window.event : null);

    if(e.keyCode==13){
		var laikuan=$('laikuan').value;
		var shishou=$('shishou').value;
		if(laikuan==0){
			alert('请填写来款金额！');
			$('laikuan').focus(); 
			return false;	}
		var zhaohui=Number(laikuan)-Number(shishou);
		$('zhaohui').setValue(zhaohui.toFixed(2));

		if(Number(laikuan)<Number(shishou)){
			if(!confirm(laikuan+'来款金额小于实收金额'+shishou+'，是否允许欠款？')){
				$('laikuan').focus(); 
				$('laikuan').select(); 
				return false;
			}
		}

	}
	  
} 



</script>
<!-- 动态弹出窗口代码 结束 -->
<div id="showFrame" style="display:none" class="showFrame">
<div id="showgoods">
</div>
</div>
<div id="showFrame1" style="display:none" class="showFrame">
<div id="jiesuan"><h1>收款过账</h1>
	<dl>
	<dt>应收金额：</dt><dd><input type="text" id="yingshou" name="yingshou"  readonly="readonly" value="0" class="txt">（元）</dd>
	<dt>实收金额：</dt><dd><input type="text" id="shishou" name="shishou" value="" class="txt">（元）</dd>
	<dt>现金来款：</dt><dd><input type="text" id="laikuan"  name="laikuan" value="" class="txt"  onkeypress="getfocusMoney(event)">（元）</dd>
	<dt>找回金额：</dt><dd><input type="text" id="zhaohui" name="zhaohui" readonly="readonly" class="txt">（元）</dd>
	<dt>支付方式：</dt><dd><input type="radio" name="paytype" id="paytype1" value="1" checked="checked"/><label for="paytype1">现金</label> <input type="radio" name="paytype" id="paytype2" value="2" /><label for="paytype2">刷卡</label></dd>
	</dl>
	<div class="opbtn">
	<input value="废弃此单" type="button" class="btn" onclick="if(confirm('要废弃此单?')){window.location.reload();}else return false;" />&nbsp;&nbsp;&nbsp;
	<input value="返回修改" type="button" class="btn" onclick="parent.EmailBox1.hide();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input value="确认过账" style="font-size:16px; color:#ff3300"  type="button" class="btn" onclick="saveit()" />
	</div>
	</div>
    </form>
</div>