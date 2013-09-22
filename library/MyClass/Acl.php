<?php
/** 
* 类名:zend_acl权限判定函数
* 
*
* @author  junfeng.song <junfeng.song@square-enix.net.cn>
* @access  public
* @copyright square-enix
* @version CVS: $Id: acl.php 2007/10/23 19:48:47 junfeng.song $
* @package acl
* @link       http://www.square-enix.net.cn/
*/
class MyClass_Acl {

	private $db;
	private $acl;
	private $name;
	private $pre='lily_';
	/**
	 * constructor
	 */
	public function __construct($name)
	{
		$config = Zend_Registry::get('config');
	    $this->db = Zend_Db::factory('PDO_MYSQL',$config->osmdb->toArray());
		
		$this->name= $name;
        /**
		* cache------------------------------------------------------
		*/
		$frontendOptions = array(
			/**
			* cache缓存时间
			*/
			'lifeTime' => 7200, 
			'automatic_serialization' => true
			);
			
		$backendOptions = array(
            /**
			* cache目录
			*/
			'cache_dir' => ROOT.'/data/cache/'
		);
		
		/**
		* 取得一个Zend_Cache_Core 对象
		*/
		$cache = Zend_Cache::factory('Core', 'File', $frontendOptions, $backendOptions);
		
		if(!$cache->load($name.'_user_group') || !$cache->load($name.'_name') || !$cache->load($name.'_all_access') || !$cache->load($name.'_default_access') || !$cache->load($name.'_special_close_acl') || !$cache->load($name.'_special_open_acl')) {
		    /**
		    * 没有发现缓存acl
		    */
			/**
			* 取值
			*/						
			$select = $this -> db->select();
			$select->from($this->pre.'admin', array('user_group','special_close_acl','special_open_acl'))
				   ->where('name = ?',$name);
			$sql = $select->__toString();

			$result = $this -> db->fetchRow($sql);
				
			$user_group = 	$result['user_group'];			
			$special_close_acl = explode(",",$result['special_close_acl']);
			$special_open_acl = 	explode(",",$result['special_open_acl']);
			
			$select = $this -> db->select();
			$select->from($this->pre.'admin_resource_doresource', array('ourd_sign'));
			$sql = $select->__toString();
			$result = $this -> db->fetchAll($sql);
			$all_access = array();
			while(list($key,$value) = each($result)){
			    array_push($all_access,$value['ourd_sign']);
			}
			//shuzu($all_access);
			$select = $this -> db->select();
			$select->from($this->pre.'admin_group_access', array('ourd_sign'))
			       ->join($this->pre.'admin_group', $this->pre.'admin_group_access.oug_id = '.$this->pre.'admin_group.oug_id', 'oug_id')
			       ->where($this->pre.'admin_group.oug_en_name = ?',$user_group);
				   
			$sql = $select->__toString();
			
			$result = $this -> db->fetchAll($sql);
			$default_access = array();
			while(list($key,$value) = each($result)){
			    array_push($default_access,$value['ourd_sign']);
			}
			//shuzu($default_access);
			/**
			* 建立缓存
			*/
			$cache->save($user_group,$name.'_user_group'); 
			$cache->save($name,$name.'_name'); 
			$cache->save($all_access,$name.'_all_access'); 
			$cache->save($default_access,$name.'_default_access'); 
			$cache->save($special_close_acl,$name.'_special_close_acl'); 
			$cache->save($special_open_acl,$name.'_special_open_acl'); 
		    
		}else{
		    /**
			* 读取缓存
			*/
		    $user_group = $cache->load($name.'_user_group');
			$name = $cache->load($name.'_name');
			$all_access = $cache->load($name.'_all_access');
			$default_access = $cache->load($name.'_default_access');
			$special_close_acl = $cache->load($name.'_special_close_acl');
			$special_open_acl = $cache->load($name.'_special_open_acl');
		}
		/**
		* cache-over--------------------
		*/


		/**
		* 开始构造acl--------------------
		*/
		$this->acl = new Zend_Acl();
		/**
		* 建立用户组$user_group
		*/
		$user_group = new Zend_Acl_Role($user_group);
		$this->acl->addRole($user_group);	
		/**
		* 建立用户$name，属于用户组$user_group
		*/
		$this->acl->addRole(new Zend_Acl_Role($name), $user_group);	
		/**
		* 进行源和权限对应
		*/
		while( list($key,$value) = each ($all_access)){
		    $this->acl->add(new Zend_Acl_Resource($value)); 
		    if (!in_array($value,$default_access)){
			    $this->acl->deny($name, $value);
			}else{
			    $this->acl->allow($name, $value);
			}
		}
		/**
		* 关闭特殊拒绝权限
		*/
		while( list($key,$value) = each ($special_close_acl)){
		    if (in_array($value,$all_access)){
		        $this->acl->deny($name, $value);
			}
		}
		/**
		* 打开特殊打开的权限
		*/
		while( list($key,$value) = each ($special_open_acl)){
		     if (in_array($value,$all_access)){
		        $this->acl->allow($name, $value);
			}
		}
		/**
		* acl-over----------------------
		*/

	}


public function acl($res_name){

		//$acl->isAllowed($name, $res_name) ? $access='ok' : die('denied');
		return $this->acl->isAllowed($this->name, $res_name);
}
}