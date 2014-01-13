<?php
/*
	入库单
*/
class EntryController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//入库单列表
	public function indexAction() {
		try {

			$where = '';
			$order = ' order by `entryid` desc';
			$this->view->goodsno=$goodsno = $this->_request->getParam ( 'goodsno' );

			if(!empty($goodsno)){
				$where .=' and (goodsno like "%'.$goodsno.'%" or goodsname like "%'.$goodsno.'%")';
			}
		$sql = 'SELECT  * FROM entry where 1 ' . $where . $order ;
		//echo $sql;exit;
		$result = $this->_dbAdapter->fetchAll ( $sql );

			//print_r($result);
			$this->view->result = $result;
			


		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		//用户首页
	public function addAction() {
		try {
		$this->view->datenow=date('Y年m月d日');
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

