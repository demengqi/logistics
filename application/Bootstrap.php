<?php
class Bootstrap extends Zend_Application_Bootstrap_Bootstrap {
	private $_db = null;

	function __construct($app){
	    parent::__construct($app);
	}  
	
    protected function _initRequest() {
		
        $this->bootstrap ( 'FrontController' );
        $front = $this->getResource ( 'FrontController' );
        $request = $front->getRequest ();
        if (null === $front->getRequest ()) {
            $request = new Zend_Controller_Request_Http ();
            $front->setRequest ( $request );
        }
        return $request;
    }
	
	protected function _initConfig() {
	   $config = new Zend_Config($this->getOptions());
	   Zend_Registry::set('config', $config);
	}
	
 /**
     * Bootstrap Smarty view
     */
    protected function _initView()
    {
        // initialize smarty view
        $view = new MyClass_View_Smarty($this->getOption('smarty'));
		//print_r($view);exit;
        // setup viewRenderer with suffix and view
        $viewRenderer = Zend_Controller_Action_HelperBroker::getStaticHelper('ViewRenderer');
        $viewRenderer->setViewSuffix('tpl');
        $viewRenderer->setView($view);

        // ensure we have layout bootstraped
        $this->bootstrap('layout');
        // set the tpl suffix to layout also
        $layout = Zend_Layout::getMvcInstance();
        $layout->setViewSuffix('tpl');

        return $view;
    }
	

	protected function _initSession() {
		$sessionConfig = $this->getOption('session');
		//print_r($sessionConfig);
		$sessionConfig['save_path']=PROJECT_ROOT . '/' .$sessionConfig['save_path'];
		Zend_Session::setOptions ( $sessionConfig );
	}
	
	protected function _initDB()
	{
		$dbResource = $this->getPluginResource('db');
		$dbAdapter = $dbResource->getDbAdapter();
		Zend_Registry::set('db', $dbAdapter);

	}
	
	
	protected function _initLog() {

		$logs=$this->getOption('logs');
		$logpath =PROJECT_ROOT.$logs['dir'].'/';

   		$curLogDir = $logpath . date('Ym');
	    $logFile = $curLogDir . '/'. date('d') .'.txt';    
	
		if( !is_dir( $curLogDir ) ){
			try {
				mkdir( $curLogDir , 0755);
			} catch (Exception $e) {
				echo nl2br($e->__toString());
			}          
		} 
		
		$writer = new Zend_Log_Writer_Stream( $logFile );       
		$format = '%timestamp% : %message% -[%priorityName% ]-[%modules%]-[%controller%]-[%action%] '. PHP_EOL;
		$formatter = new Zend_Log_Formatter_Simple($format);
		$writer->setFormatter($formatter);        

		$logger = new Zend_Log($writer);
		$logger->addPriority(MyClass_Common::getIP(),8);

		Zend_Registry::set('logger',$logger);
    }

}