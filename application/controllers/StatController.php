<?php
/*
统计
*/
class StatController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//销售统计
	public function indexAction() {
		try {
			
			$this->view->start_date=$start_date = $this->_request->getParam ( 'start_date' );
			$this->view->end_date=$end_date =$this->_request->getParam ( 'end_date' );
			$this->view->goodsno=$goodsno = $this->_request->getParam ( 'goodsno' );
			if($end_date=='')
				$this->view->end_date=$end_date=date('Y-m-d');
			
			$result=array();
			$sum=array('goodsnum'=>0,'inprice'=>0,'trueprice'=>0,'price'=>0,'lirun'=>0);
			if($start_date && $end_date){
				$sql='select goodsno,goodsname,unitname,sum(goodsnum) as goodsnum,sum(price) as price,sum(trueprice) as trueprice,sum(inprice) as inprice from sail_order_v where day>="'.$start_date.'" and day <="'.$end_date.'" group by goodsno';
				$result=$this->_dbAdapter->fetchAll($sql);
				if($result){
					foreach($result as $key => $value){
						$result[$key]['lirun']=$value['price']-$value['inprice'];
						$sum['goodsnum'] +=$value['goodsnum'];
						$sum['inprice'] +=$value['inprice'];
						$sum['trueprice'] +=$value['trueprice'];
						$sum['price'] +=$value['price'];
						$sum['lirun'] +=$value['price']-$value['inprice'];
					}
				}
				

				//print_r($result);
			}
			
			$this->view->result=$result;
			$this->view->sum=$sum;
		
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

