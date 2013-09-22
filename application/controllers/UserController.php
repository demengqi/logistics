<?php

class UserController extends MyClass_Action {
	protected $controller;
	protected $action;
	protected $_user;


	public function init() {

		$this->commonAction();	

	}
	//用户首页
	public function indexAction() {
		try {
			
			
			$sql='select * from users ';
			$result=$this->_dbAdapter ->fetchAssoc ( $sql );
			foreach($result as $key => $value){
				$result[$key]['action']=explode(',',$value['action_list']);
				$result[$key]['lasttime']=date('Y-m-d H:i',$value['lasttime']);
			}
			$this->view->result=$result;
			

		//print_r($set);
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
		
		//用户首页
	public function opAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			$isok=0;
			foreach($p['username'] as $key => $value){
				if($key==1)
					continue;
					
				$data=array('username'=>$value);
				if(!empty($p['password'][$key]))
					$data['password']=md5($p['password'][$key]);
				
				if(!empty($p['actionlist'][$key]))
					$data['action_list']=implode(',',$p['actionlist'][$key]);
					
				$result=$this->_dbAdapter ->update ( 'users',$data,'id='.$key );
				
				if($result)
					$isok=1;	
			}
			if($isok)
				$this->feedback ( '更新成功', '注意', '/'.$this->controller, 'warning' );
			else	
				throw new Exception ( '更新失败 ！' );
			//print_r($p);exit;
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}
	
	
		//用户首页
	public function changepasswordAction() {
		try {
		} catch ( Exception $e ) {
			$this->feedback ( $e->getMessage (), '注意', 'javascript:window.history.back();', 'warning' );
		}
	}

		//用户首页
	public function opchangepasswordAction() {
		try {
			if (! $this->isPost ()) {
					throw new Exception ( '参数错误！' );
			}
			
			$p =$this->_request->getPost ();
			if (empty ( $p['oldpassword'] )) {
				throw new Exception ( '旧密码不能为空 ！' );
			}
			
			if (empty ( $p['newpassword'])) {
				throw new Exception ( '新密码不能为空！' );
			}
			
			if ($p['repassword'] != $p['repassword']) {
				throw new Exception ( '两次密码不一致！' );
			}
			$p['oldpassword']=md5($p['oldpassword']);
			$sql = 'select password from users where id=' .$this->_user ->id;
			$password=$this->_dbAdapter ->fetchOne ( $sql );
			
			if($password !=$p['oldpassword'])
				throw new Exception ( '旧密码错误 ！' );
			
			$result=$this->_dbAdapter ->update ('users',array('password'=>md5($p['newpassword'])),'id='. $this->_user ->id);
			if($result)
				$this->feedback ( '更新成功', '注意', '/login/out', 'warning' );
			else 
				throw new Exception ( '更新失败 ！' );	

			
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

