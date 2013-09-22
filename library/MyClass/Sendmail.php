<?php
/**
* send mail
* 参数：邮件标题，邮件内容，收信人，发信人，发信人称呼
* sendMail("测试zend","这是一个测试！","sjf122@gmail.com",$from="sjf122@126.com",$from_name="系统信箱")
*/
function MyClass_Sendmail($title,$content,$to,$from="sjf122@126.com",$from_name="系统信箱"){
	        /**
			* smtp的用户名和密码设置
			*/
			$config = array('auth' => 'login',
						'username' => 'sjf122',
						'password' => 'sjf57598488');
			$smtp_server = "smtp.126.com";
			
            /**
			* 连接smtp服务器
			*/
            $transport = new Zend_Mail_Transport_Smtp($smtp_server, $config);
            /**
			* 邮件发送类的实例，使用gb2312编码
			*/
            $mail = new Zend_Mail("gb2312");
			/**
			* 编码转换
			*/
			$content = iconv ("UTF-8","gb2312",$content);
			$title = iconv ("UTF-8","gb2312",$title);
			$from_name = iconv ("UTF-8","gb2312",$from_name);
            
			$mail->setSubject($title);
			$mail->setBodyText($content);
            $mail->setFrom($from,$from_name);
			/**
			* 收信人是数组
			*/
            if (is_array($to)){
			     while(list($key,$value)=each($to)){
				     $mail->addTo($value);
				 }
			}else{
			    $mail->addTo($to);
            }
			/**
			* 发送
			*/
            $mail->send($transport);
}