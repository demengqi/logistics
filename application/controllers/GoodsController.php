<?php

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

			$count = 40; //pre
			$curpage = 1;
				//get para
			$curpage = ( int ) $this->_request->getParam ( 'page' );
			if ($curpage < 1)
				$curpage = 1;
			$where = '';
			$order = ' order by `goodsid` desc';
			$offset = ($curpage - 1) * $count;

			$this->view->typeid=$typeid = ( int ) $this->_request->getParam ( 'typeid' );
			$this->view->brandid=$brandid = ( int ) $this->_request->getParam ( 'brandid' );
			$this->view->goodsname=$goodsname = $this->_request->getParam ( 'goodsname' );
			if($typeid){
				$where .=' and typeid='.$typeid;
			}
			if($brandid){
				$where .=' and brandid='.$brandid;
			}
			if(!empty($goodsname)){
				$where .=' and (goodsno like "%'.$goodsname.'%" or goodsname like "%'.$goodsname.'%")';
			}
			
		$sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM goods where 1 ' . $where . $order . " limit $offset,$count";
		//echo $sql;exit;
		$result = $this->_dbAdapter->fetchAll ( $sql );
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

			$this->view->typelist=$this->_dbAdapter->fetchPairs('select * from types ');
			//获取品牌列表 
			$this->view->brandlist=$this->_dbAdapter->fetchPairs('select * from brands ');
			//获取单位列表
			$this->view->unitlist=$this->_dbAdapter->fetchPairs('select * from units ');

			foreach($result as $key => $value){
				if(!empty($value['typeid']))
					$result[$key]['type']=$this->view->typelist[$value['typeid']];
				if(!empty($value['brandid']))
					$result[$key]['brand']=$this->view->brandlist[$value['brandid']];
				if(!empty($value['unitid']))
					$result[$key]['unit']=$this->view->unitlist[$value['unitid']];
			}
			//print_r($result);
			$this->view->result = $result;
			
			
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	//用户首页
	public function addAction() {
		try {
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
			
			$p['addtime']=time();
			if(empty($p['goodsno']))
				throw new Exception ( '不能为空！' );
			if(empty($p['goodsname']))
				throw new Exception ( '不能为空！' );
//			if(!empty($p['inprice']) && !is_float($p['inprice']))
	//			throw new Exception ( '进货价格格式错误！' );
			if(empty($p['price']) )
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

			$idlist = $this->_request->getParam ( 'id' );
			if(!$idlist)
				throw new Exception ( '参数错误！' );
			$sql='select * from goods where goodsid in ('.$idlist.')';
			$result=$this->_dbAdapter->fetchAll($sql);
			if(!$result)
				throw new Exception ( '无数据！' );
			$this->view->result=$result;
			$this->view->num=count($result);
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

			$time=time();
			$sql='insert ignore goods_delete select *,'.$time.' from goods where goodsid in ('.$idlist.') ';			
			$this->_dbAdapter->query($sql);
			$sql='select count(*) as num  from goods_delete where goodsid in ('.$idlist.')';
			$deletenum=$this->_dbAdapter->fetchone($sql);	
			if($deletenum== $num){
				$result=$this->_dbAdapter->delete('goods','goodsid in ('.$idlist.')');
			}
			if($result){
				$this->log(var_export ( '[idlist]'.$idlist, true ));
				$this->feedback ( '成功删除'.$deletenum.'数据', '注意', '/'.$this->controller.'', 'tip' );
			}else	
				throw new Exception ( '删除失败 ！' );
				
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
			//print_r($p);
			if(!isset($p['goodsid']) || empty($p['goodsid']))
				throw new Exception ( '不能为空！' );
			$isok=0;
			foreach($p['goodsid'] as $key => $value){
				$data=array();
				foreach($p as $key1 => $value1){
					if($key1<>'goodsid' && $key1<>'goodsno'){
						$data[$key1]=addslashes(trim($value1[$key]));
					}
				}
				$data['lasttime']=time();
				//$this->log(Zend_Debug::dump($data,'data',0));
				$this->log(var_export ( $data, true ));
				$result=$this->_dbAdapter->update('goods',$data,'goodsid='.$key);
				if($result)
					$isok=1;
				$this->log(var_export ( '[isok]'.$isok, true ));	
			}
			if($isok)
				throw new Exception ( '保存修改成功 ！' );
			else	
				throw new Exception ( '保存修改失败 ！' );
			
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

