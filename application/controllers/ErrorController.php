<?php
class ErrorController extends Zend_Controller_Action {

	public function errorAction() {
		$errors = $this->_getParam ( 'error_handler' );
		
		switch ($errors->type) {
			case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_CONTROLLER :
			case Zend_Controller_Plugin_ErrorHandler::EXCEPTION_NO_ACTION :
				
				// 404 error -- controller or action not found
				$this->getResponse ()->setHttpResponseCode ( 404 );
				$message = 'HTTP 404 网页未找到';
				break;
			default :
				// application error 
				$this->getResponse ()->setHttpResponseCode ( 500 );
				$message = '500 Application error';
				break;
		}
		$requestlist=var_export($errors->request->getParams(), true);
		$this->view->isNoHead=1;	
		$this->view->development=APPLICATION_ENV;
		$this->view->exception=$errors->exception->getMessage() ;
		$this->view->trace=$errors->exception->getTraceAsString();
		$this->view->request=$message;

	}

	public function messageAction() {
		//javascript:window.history.back();
		
		
		$url = $this->getParam ( 'url' );
		
		if (substr ( $url, 0, 10 ) == 'javascript'){
			$urltype = 1;
			$url=substr($url,11,strlen($url));	
		}else
			$urltype = 0;
		$this->view->isNoHead=1;	
		$this->view->url=$url;
		$this->view->urltype=$urltype;
		$this->view->message=$this->getParam ( 'message', 'Unknown notice accrued.' );
		$this->view->title=$this->getParam ( 'title', 'Notice' );
		$this->view->icon=$this->getParam ( 'icon', 'note' ) ;
		$this->view->delay=$this->getParam ( 'delay', 3 ) ;
		
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