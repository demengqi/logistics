<?php
/** 
* 类名:logsClass
* 
* 描述:本class作用是根据php文件名称+日期来创建日志文件夹
* 只能在支持php的web服务器上才能运行这个程序
*
* @author  ray <ray@square-enix.net.cn>
* @access  public
* @copyright square-enix
* @version CVS: $Id: example_class.php 2007/09/24 10:13:47  ray $
* @package example_class
* @link       http://www.square-enix.net.cn/
*/

/** Zend_Log_Filter_Priority */
Zend_Loader::loadClass('Zend_Log');
require_once 'Zend/Log/Writer/Stream.php';

class MyClass_Log extends Zend_Log_Writer_Stream{

	 public function __construct($streamOrUrl, $mode = 'a')
    {
		$streamOrUrl = $this->creatLogFile($streamOrUrl);
        if (is_resource($streamOrUrl)) {
            if (get_resource_type($streamOrUrl) != 'stream') {
                throw new Zend_Log_Exception('Resource is not a stream');
            }

            if ($mode != 'a') {
                throw new Zend_Log_Exception('Mode cannot be changed on existing streams');
            }

            $this->_stream = $streamOrUrl;
        } else {
            if (! $this->_stream = @fopen($streamOrUrl, $mode, false)) {
                $msg = "\"$streamOrUrl\" cannot be opened with mode \"$mode\"";
                throw new Zend_Log_Exception($msg);
            }
        }

        $this->_formatter = new Zend_Log_Formatter_Simple();
		
    }
	
	private function creatLogFile($file){
		/**
		* 获取文件名
		*/
		$fileName = str_replace (dirname($file) . "\\","",$file);
		$fileName = str_replace ("/","",$fileName);
		$fileName = explode(".", $fileName);
		/**
		* 设置日志文件夹目录
		*/
		$filePath = LOG_PATH . "/" . $fileName[0];
		
		/**
		* 判断文件夹是否存在 不存在则创建文件夹
		*/
		if(!is_dir($filePath)){
			mkdir($filePath, 0777);
		}
		/**
		* 返回日志文件夹目录
		*/
		return $filePath . "/" . date("Y-m-d") . ".txt";
	}

}