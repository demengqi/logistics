<?php

class SetController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {

			$setting=$this->_dbAdapter->fetchAssoc('select variable,value,readme from settings');
			//$setting['actionlist']=explode(',',$setting['actionlist']);
			$this->view->settinglist=$setting;
			
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	public function opAction() {
		try {
			
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			$isok=0;
			foreach($p['old'] as $key => $value){
				$data=array('value'=>trim($value));
				$result=$this->_dbAdapter ->update ( 'settings',$data,'variable="'.$key.'"' );
				if($result)
					$isok=1;	
			}
			
			if(!empty($p['new']['key'])){
				//print_r($p['new']);
				$data=array('value'=>trim($p['new']['value']),'variable'=>trim($p['new']['key']),'readme'=>trim($p['new']['readme']));
				$result=$this->_dbAdapter ->insert ( 'settings',$data);
				if($result)
					$isok=1;	
			}
			
			if($isok)
				$this->feedback ( '更新成功', '注意', '/'.$this->controller, 'warning' );
			else	
				throw new Exception ( '更新失败或没有更改任何内容 ！' );
			
			//print_r($p);exit;
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
	}}

