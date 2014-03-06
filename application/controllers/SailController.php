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
    [orderno] => 20130805001001
    [day] => 2013-08-05
    [goodsnum] => Array
        (
            [0] => 1
        )

    [price] => Array
        (
            [0] => 80.00
        )

    [yingshou] => 80.00
    [shishou] => 80.00
    [laikuan] => 100
    [zhaohui] => 20.00
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
			if($p['laikuan']<=0)
				throw new Exception ('来款不能为0');
			if($p['laikuan']<$p['shishou'])
				throw new Exception ('来款不能少于实收金额');
			
			if(($p['laikuan']-$p['zhaohui'])<>$p['shishou'])
				throw new Exception ('来款-找回<>实收');
			
			$sailnum=0;
			foreach($p['goodsid'] as $key => $value){
				$sailnum +=$p['goodsnum'][$key];
			}
			$datetime=date('Y-m-d H:i:s');
			$data=array('orderno'=>$p['orderno'],
				'day'=>$p['day'],
				'sailnum'=>$sailnum,
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
			if(!$result)
				throw new Exception ('保存失败或已保存');
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
					'discount'=>0,
					'adduserid'=>$this->_user->id,
					'addtime'=>$datetime,
				);
				$result=$this->_dbAdapter->insert('sails',$data);
				if($result){
					$i++;
				    $this->_dbAdapter->query('update goods set goodsnum=goodsnum-'.$p['goodsnum'][$key].' where goodsid='.$value);
						
				}
			}
			if($i==count($p['goodsid'])){
				$this->feedback ( '订单['.$p['orderno'].']处理成功!', '恭喜', '/'.$this->controller, 'warning' );
			}else{
				$this->_dbAdapter->delete('sails','orderid='.$insertid);
				$this->_dbAdapter->delete('orders','orderid='.$insertid);
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
			
			$sql='select * from goods where goodsno like "%'.$goodsno.'%" or goodsname like "%'.$goodsno.'%" and goodsnum>0 and isover=0';
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

