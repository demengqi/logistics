<?php
/*
商品销售
*/
class SailController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;
	protected $_dbAdapter;
	public function init() {
		
		$this->commonAction();	
	
	}
	//用户首页
	public function indexAction() {
		try {

		$time=time();
		$this->view->date=date('Y-m-d',$time);
		$orderno=$this->getOrderNo($time);
		$this->view->orderno=$orderno;
		
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	/*
	处理订单

Array
(
    [orderno] => 20140123001001
    [workid] => 01
    [day] => 2014-01-23
    [goodsnum] => Array
        (
            [0] => 1
        )

    [price] => Array
        (
            [0] => 12.00
        )

    [trueprice] => Array
        (
            [0] => 12.00
        )

    [goodsid] => Array
        (
            [0] => 3
        )

    [goodsno] => Array
        (
            [0] => 001
        )

    [yingshou] => 12.00
    [shishou] => 12.00
    [laikuan] => 100
    [zhaohui] => 88.00
    [paytype] => 1
)

	*/
	public function saveorderAction(){
		try {
			
			if (! $this->isPost ()) {
					throw new Exception ( -1 );
			}
			
			$p=$this->_request->getPost ();
			//print_r($p);exit;
			if(!isset($p['goodsid']) || !is_array($p['goodsid']))
				throw new Exception ('参数错误');
			
			$this->_dbAdapter->query("BEGIN"); 

			$datetime=date('Y-m-d H:i:s');
			$data=array(
			    'orderno'=>$p['orderno'],
				'day'=>$p['day'],
				'yingshou'=>$p['yingshou'],
				'shishou'=>$p['shishou'],
				'laikuan'=>$p['laikuan'],
				'zhaohui'=>$p['zhaohui'],
				'paytype'=>$p['paytype'],
				'opuserid'=>$this->_user->id,
				'workid'=>$this->_user->workid,
				'addtime'=>$datetime,
			);
			$result=$this->_dbAdapter->insert('orders',$data);
			if(!$result){
				$this->_dbAdapter->query("ROLLBACK"); 
				throw new Exception ('保存失败或已保存');
			}
			$insertid=$this->_dbAdapter->lastInsertId();
			
			$i=0;
			foreach($p['goodsid'] as $key => $value){
				$data=array(
					'orderid'=>$insertid,
					'goodsid'=>$value,
					'goodsno'=>$p['goodsno'][$key],
					'goodsnum'=>$p['goodsnum'][$key],
					'price'=>$p['price'][$key],
					'trueprice'=>$p['trueprice'][$key],
					'discount'=>1,
					'adduserid'=>$this->_user->id,
					'addtime'=>$datetime,
				);
				$result=$this->_dbAdapter->insert('sails',$data);
				if($result){
					$i++;
				    $this->_dbAdapter->query('update goods set goodsnum=goodsnum-'.$p['goodsnum'][$key].' where goodsid='.$value);
				}else{
					break;
				}
			}
			if($i==count($p['goodsid'])){
				$this->_dbAdapter->query("COMMIT"); 

				$this->feedback ( '订单处理成功', '恭喜', '/'.$this->controller, 'warning' );
			}else{
				$this->_dbAdapter->query("ROLLBACK"); 
				
				throw new Exception ('操作失败');
			}
			
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
	
	//生成销售单号
	private function getOrderNo($time){
		
		$sql='select count(*) from orders where day="'.date('Y-m-d',$time).'"';
		$allno=$this->_dbAdapter->fetchOne($sql);
		$sailNo=date('Ymd').sprintf('%03d',$this->_user->workid).sprintf('%03d',$allno+1);
		return $sailNo;
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

