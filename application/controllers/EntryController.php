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
	public function addAction() {
		try {
		$this->view->datenow=date('Y年m月d日');
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
			//print_r($p);exit;
			$p['goodsnum']=intval($p['goodsnum']);
			
			if(empty($p['goodsno']))
				throw new Exception ( '商品编号不能为空！' );

			if(!$p['goodsnum'])
				throw new Exception ( '数量不正确！' );

			if(empty($p['inprice']) )
				throw new Exception ( '零售价格格式错误！' );

			
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
					$this->_dbAdapter ->query ( 'update goods set goodsnum=goodsnum+'.$p['goodsnum'].' where goodsno="'.$p['goodsno'].'"');
				}
			
			if($result)
				$this->feedback ( '保存新商品成功', '注意', '/'.$this->controller.'/add', 'warning' );
			else	
				throw new Exception ( '保存新商品失败 ！' );
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

