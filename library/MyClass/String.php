<?php
/**
* @package STRING
* @filesource
*/

/** 
* 类名:字符串操作类
* 
* 描述:本class作用是字符串操作
*
* @author  junfeng.song <junfeng.song@square-enix.net.cn>
* @access  public
* @copyright square-enix
* @version CVS: $Id: class.string.php 2007/09/11 19:48:47 junfeng.song $
* @package STRING
* @link       http://www.square-enix.net.cn/
*/
class STRING {

/**
 * 函数作用描述:清除字符串开头的空格，并转义html标记,对特殊的字符进行加/ 可以过滤数组，如 $string = array( $_GET["a"],$_GET["b"]);
 *
 * @access 权限:public
 * @param  参数名:string $clearstring需要过滤得字符串或数组
 * @return 返回值:返回过滤后的字符串或数组
 */
	static function Clearstring ( $clearstring){ 
		if ( !is_array( $clearstring)){
			$clearstring = addslashes(htmlspecialchars ( trim ( $clearstring)));		
			return $clearstring;
		}
		else{
			$clearstring_end = array();
			while (list($key,$value) = each ( $clearstring)) {
					$value = addslashes(htmlspecialchars ( trim ( $value)));
					$clearstring_end[$key] = $value;					
			} 
			return $clearstring_end;
		}
	}
	
/**
 * 函数作用描述:判断是否是email  是的话返回true,否则返回false
 *
 * @access 权限:public
 * @param  参数名:email 参数email地址
 * @return 返回值:是email的话返回true，否则返回false 
 */
	static function Isemail($email) {
		return strlen($email) > 6 && preg_match("/^[\w\-\.]+@[\w\-]+(\.\w+)+$/", $email);
	}
/**
 * 函数作用描述:判断是否是数字和字母组成 ，是的话返回true,否则返回false
 *
 * @access 权限:public
 * @param  参数名:string 参数字符串
 * @return 返回值:是的话返回true，否则返回false 
 */	
	static function Is_num_letter($string) {
		return preg_match ("/^([0-9a-zA-Z]+)$/", $string);
	}
	
/**
 * 函数作用描述:截取汉字字符串 ，是的话返回true,否则返回false
 *
 * @access 权限:public
 * @param  参数名:string $str为要截取的字符串
 * @param  参数名:string $len为截取长度数字,一个汉字为2位
 * @return 返回值:返回被截取后的字符串
 */
	static function Cutcnstring ( $len ,$str){
	
		$str = STRING :: Clearstring ( $str);
    
		if ( $len <=0){  
			return $str;      
		 }
    	else {        
			$sLen = strlen ( $str);         
			if ( $len >= $sLen)        
		   		 return $str;        
			else{        
		   		 for ( $i = 0; $i < ( $len-1); $i++){                
					if ( ord ( substr ($str,$i,1)) > 0xa0)                    
						$i++;
           		 }            
				if ( $i >= $len)            
			   		 return substr ( $str, 0, $len);            
				elseif ( ord ( substr ( $str, $i, 1)) > 0xa0)            
			   			 return substr ( $str, 0, $len-1);            
					else             
			  			 return substr ( $str, 0, $len);
        	}
   	    }
	}

/**
 * 函数作用描述:数组转换为要写入文件的PHP形式 
 *
 * @access 权限:public
 * @param  参数名:string $string 输出的字符串名
 * @param  参数名:array $array参数 数组
 * @return 返回值:返回转换后的字符串
 */
	static function Array_to_php( $string,$array){
	    $i = 0;
		if (is_array($array)){
			$count = count($array);
			$array_string = $string."=array(";
			while(list($key,$value)=each($array)){
				
				$array_string_a ="\"".$key."\"=>\"".$value."\",";
				$i = $i+1;
				if ( $i == $count)
					$array_string_a ="\"".$key."\"=>\"".$value."\"";
				$array_string .= $array_string_a;
			}
			$array_string .= ");";
			return ($array_string );
		}
	}

/**
 * 函数作用描述:当需要以空格分割字符串时去掉字符串中间出现的多于1个的连续空格 
 *
 * @access 权限:public
 * @param  参数名:string $sjf_tags要去除多余空格的字符串
 * @return 返回值:去除多余空格后的字符串
 */
	static function Clearspace( $sjf_tags){
				
				$sjf_tags = trim($sjf_tags);
				if ( $sjf_tags ==" " || $sjf_tags =="")
					return ( "");
					
				$sjf_tags = explode(" ",$sjf_tags);	
				$sjf_tags_new = array();	
				while(list(,$value) = each( $sjf_tags)){
					$value = strip_tags(trim($value));
					if ( $value!="" && $value!=" "){
						array_push( $sjf_tags_new, $value) ;
					}
				}
				
				$sjf_tags = $sjf_tags_new;	
				/**
				* 去除重复值
				*/
				$sjf_tags = array_unique ($sjf_tags);				
				$sjf_tags=implode(" ",$sjf_tags);				
				return ( $sjf_tags);
	}
}
function shuzu($array,$a=0){
	    echo "<pre>";
		print_r ($array);
		echo "</pre>";
        if ($a == 0){
		    exit;
		}
	}