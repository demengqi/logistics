<div id="<*$controller*>">
<ul class="thumbnails">
  <*if in_array('sail',$user_can_action)*><li><a href="/sail"><div class="thumbnail span6 label-success">商品销售</div></a></li><*/if*>
  <*if in_array('history',$user_can_action)*><li ><a href="/history" ><div class="thumbnail span4 label-warning">销售记录</div></a></li><*/if*>
  <*if in_array('stat',$user_can_action)*><li><a href="/stat" ><div class="thumbnail span4 label-info">销售统计</div></a></li><*/if*>
  <*if in_array('goods',$user_can_action)*><li><a href="/goods" ><div class="thumbnail span4 label-inverse">商品资料</div></a></li><*/if*>
  <*if in_array('set',$user_can_action)*><li><a href="/set" ><div class="thumbnail span3 label-warning">系统设置</div></a></li><*/if*>
  <*if in_array('user',$user_can_action)*><li><a href="/user" ><div class="thumbnail span3 label-warning">权限管理</div></a></li><*/if*>
</ul>
</div>