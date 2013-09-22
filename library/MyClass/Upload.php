<?php
/**
 *版权说明：该版本是在“IEB_UPLOAD CLASS Ver 1.1”的基础上二次开发的，原程序对图片的裁剪将使图片变形、失真！本程序用数据参数与原图片文件参数(主要是指宽和高)进行对比，得出比例值，先生成与原图片同比例缩放的图片，然后再以该中间图中心开始截取，从而获得缩略图，当然，图片会被裁剪，但是是最小限度的裁剪！
 *@author：swin.wang  Email: php_in_china@yahoo.com.cn
 *@update:  sunbeam   Email: sunjingzhi2@126.com
 */
class MyClass_Upload {
	
	/**
	 * 表单中 文件框<input type="file" id="FileName" name="FileName">名称
	 * @var string 
	 */
	protected $FileName = "";
	
	/**
	 * 上传目录
	 * @var string
	 */
	protected $Directroy = "";
	
	/**
	 * 最大文件大小
	 * @var int
	 */
	protected $MaxSize = 4096555;
	
	/**
	 * 是否可以上传
	 * @var bool
	 */
	protected $CanUpload = true;
	
	/**
	 * 上传文件名
	 * @var string
	 */
	protected $doUpFile = '';
	
	/**
	 * 缩略图名
	 * @var string
	 */
	protected $sm_File = '';
	
	/**
	 * 异常号
	 * @var int
	 */
	protected $Error = 0;
	
	/**
	 * 构造函数
	 *
	 * @param  string  $FileName
	 * @param  string  $dirPath
	 * @param  int  $maxSize
	 * @return  null
	 */
	public function __construct($FileName = '', $dirPath = '', $maxSize = 2097152) //(1024*2)*1024=2097152 就是 2M
{
		//global $FileName, $Directroy, $MaxSize, $CanUpload, $Error, $doUpFile, $sm_File;
		//初始化各种参数
		$this->FileName = $FileName;
		$this->MaxSize = $maxSize;
		
		if ($FileName == '') {
			$this->CanUpload = false;
			$this->Error = 1;
			break;
		}
		
		if ($dirPath != '') {
			$this->Directroy = $dirPath;
		} else {
			$this->Directroy = './';
		}
	}
	
	/**
	 * 检查文件是否存在
	 * 
	 * @return bool 
	 */
	public function scanFile() {
		if ($this->CanUpload) {
			$scan = is_readable ( $_FILES [$this->FileName] ['name'] );
			
			if ($scan) {
				$this->Error = 2;
			}
			
			return $scan;
		}
	}
	
	/**
	 * 获取文件大小
	 * 
	 * @return int 
	 */
	public function getSize($format = 'B') {
		
		if ($this->CanUpload) {
			if ($_FILES [$this->FileName] ['size'] == 0) {
				$this->Error = 3;
				$this->CanUpload = false;
			}
			switch ($format) {
				case 'B' :
					return $_FILES [$this->FileName] ['size'];
					break;
				
				case 'M' :
					return ($_FILES [$this->FileName] ['size']) / (1024 * 1024);
			}
		}
	}
	
	/**
	 * 获取文件类型
	 * 
	 * @return string 
	 */
	public function getExt() {
		if ($this->CanUpload) {
			$ext = $_FILES [$this->FileName] ['name'];
			$extStr = explode ( '.', $ext );
			$count = count ( $extStr ) - 1;
		}
		return $extStr [$count];
	}
	
	/**
	 * 获取文件名称
	 * 
	 * @return string 
	 */
	public function getName() {
		if ($this->CanUpload) {
			return $_FILES [$this->FileName] ['name'];
		}
	}
	
	/**
	 * 新建文件名
	 * 
	 * @return string 
	 */
	public function newName() {
		if ($this->CanUpload) {
			$FullName = $_FILES [$this->FileName] ['name'];
			
			$extStr = explode ( '.', $FullName );
			$count = count ( $extStr ) - 1;
			$ext = $extStr [$count];
			
			$rand = '';
			for($i = 0; $i < 4; $i ++)
				$rand .= rand ( 0, 9 );
			
			return date ( 'YmdHis' ) . $rand . '.' . $ext;
		}
	}
	
	/**
	 * 上传文件，失败时返回异常类型号
	 * 
	 * @param   string   $fileName
	 * @return    
	 */
	public function upload($fileName = '') {
		if ($this->CanUpload) {
			if ($_FILES [$this->FileName] ['size'] == 0) {
				$this->Error = 3;
				$this->CanUpload = false;
				return $this->Error;
				break;
			}
		}
		
		if ($this->CanUpload) {
			if ($fileName == '') {
				$fileName = $_FILES [$this->FileName] ['name'];
			}
			
			$this->doUpload = @move_uploaded_file ( $_FILES [$this->FileName] ['tmp_name'], $this->Directroy . $fileName );
			
			if ($this->doUpload) {
				$this->doUpFile = $fileName;
				@chmod ( $this->Directroy . $fileName, 0777 );
				return true;
			} else {
				$this->Error = 4;
				return $this->Error;
			}
		}
	}
	
	/**
	 * 创建图片缩略图,成功返回真，否则返回错误类型号
	 *
	 * @param string $dscChar   前缀
	 * @param int $width    缩略图宽
	 * @param int $height   缩略图高
	 * @return 
	 */
	/*
 public function thumb($dscChar='.thumb.jpg',$width=200,$height=200)
 {  
  if ($this->CanUpload && $this->doUpFile != ''){
   $srcFile = $this->doUpFile;
   
   $dscFile = $this->Directroy.$srcFile.$dscChar;
   $data = getimagesize($this->Directroy.$srcFile,&$info);
   
   switch ($data[2]) {
    case 1:
    $im = @imagecreatefromgif($this->Directroy.$srcFile);
    break;
    
    case 2:
    $im = @imagecreatefromjpeg($this->Directroy.$srcFile);
    break;
    
    case 3:
    $im = @imagecreatefrompng($this->Directroy.$srcFile);
    break;
   }
   
   $srcW=imagesx($im);
   $srcH=imagesy($im);
 //等比例缩放

if( $srcW > $width || $srcH > $height ) {
   if( $srcW > $srcH ) {
       $temp_width = $width;
       $temp_height = $temp_width * $srcH / $srcW;
       $src_X=abs(($width-$temp_width)/2);
       $src_Y=0;

   } else {
       $temp_height = $height;
       $temp_width = $temp_height * $srcW / $srcH;
     $src_X=0;
    $src_Y=abs(($height-$temp_height)/2);
     }
} else {
   // although within size restriction, we still do the copy/resize process
   // which can make an animated GIF still
   $temp_width = $srcW;
   $temp_height = $srcH;
      $src_X=0;
    $src_Y=0;        
}

 
$imtn = imagecreatetruecolor( $temp_width, $temp_height );
// if the image has transparent color, we first extract the RGB value of it,
// then use this color to fill the thumbnail image as the background. This color
// is safe to be assigned as the new transparent color later on because it will
// be filtered by imagecopyresize.
$originaltransparentcolor = imagecolortransparent( $im );
if(
   $originaltransparentcolor >= 0 // -1 for opaque image
   && $originaltransparentcolor < imagecolorstotal( $im )
   // for animated GIF, imagecolortransparent will return a color index larger
   // than total colors, in this case the image is treated as opaque ( actually
   // it is opaque )
) {
   $transparentcolor = imagecolorsforindex( $im, $originaltransparentcolor );
   $newtransparentcolor = imagecolorallocate(
       $imtn,
       $transparentcolor['red'],
       $transparentcolor['green'],
       $transparentcolor['blue']
   );
   // for true color image, we must fill the background manually
   imagefill( $imtn, 0, 0, $newtransparentcolor );
   // assign the transparent color in the thumbnail image
   imagecolortransparent( $imtn, $newtransparentcolor );
}

   $temp_img=imagecreatetruecolor($temp_width,$temp_height);
   imagecopyresized($temp_img,$im,0,0,0,0,$temp_width,$temp_height,$srcW,$srcH);
      
   imagecopyresized($imtn,$temp_img,0,0,$src_X,$src_Y,$width,$height,$width,$height);
   $cr = imagejpeg($imtn,$dscFile);
   chmod($dscFile, 0777);
      
   if ($cr){
    $this->sm_File = $dscFile;
    return true;
   }else{
    $this->Error = 5;
    return $this->Error;
   }
  }
 }
 
*/
	
	/**
	 * 返回错误类型号，用做异常处理
	 *
	 * @return int
	 */
	public function Err() {
		return $this->Error;
	}
	
	/**
	 * 上传后的文件名
	 *
	 * @return unknown
	 */
	public function UpFile() {
		if ($this->doUpFile != '') {
			return $this->doUpFile;
		} else {
			$this->Error = 6;
		}
	}
	
	/**
	 * 上传文件的路径
	 *
	 * @return unknown
	 */
	public function filePath() {
		if ($this->doUpFile != '') {
			return $this->Directroy . $this->doUpFile;
		} else {
			$this->Error = 6;
		}
	}
	
	/**
	 * 缩略图文件名称
	 *
	 * @return unknown
	 */
	public function thumbMap() {
		if ($this->sm_File != '') {
			return $this->sm_File;
		} else {
			$this->Error = 6;
		}
	}
	
	/**
	 * 版本信息
	 *
	 * @return unknown
	 */
	public function ieb_version() {
		return 'Ver 0.1';
	}
}

?>