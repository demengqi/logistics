<?php
/*
商品管理
*/
class GoodsController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {

		//	$count = 40; //pre
		//	$curpage = 1;
				//get para
		//	$curpage = ( int ) $this->_request->getParam ( 'page' );
		//	if ($curpage < 1)
		//		$curpage = 1;
			$where = '';
			$order = ' order by `goodsid` desc';
			$result=array();
			$sum=array('goodsnum'=>0,'inprice'=>0,'outprice'=>0);
		//	$offset = ($curpage - 1) * $count;
			$issearch=0;
			$this->view->typeid=$typeid = ( int ) $this->_request->getParam ( 'typeid' );
			$this->view->brandid=$brandid = ( int ) $this->_request->getParam ( 'brandid' );
			$this->view->goodsname=$goodsname = $this->_request->getParam ( 'goodsname' );
			$all = $this->_request->getParam ( 'all' );
			if($all){
				$this->view->typeid=$typeid=0;
				$this->view->brandid=$brandid =0;
				$this->view->goodsname=$goodsname='';
			}
			
			
			if($typeid){
				$where .=' and typeid='.$typeid;
			}
			if($brandid){
				$where .=' and brandid='.$brandid;
			}
			if(!empty($goodsname)){
				$where .=' and (goodsno like "%'.$goodsname.'%" or goodsname like "%'.$goodsname.'%")';
			}
		
		if($all<>'' || $typeid || $brandid || !empty($goodsname)){
			$issearch=1;
			
		//$sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM goods_v where 1 ' . $where . $order . " limit $offset,$count";
			$sql = 'SELECT  * FROM goods_v where 1 ' . $where . $order ;
			//echo $sql;exit;
			$result = $this->_dbAdapter->fetchAll ( $sql );
			
			if($result){
				foreach($result as $key => $value){
					$result[$key]['inpriceall']=$value['goodsnum']*$value['inprice'];
					$result[$key]['outpriceall']=$value['goodsnum']*$value['outprice'];
					
					$sum['goodsnum'] +=$value['goodsnum'];
					$sum['inprice']  +=$value['goodsnum']*$value['inprice'];
					$sum['outprice'] +=$value['goodsnum']*$value['outprice'];
				}
			}
		}
		/*
			//翻页控制
			$param ['file'] = '/' . $this->controller . '/' . $this->action;
			$param ['totalnum'] = $this->_dbAdapter->fetchOne ( 'SELECT FOUND_ROWS()' );
			$param ['perpagenum'] = $count; // 每页显示的数目
			$param ['disnum'] = 11; // 取单数显示，当前页停在中间
			$param ['curpage'] = $curpage; // 当前页码
			// require_once 'MyClass/Page.php';
			$page = new MyClass_Page ( $param );
			$page->setvar(array('typeid' => $typeid,'brandid' => $brandid , 'goodsname' => $goodsname   ));
			$this->view->page = $page->getNumPage ();
*/
			$this->view->typelist=$this->_dbAdapter->fetchPairs('select * from types ');
			//获取品牌列表 
			$this->view->brandlist=$this->_dbAdapter->fetchPairs('select * from brands ');
			//获取单位列表
			$this->view->unitlist=$this->_dbAdapter->fetchPairs('select * from units ');

			$this->view->issearch=$issearch;
			$this->view->result = $result;
			$this->view->sum = $sum;
			
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	//用户首页
	public function addAction() {
		try {
		$goodsno = ( int ) $this->_request->getParam ( 'goodsno' );
		$this->view->goodsno=$goodsno==0?'':$goodsno;
			//获取类型列表
		$this->view->typelist=$this->_dbAdapter->fetchPairs('select * from types ');
		//获取品牌列表 
		$this->view->brandlist=$this->_dbAdapter->fetchPairs('select * from brands ');
		//获取单位列表
		$this->view->unitlist=$this->_dbAdapter->fetchPairs('select * from units ');
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
		
		//用户首页
	public function opaddAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
		
			foreach($p as $key => $value){
				$p[$key]=addslashes(trim($value));
			}
			
			$p['addtime']=date('Y-m-d H:i:s');
			$p['lasttime']=date('Y-m-d H:i:s');
			if(empty($p['goodsno']))
				throw new Exception ( '不能为空！' );
			if(empty($p['goodsname']))
				throw new Exception ( '不能为空！' );
//			if(!empty($p['inprice']) && !is_float($p['inprice']))
	//			throw new Exception ( '进货价格格式错误！' );
			if(empty($p['outprice']) )
				throw new Exception ( '零售价格格式错误！' );
				
				$sql='select goodsid from goods where goodsno="'.$p['goodsno'].'"';
				$haveGoodsno=$this->_dbAdapter ->fetchOne ($sql);
				if($haveGoodsno)
					throw new Exception ( '该商品编号已存在，请重新确认！' );
				
				//add
				$result=$this->_dbAdapter ->insert ( 'goods',$p);

			
			if($result)
				$this->feedback ( '保存新商品成功', '注意', '/'.$this->controller.'/add', 'warning' );
			else	
				throw new Exception ( '保存新商品失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	//用户首页
	public function editAction() {
		try {

			$goodsid = $this->_request->getParam ( 'goodsid' );
			if(!$goodsid)
				throw new Exception ( '参数错误！' );
			$sql='select * from goods where goodsid ='.$goodsid;
			$result=$this->_dbAdapter->fetchRow($sql);
			if(!$result)
				throw new Exception ( '无数据！' );
			$this->view->result=$result;
			//print_r($result);

			//获取类型列表
		$this->view->typelist=$this->_dbAdapter->fetchPairs('select * from types ');
		//获取品牌列表 
		$this->view->brandlist=$this->_dbAdapter->fetchPairs('select * from brands ');
		//获取单位列表
		$this->view->unitlist=$this->_dbAdapter->fetchPairs('select * from units ');
		
		
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	//用户首页
	public function deleteAction() {
		try {

			$idlist = $this->_request->getParam ( 'id' );
			if(!$idlist)
				throw new Exception ( '参数错误！' );
			$sql='select count(*) as num from goods where goodsid in ('.$idlist.')';
			$num=$this->_dbAdapter->fetchOne($sql);
			if(!$num)
				throw new Exception ( '无数据！' );
			$result=$this->_dbAdapter->update('goods',array('isover'=>1),'goodsid in ('.$idlist.')');
/*
			$time=time();
			$sql='insert ignore goods_delete select *,'.$time.' from goods where goodsid in ('.$idlist.') ';			
			$this->_dbAdapter->query($sql);
			$sql='select count(*) as num  from goods_delete where goodsid in ('.$idlist.')';
			$deletenum=$this->_dbAdapter->fetchone($sql);	
			if($deletenum== $num){
				$result=$this->_dbAdapter->delete('goods','goodsid in ('.$idlist.')');
			}
			*/
			if($result){
				$this->log(var_export ( '[idlist]'.$idlist, true ));
				$this->feedback ( '成功停售'.$num.'数据', '注意', '/'.$this->controller.'', 'tip' );
			}else	
				throw new Exception ( '操作失败或重复操作 ！' );
				
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
			
	public function opeditAction(){
			try {
				if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
				}
			
				$p =$this->_request->getPost ();
				if(!isset($p['goodsid']) || empty($p['goodsid']))
					throw new Exception ( '不能为空！' );

				$isok=0;
				foreach($p as $key1 => $value1){
					if($key1<>'goodsid' && $key1<>'goodsno'){
						$p[$key1]=addslashes(trim($value1));
					}
				}
				$p['lasttime']=date('Y-m-d H:i:s');

				//$this->log(Zend_Debug::dump($data,'data',0));
				$this->log(var_export ( $p, true ));
				if(!isset($p['isover']))
					$p['isover']=0;
				$result=$this->_dbAdapter->update('goods',$p,'goodsid='.$p['goodsid']);
				if($result)
					$isok=1;
				$this->log(var_export ( '[isok]'.$isok, true ));	

			if($isok)
				throw new Exception ( '商品修改成功 ！' );
			else	
				throw new Exception ( '商品修改失败或没有任何改变 ！' );
			
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
			
	
		//用户首页
	public function typeAction() {
		try {
		$result=$this->_dbAdapter ->fetchAssoc ( 'select * from types');
		
		$this->view->result=$result;
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		//用户首页
	public function optypeAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			//print_r($p);
			
			$isok=0;
			
			//add
			if(!empty($p['addtypename'])){
				$result=$this->_dbAdapter ->insert ( 'types',array('typename'=>addslashes(trim($p['addtypename']))));
				if($result)
					$isok=1;	
			}
			
			if(!empty($p['typename']))
			foreach($p['typename'] as $key => $value){
				$data=array('typename'=>addslashes(trim($value)));
				$result=$this->_dbAdapter ->update ( 'types',$data,'typeid='.$key );
				
				if($result)
					$isok=1;	
			}
			if($isok)
				$this->feedback ( '更新成功', '注意', '/'.$this->controller.'/type', 'warning' );
			else	
				throw new Exception ( '更新失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	
		//用户首页
	public function deletetypeAction() {
		try {
			$typeid=intval($this->_request->getParam('id'));
			if(!$typeid)
				throw new Exception ( '参数错误！' );
				
				$this->log(var_export ( '[typeid]'.$typeid, true ));
				$result=$this->_dbAdapter ->delete ( 'types','typeid='.$typeid );
				
				if($result)
				
				$this->feedback ( '删除成功', '注意', '/'.$this->controller.'/type', 'warning' );
			else	
				throw new Exception ( '删除失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
		
		
		//用户首页
	public function brandAction() {
		try {
		$result=$this->_dbAdapter ->fetchAssoc ( 'select * from brands');
		
		$this->view->result=$result;
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		//用户首页
	public function opbrandAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			
			$isok=0;
			
			//add
			if(!empty($p['addbrandname'])){
				$result=$this->_dbAdapter ->insert ( 'brands',array('brandname'=>addslashes(trim($p['addbrandname']))));
				if($result)
					$isok=1;	
			}
			
			if(!empty($p['brandname']))
			foreach($p['brandname'] as $key => $value){
				$data=array('brandname'=>addslashes(trim($value)));
				$result=$this->_dbAdapter ->update ( 'brands',$data,'brandid='.$key );
				
				if($result)
					$isok=1;	
			}
			if($isok)
				$this->feedback ( '更新成功', '注意', '/'.$this->controller.'/brand', 'warning' );
			else	
				throw new Exception ( '更新失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	
		//用户首页
	public function deletebrandAction() {
		try {
			$brandid=intval($this->_request->getParam('id'));
			if(!$brandid)
				throw new Exception ( '参数错误！' );

			$result=$this->_dbAdapter ->delete ( 'brands','brandid='.$brandid );
			
			if($result){
				$this->log(var_export ( '[brandid]'.$brandid, true ));
				$this->feedback ( '删除成功', '注意', '/'.$this->controller.'/brand', 'warning' );
			}else	
				throw new Exception ( '删除失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
				

		
		//用户首页
	public function unitAction() {
		try {
		$result=$this->_dbAdapter ->fetchAssoc ( 'select * from units');
		
		$this->view->result=$result;
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		//用户首页
	public function opunitAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			//print_r($p);
			
			$isok=0;
			
			//add
			if(!empty($p['addunitname'])){
				$result=$this->_dbAdapter ->insert ( 'units',array('unitname'=>addslashes(trim($p['addunitname']))));
				if($result)
					$isok=1;	
			}
			
			if(!empty($p['unitname']))
			foreach($p['unitname'] as $key => $value){
				$data=array('unitname'=>addslashes(trim($value)));
				$result=$this->_dbAdapter ->update ( 'units',$data,'unitid='.$key );
				
				if($result)
					$isok=1;	
			}
			
			if($isok){
				$this->feedback ( '更新成功', '注意', '/'.$this->controller.'/unit', 'warning' );
			}else	
				throw new Exception ( '更新失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	
		//用户首页
	public function deleteunitAction() {
		try {
			$unitid=intval($this->_request->getParam('id'));
			if(!$unitid)
				throw new Exception ( '参数错误！' );
				

				$result=$this->_dbAdapter ->delete ( 'units','unitid='.$unitid );
				
				if($result){
					$this->log(var_export ( '[unitid]'.$unitid, true ));
					$this->feedback ( '删除成功', '注意', '/'.$this->controller.'/unit', 'warning' );
				}else	
				throw new Exception ( '删除失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
				
				

	public function checkgoodsAction(){
		try {
			if (! $this->isPost ()) {
					throw new Exception ( -1 );
			}
			
			$goodsno =addslashes(trim($this->_request->getPost ('goodsno')));
			if(empty($goodsno))
				throw new Exception ( -2 );
			
			$sql='select * from goods where goodsno like "%'.$goodsno.'%" or goodsname like "%'.$goodsno.'%" and goodsnum>0';
			$result=$this->_dbAdapter->fetchAll($sql);
			if(!$result)
				throw new Exception ( -3 );
			
			$jsonArray=array('count'=>count($result),'result'=>$result);
			
			echo Zend_Json::encode($jsonArray);exit;	
			
		} catch ( Exception $e ) {
			echo $e->getMessage ();
			exit;
		}
		
	}
	
	
	//入库单列表
	public function entryAction() {
		try {

			$count = 20; //pre
			$curpage = 1;
				//get para
			$curpage = ( int ) $this->_request->getParam ( 'page' );
			if ($curpage < 1)
				$curpage = 1;
			$offset = ($curpage - 1) * $count;

			$where = '';
			$order = ' order by `entryid` desc';
			
			$this->view->goodsno=$goodsno = addslashes(trim($this->_request->getParam ( 'goodsno' )));

			if(!empty($goodsno)){
				$where .=' and (goodsno like "%'.$goodsno.'%" or goodsname like "%'.$goodsno.'%")';
			}
			
			$sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM entry_v where 1 ' . $where . $order." limit $offset,$count" ;
			$result = $this->_dbAdapter->fetchAll ( $sql );
			
	
			//翻页控制
			$param ['file'] = '/' . $this->controller . '/' . $this->action;
			$param ['totalnum'] = $this->_dbAdapter->fetchOne ( 'SELECT FOUND_ROWS()' );
			$param ['perpagenum'] = $count; // 每页显示的数目
			$param ['disnum'] = 7; // 取单数显示，当前页停在中间
			$param ['curpage'] = $curpage; // 当前页码
			$page = new MyClass_Page ( $param );
			$page->setvar(array('goodsno' => $goodsno));
			$this->view->page = $page->getNumPage ();

			
			$this->view->result = $result;

		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		//用户首页
	public function entryaddAction() {
		try {
		$this->view->datenow=date('Y年m月d日');
		$this->view->goodsno= $this->_request->getParam ( 'goodsno' );
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}


		//用户首页
	public function opentryaddAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
		
			foreach($p as $key => $value){
				$p[$key]=addslashes(trim($value));
			}
			//print_r($p);exit;
			$p['goodsnum']=intval($p['goodsnum']);
			
			if(empty($p['goodsno']))
				throw new Exception ( '商品编号不能为空！' );

			if(!$p['goodsnum'])
				throw new Exception ( '数量不正确！' );

			if(empty($p['inprice']) )
				throw new Exception ( '进货价格格式错误！' );

			
			$p['goodsno']=trim($p['goodsno']);
			$p['goodsnum']=intval(trim($p['goodsnum']));

//			if(!empty($p['inprice']) && !is_float($p['inprice']))
	//			throw new Exception ( '进货价格格式错误！' );
				
				$sql='select goodsid from goods where goodsno="'.$p['goodsno'].'"';
				$goodsid=$this->_dbAdapter ->fetchOne ($sql);
				if(!$goodsid)
					throw new Exception ( '该商品不存在，请重新确认！' );

			$p['addtime']=date('Y-m-d H:i:s');
			$p['adddate']=date('Y-m-d');
			$p['adduserid']=$this->_user->id;
				
				//add
				$result=$this->_dbAdapter ->insert ( 'entry',$p);
				if($result){
					$this->_dbAdapter ->query ( 'update goods set goodsnum=goodsnum+'.$p['goodsnum'].',inprice="'.$p['inprice'].'" where goodsno="'.$p['goodsno'].'"');
				}
			
			if($result)
				$this->feedback ( '入库单增加成功', '注意', '/'.$this->controller.'/entryadd', 'warning' );
			else	
				throw new Exception ( '入库单增加失败 ！' );
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	
			
	 //以下内容保持不变
	public function noRouteAction() {
		$this->_redirect ( '/' );
	}
	
	public function __call($method, $args) {
		if ('Action' == substr ( $method, - 6 )) {
			$url = '/' . $this->controller . '/index';
			return $this->_redirect ( $url );
		}
		throw new Exception ( 'Invalid method' );
	}
}

