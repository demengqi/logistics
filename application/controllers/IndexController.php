<?php

class IndexController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {

		$this->_redirect ( '/sail' );
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

