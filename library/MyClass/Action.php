<?php
/**
 * sec osm project 
 * 
 * @final
 * @package lilyenglish
 * @version $Id:$
 * @copyright 2007 demengqi
 * @author ronghui huang <demenqi@gmail.com> 
 */
class MyClass_Action extends Zend_Controller_Action {

	protected $_user = NULL;
	protected $_smarty = NULL;
	protected $_dbAdapter = NULL;
	protected $_set = NULL;
	protected $actionname=array('sail'=>'销售','set'=>'设置','stat'=>'统计','user'=>'权限','history'=>'记录','goods'=>'库存','entry'=>'入库');
		public function commonAction() {
		
		$this->controller = $this->getRequest ()->getControllerName ();
		$this->action = $this->getRequest ()->getActionName ();
		$this->view->controller=$this->controller;
		$this->view->action=$this->action;
		$this->view->actionname=$this->actionname;
		$this->view->isNoHead =0;
	
		if($this->controller != 'login' && $this->controller!='error'){
					
			$this->_user = $this->checkLogin ();
			$this->view->_user=$this->_user;

			$user_can_action=explode(',',$this->_user->action_list);
			if(!in_array($this->controller,$user_can_action) && $this->controller != 'index')
				$this->_redirect ( '/' );
			
			$this->view->user_can_action=$user_can_action;	
		}

		$this->_dbAdapter = Zend_Registry::get('db');
		
		$this->setting=$this->_dbAdapter->fetchPairs('select variable,value from settings');
		$this->setting['actionlist']=explode(',',$this->setting['actionlist']);
		$this->view->setting=$this->setting;
		
	}
	
		
	public function getDbCache($filename) {
		//$dbcache = $this->_config->dbcache->toArray ();
		$dirname = PROJECT_ROOT . $this->_config->dbcache->dir;
		
		$file_name = $dirname . '/' . $filename . '.php';
		//print_r($file_name );
		if(file_exists($file_name))
			$arrayRes = include $file_name;
		else
			$arrayRes =array();	
			
		return $arrayRes;
	}
	

	public function isPost() {
		return $this->_request->isPost ();
	}
	
	public function getParam($key, $default = NULL) {
		return $this->_getParam ( $key, $default );
	}
	
	public function checkLogin() {
		$auth = Zend_Auth::getInstance ();
		if (! $auth->hasIdentity ()) {
			return $this->_redirect ( '/login' );
		}
		$userinfo=$auth->getIdentity();
		if(!isset($userinfo->id) || empty($userinfo->id))
			return $this->_redirect ( '/login' );
		
		return $userinfo;
	}

	public function isAllowed($res, $priv, $extra = true) {
		if (is_NULL ( $res )) {
			$request = $this->getRequest ();
			$res = $request->getModuleName ();
			$res .= '_' . $request->getControllerName ();
			$res .= '_' . $this->getRequest ()->getActionName ();
		}
		$result = $this->_user->isAllowed ( $res, $priv, $extra );
		return $result;
	}
	
	public function feedback($messgae, $title, $backUrl = 'javascript:window.history.back()', $icon = 'note',$delay=3) {
			$param = array ('message' => $messgae, 'title' => $title, 'url' => $backUrl, 'icon' => $icon ,'delay'=>$delay);
			$this->_forward ( 'message', 'error', '', $param );
	}
	
	public function log($message){        
		$log=Zend_Registry::get("logger");
		$log->setEventItem('modules', $this->_request->getModuleName() );
		$log->setEventItem('controller', $this->_request->getControllerName() );
		$log->setEventItem('action', $this->_request->getActionName() );
		$log->log($message,8);
		//使用方法	$this->log(var_export($course, true));
	}
	    
		public function authcode($string, $operation, $key = '') {

        $discuz_auth_key = md5('8c54c2u29esavcR3' . $_SERVER ['HTTP_USER_AGENT']);
        $key = md5($key ? $key : $discuz_auth_key );
        $key_length = strlen($key);

        $string = $operation == 'DECODE' ? base64_decode($string) : substr(md5($string . $key), 0, 8) . $string;
        $string_length = strlen($string);

        $rndkey = $box = array();
        $result = '';

        for ($i = 0; $i <= 255; $i++) {
            $rndkey [$i] = ord($key [$i % $key_length]);
            $box [$i] = $i;
        }

        for ($j = $i = 0; $i < 256; $i++) {
            $j = ($j + $box [$i] + $rndkey [$i]) % 256;
            $tmp = $box [$i];
            $box [$i] = $box [$j];
            $box [$j] = $tmp;
        }

        for ($a = $j = $i = 0; $i < $string_length; $i++) {
            $a = ($a + 1) % 256;
            $j = ($j + $box [$a]) % 256;
            $tmp = $box [$a];
            $box [$a] = $box [$j];
            $box [$j] = $tmp;
            $result .= chr(ord($string [$i]) ^ ($box [($box [$a] + $box [$j]) % 256]));
        }

        if ($operation == 'DECODE') {
            if (substr($result, 0, 8) == substr(md5(substr($result, 8) . $key), 0, 8)) {
                return substr($result, 8);
            } else {
                return '';
            }
        } else {
            return str_replace('=', '', base64_encode($result));
        }
    }
	
}
