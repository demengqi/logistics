<ul class="nav nav-list ">
  <li <*if $action=='index'*>class="active"<*/if*>><a href="/<*$controller*>/index" ><i class="icon-chevron-right"></i> 商品信息 </a>
  </li>
  <li <*if $action=='add'*>class="active"<*/if*>><a href="/<*$controller*>/add" ><i class="icon-chevron-right"></i> 添加商品 </a>
  </li>
  <li><hr /></li>
  <li <*if $action=='brand'*>class="active"<*/if*>><a href="/<*$controller*>/brand" ><i class="icon-chevron-right"></i> 品牌 </a>
  </li>
  <li <*if $action=='type'*>class="active"<*/if*>><a href="/<*$controller*>/type" ><i class="icon-chevron-right"></i> 类别 </a>
  </li>
  <li <*if $action=='unit'*>class="active"<*/if*>><a href="/<*$controller*>/unit" ><i class="icon-chevron-right"></i> 单位 </a>
  </li>
</ul>
