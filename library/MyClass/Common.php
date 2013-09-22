<?php
/**
 * sec osm project 
 * 
 * @final
 * @package lilyenglish
 * @version $Id:$
 * @copyright 2007 demengqi
 * @author ronghui huang <demenqi@gmail.com> 
 * @license PHP Version 3.0 {@link http://www.php.net/license/3_0.txt}
 */
class MyClass_Common
{
    /*
    获取IP地址

    */
    static function getIP ()
    {
        global $_SERVER;
        if (getenv('HTTP_CLIENT_IP')) {
            $ip = getenv('HTTP_CLIENT_IP');
        } else if (getenv('HTTP_X_FORWARDED_FOR')) {
            $ip = getenv('HTTP_X_FORWARDED_FOR');
        } else if (getenv('REMOTE_ADDR')) {
            $ip = getenv('REMOTE_ADDR');
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }
        return $ip;
    }

    static function check_emailformat($email) {
        return strlen($email) > 6 && preg_match('/^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/', $email);
    }


    /*
    * string get_zodiac_sign(string month, string day)
    * 输入：月份，日期
    * 输出：星座名称或者错误
    */

    static function get_zodiac_sign($month, $day)
    {
        // 检查参数有效性
        if ($month < 1 || $month > 12 || $day < 1 || $day > 31)
        return (false);

        // 星座名称以及开始日期
        $signs = array(
        array( "20" => "水瓶座"),
        array( "19" => "双鱼座"),
        array( "21" => "白羊座"),
        array( "20" => "金牛座"),
        array( "21" => "双子座"),
        array( "22" => "巨蟹座"),
        array( "23" => "狮子座"),
        array( "23" => "处女座"),
        array( "23" => "天秤座"),
        array( "24" => "天蝎座"),
        array( "22" => "射手座"),
        array( "22" => "摩羯座")
        );
        list($sign_start, $sign_name) = each($signs[(int)$month-1]);
        if ($day < $sign_start)
        list($sign_start, $sign_name) = each($signs[($month -2 < 0) ? $month = 11: $month -= 2]);
        return $sign_name;

    } // end of function.


    /**
	 *	获得日期信息，用xx分钟前，小时前，天前表示，2天以上的返回实际时间
	 *  传入时间 例如 time()
	 */
    static function getDateInfo($timeinfo)
    {
        if(empty($timeinfo))
        return '';
        
        $timeNow = date('U');
/*
        $datetemp=explode(' ',$dateinfo);
        $date_0=explode('-',$datetemp[0]);
        $date_1=explode(':',$datetemp[1]);
        if(!isset($date_1[2]))
        $date_1[2]=0;
        $dateinfo=mktime($date_1[0],$date_1[1],$date_1[2],$date_0[1],$date_0[2],$date_0[0]);
*/
        $diff = $timeNow - $timeinfo;

        if ($diff > 60 * 60 * 24 * 2)   // 两天前
        return date('Y-m-d H:i', $timeinfo);

        $secs = $diff % 60;
        $mins = floor($diff/60) % 60;
        $hours = floor($diff/60/60) % 24;
        $days = floor($diff/60/60/24);
        $str='';
        if ($days > 0)
        $str .= $days.'天';
        if ($hours > 0 || $days > 0)
        $str .= $hours.'小时';
        if($mins < 0)
        $mins = 0;
        $str .= $mins.'分钟前';

        return $str;

    }

    static function get_avatar($uid, $size = 'big') {
        $size = in_array($size, array('big', 'middle', 'small')) ? $size : 'big';
        $uid = abs(intval($uid));
        $uid = sprintf("%09d", $uid);
        $dir1 = substr($uid, 0, 3);
        $dir2 = substr($uid, 3, 2);
        $dir3 = substr($uid, 5, 2);
        return $dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2)."_avatar.$size.jpg";
    }


    static function getWeekCn ($id=0)
    {
		$array=array('星期日','星期一','星期二','星期三','星期四','星期五','星期六','星期日');
    	return $array[$id];
    }	    
   
  
  /**
* 根据生日中的年份来计算所属生肖
* 
* @param int $birth_year
* @return string
*/
    static function get_animal($birth_year)
{
$animal = array(
      '鼠宝宝','牛宝宝','虎宝宝','兔宝宝','龙宝宝','蛇宝宝',
      '马宝宝','羊宝宝','猴宝宝','鸡宝宝','狗宝宝','猪宝宝'
      );

$my_animal = ($birth_year-1900)%12;
return $animal[$my_animal];
}
   
}
