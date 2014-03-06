<?php
/*
日结单
*/
class HistoryController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {
			
			$nowday=date('Y-m-d');
			//$nowday='2014-02-15';
			$this->view->nowday=$nowday;
			$this->view->current_username=$this->_user->username;
			
			$sql='select * from sail_order_v where day="'.$nowday.'" and opuserid='.$this->_user->id;
			//$sql='select * from sail_order_v where 1';
			$result_tmp=$this->_dbAdapter->fetchAll($sql);
			$result=array();
			if($result_tmp){
				$sum=array('sailnum'=>0,'yingshou'=>0,'shishou'=>0,'card'=>0,'cash'=>0);
				foreach($result_tmp as $key => $value){
					
					if(!isset($result[$value['orderid']])){
						if($value['paytype']=='cash'){
							$result[$value['orderid']]['paytypeDisp']='现金';
						}elseif($value['paytype']=='card')
							$result[$value['orderid']]['paytypeDisp']='刷卡';
						else{
							$result[$value['orderid']]['paytypeDisp']='未登记';
						}
						$result[$value['orderid']]['yingshou']=$value['yingshou'];
						$result[$value['orderid']]['shishou']=$value['shishou'];
						$result[$value['orderid']]['orderno']=$value['orderno'];
						$result[$value['orderid']]['sailnum']=$value['sailnum'];
						
					if($value['paytype']=='cash')
						$sum['cash'] +=$value['shishou'];
					elseif($value['paytype']=='card')
						$sum['card'] +=$value['shishou'];
						
					}
					$value['priceall']=$value['price']*$value['goodsnum'];
					$value['truepriceall']=$value['trueprice']*$value['goodsnum'];
					
					$result[$value['orderid']]['goodslist'][]=$value;
					
					$sum['sailnum'] +=$value['goodsnum'];
					$sum['yingshou'] +=$value['truepriceall'];
					$sum['shishou'] +=$value['priceall'];

				}	
				unset($result_tmp);	
				$this->view->ordernum=count($result);
				$this->view->printdatetime=date('Y-m-d H:i:s');
				$this->view->sum=$sum;
			}
			//print_r($result);
			$this->view->result=$result;
			
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

