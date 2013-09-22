<?php
@header ( 'Content-type:text/html;charset=UTF-8' );
session_cache_limiter ( 'private, must-revalidate' );

date_default_timezone_set ( 'Asia/Shanghai' );

defined ( 'PROJECT_ROOT' ) || define ( 'PROJECT_ROOT', realpath ( dirname(dirname ( __FILE__ ) )) );
define ( 'WEB_ROOT', 'http://' . $_SERVER ['HTTP_HOST'] . '/' );

// Define path to application directory
defined ( 'APPLICATION_PATH' ) || define ( 'APPLICATION_PATH', PROJECT_ROOT. '/application' ) ;

// Define application environment
defined ( 'APPLICATION_ENV' ) || define ( 'APPLICATION_ENV', (getenv ( 'APPLICATION_ENV' ) ? getenv ( 'APPLICATION_ENV' ) : 'production') );

defined ( 'CONFIG_FILE' ) || define ( 'CONFIG_FILE', APPLICATION_PATH . '/configs/application.ini' );

// Ensure library/ is on include_path
set_include_path ( implode ( PATH_SEPARATOR, array (realpath ( PROJECT_ROOT . '/library' ), get_include_path () ) ) );

// Configure autoloader
require_once 'Zend/Loader/Autoloader.php';
$autoloader = Zend_Loader_Autoloader::getInstance ();
$autoloader->setFallbackAutoloader ( true );
$autoloader->suppressNotFoundWarnings ( false );

/** Zend_Application */
//require_once 'Zend/Application.php';  


// Create application, bootstrap, and run
$application = new Zend_Application ( APPLICATION_ENV, CONFIG_FILE );

umask ( 0 );

// Bootstrap and Run
try {
	$application->bootstrap ()->run ();
} catch ( Exception $e ) {
	// handle exceptions
   echo '出现错误了';
   echo nl2br($e->__toString());
	exit;
}
