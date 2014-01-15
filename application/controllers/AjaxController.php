<?php
/*
Ajax
*/
class AjaxController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {
			
		} catch ( Exception $e ) {
			echo $e->getMessage ();
			exit;
		}
	}
				
/*
检查产品是否存在
*/
	public function checkgoodsAction(){
		try {
			if (! $this->isPost ()) {
					throw new Exception ( -1 );
			}
			
			$goodsno =addslashes(trim($this->_request->getPost ('goodsno')));
			if(empty($goodsno))
				throw new Exception ( -2 );
			
			$sql='select * from goods where goodsno ="'.$goodsno.'"';
			$result=$this->_dbAdapter->fetchAssoc($sql);
			if(!$result)
				throw new Exception ( -3 );
			
			$jsonArray=array('count'=>count($result),'result'=>$result);
			
			echo Zend_Json::encode($jsonArray);exit;	
			
		} catch ( Exception $e ) {
			echo $e->getMessage ();
			exit;
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

