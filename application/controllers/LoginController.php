<?php
/*
 * 登录处理
 */
class LoginController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_dbAdapter;	
	
	public function init() {
		$this->commonAction();	
		$this->view->isNoHead = 1;
	}
	
	public function indexAction() {
		try {

			$sql='select workid from users';
			$workidlist=$this->_dbAdapter->fetchCol($sql);
			$this->view->workidlist=$workidlist;
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
//处理班级登陆	
	public function opAction() {
		
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			//过滤
			//Zend_Loader::loadClass('Zend_Filter_StripTags');
			$filter = new Zend_Filter_StripTags ();
			$workid = trim ( $filter->filter ( $p ['account'] ) );
			$password = trim ( $filter->filter ( $p ['password']) );
			
			if (empty ( $workid )) {
				throw new Exception ( '用户名不能为空！' );
			}
			
			if (empty ( $password )) {
				throw new Exception ( '密码不能为空！' );
			}
			$password=md5($password);
				$data=array(
					'workid'=>$workid,
					'password'=>$password,
				);
			 
	//echo $password;exit;
			$authAdapter = new Zend_Auth_Adapter_DbTable ( $this->_dbAdapter, 'users', 'workid', 'password' );
			$authAdapter->setIdentity ( $workid )->setCredential (   $password  );
			$result = $authAdapter->authenticate ();
			
			if ($result->isValid ()) {
			
				$result_check = $authAdapter->getResultRowObject ();
			   
				$auth = Zend_Auth::getInstance ();
				$auth->getStorage ()->write ( $authAdapter->getResultRowObject ( array ('id','workid','username','action_list') ) );
				 
				//更新登陆信息
			 	$sql = 'update users set login_num=login_num+1, lasttime='.time().' where id=' . $auth->getStorage ()->read ()->id;
				$this->_dbAdapter ->query ( $sql );
				
			
				$this->_redirect ( '/' );		
			} else {
			
				//print_r($authAdapter->getResultRowObject());
				// 获取错误信息
				$msg = '';
				foreach ( $result->getMessages () as $message ) {
					$msg .= "$message\n";
				}
				
				$this->feedback ( 'failure' . $msg, 'note', '/login', 'warning' );
			// 显示错误信息到模板
			//$this->view->msg = $msg;
			}		

			
				$this->_redirect ( '/' );		
			
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', '/', 'warning' );
		}
	}
	


//家长登陆结束
	public function outAction() {
		try {
			
				$auth = Zend_Auth::getInstance ();
				$auth->getInstance ()->clearIdentity ();

			
			$this->feedback ( '退出成功！', '注意', '/login', 'tip' );
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
		// all other methods throw an exception
		throw new Exception ( 'Invalid method "' . $method . '" called' );
	}
}