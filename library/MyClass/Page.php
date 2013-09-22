<?php

/**********************
 *
 * Page 翻页类 用于Zend Framwork
 *
 ** 使用实例:
 * $p = new showPage;		//建立新对像
 * $p->file="ttt.php";		//设置文件名，默认为当前页
 * $p->pvar="pagecount";	//设置页面传递的参数，默认为p
 * $p->setvar(array("a" => '1', "b" => '2'));	//设置要传递的参数,要注意的是此函数必须要在 set 前使用，否则变量传不过去
 * $p->set(20,2000,1);		//设置相关参数，共三个，分别为'页面大小'、'总记录数'、'当前页(如果为空则自动读取GET变量)'
 * $p->output(0);			//输出,为0时直接输出,否则返回一个字符串
 * echo $p->limit();		//输出Limit子句。在sql语句中用法为 "SELECT * FROM TABLE LIMIT {$p->limit()}";
 *
 * *********************
 */

class MyClass_Page {
	protected $file; //路径 设置文件名，默认为当前页
	protected $pvar = 'page'; //设置页面传递的参数，默认为p
	protected $varstr = ''; //除page之外的
	

	protected $totalnum; //记录总数
	protected $totalpage; //总页数
	protected $curpage; //当前页码
	

	protected $offsetnum = 0; //记录偏移量,  用于 sql limit $offsetnum,$perpagenum
	protected $perpagenum = 30; //页码偏移量，这里可随意更改
	protected $disnum = 5; // 取单数显示，当前页停在中间 ，为没最终显示页面上的页数
	//protected $pagetype;                //显示样式
	protected $linkpage = ''; // 页面显示的 string 的内容，函数将返回这个
	

	public function __construct($param) {
		$this->file = $param ['file'];
		
		$this->totalnum = $param ['totalnum'];
		$this->perpagenum = $param ['perpagenum'];
		
		$this->curpage = isset ( $param ['curpage'] ) ? intval ( $param ['curpage'] ) : '1';
		
		$this->totalpage = ceil ( $this->totalnum / $this->perpagenum );
		$this->offsetnum = $this->perpagenum * ($this->curpage - 1);
		
		$this->disnum = $param ['disnum']; //当调用getNumPage()时需要此参数   
	}
	
	public function getCharPage() {
		if ($this->totalnum > $this->perpagenum) //当总记录数大于每页记录数时
{
			if ($this->curpage == 1 && $this->totalpage > 1) //当前页为第1页并且总页数大于1
{
				
				$this->linkpage = "<a>首页</a>|<a>上一页</a>|<a href=" . $this->file . "/page/" . ($this->curpage + 1) . " >下一页</a>|<a href=" . $this->file . "/page/" . $this->totalpage . " >尾页</a>";
			
			} elseif ($this->curpage > 1 && $this->curpage < $this->totalpage) { //当前页大于1并且当前页小于总页数
				

				$this->linkpage = "<a href=" . $this->file . "/page/1 >首页<a>|" . "<a href=" . $this->file . "/page/" . ($this->curpage - 1) . " >上一页</a>|" . "<a href=" . $this->file . "/page/" . ($this->curpage + 1) . " >下一页</a>|" . "<a href=" . $this->file . "/page/" . $this->totalpage . " >尾 页</a>";
			
			} elseif ($this->curpage == $this->totalpage && $this->totalpage > 1) {
				
				$this->linkpage = "<a href=" . $this->file . "/page/1 >首 页<a>|" . "<a href=" . $this->file . "/page/" . ($this->curpage - 1) . " >上一页</a>|<a>下一页</a>|<a>尾页</a>";
			}
		}
		return "<div id=\"pager\">" . $this->linkpage . "</div>";
	}
	
	public function getNumPage() {
		$url = '';
		$style = '
			<style type="text/css">
			.pagination {padding:3px; MARGIN: 3px;text-align:right;font-family:Geneva;}
			.pagination a {BORDER: #aaaadd 1px solid; PADDING:2px 5px; MARGIN: 2px; COLOR: #000099; TEXT-DECORATION: none}
			.pagination a:hover {BORDER: #000099 1px solid;  COLOR: #FF9900; }
			.pagination a:active {BORDER: #000099 1px solid;  COLOR: #000; }
			.pagination span.current {BORDER: #000099 1px solid; PADDING:2px 5px; FONT-WEIGHT: bold; MARGIN: 2px; COLOR: #fff; BACKGROUND-COLOR: #000099;text-decoration:underline}
			.pagination span.disabled {BORDER: #ccc 1px solid; PADDING:2px 5px; MARGIN: 2px;COLOR: #ccc;  }
			.pagination span.pagelist {BORDER: #aaaadd 1px solid; PADDING:2px 5px; MARGIN: 2px; COLOR: #000099;  }
			</style>';
		
		//总记录数大于每页记录数
		if ($this->totalnum > $this->perpagenum) {
			//要求显示的数字组页数大于总页数
			$from = $this->curpage - ( int ) ($this->disnum / 2);
			
			$to = $this->disnum + $from - 1;
			
			if ($to > $this->totalpage) {
				$to = $this->totalpage;
				$from = $this->totalpage - $this->disnum + 1;
				if ($from < 1)
					$from = 1;
			}
			
			if ($from < 1) {
				$from = 1;
				$to = $this->disnum;
				if ($to > $this->totalpage)
					$to = $this->totalpage;
			}
			
			for($i = $from; $i <= $to; $i ++) {
				if ($this->curpage == $i) {
					$url .= "<span class='current' title='当前页'>" . $i . "</span>";
				} else {
					$url .= "<a href=" . $this->file . "/page/" . $i . " >" . $i . "</a>";
				}
			}
		}
		
		$pagelist = "<span class='pagelist' title='总数'>" . $this->totalnum . "</span> <span class='pagelist' title='每页个数'>" . $this->perpagenum . "</span> <span class='pagelist' title='总页数'>" . $this->curpage . "/" . $this->totalpage . "</span>";
		$urlstart = "<a href=" . $this->file . "/page/1 title='首页'>&laquo;</a>" . "<a href=" . $this->file . "/page/" . ($this->curpage - 1) . " title='前一页'>&#139;</a>";
		
		$urlend = "<a href=" . $this->file . "/page/" . ($this->curpage + 1) . "  title='后一页'>&#155;</a> <a href=" . $this->file . "/page/" . ($this->totalpage) . "  title='尾页'>&raquo;</a>";
		
		$usrlstartblank = "<span class='disabled'>&laquo;</span> <span class='disabled'>&#139;</span>";
		
		$urlendblank = "<span class='disabled'>&#155;</span> <span class='disabled'>&raquo;</span>";
		
		$this->linkpage = $urlstart . $url . $urlend;
		
		//当前页为第1页并且总页数大于1
		if ($this->totalpage >1) {
			
			if ($this->curpage <= 1) {
				$urlstart = $usrlstartblank;
			}
			
			if (($this->curpage+1) >= $this->totalpage) {
				$urlend = $urlendblank;
			}
		} else {
			$urlstart = $usrlstartblank;
			$urlend = $urlendblank;
		}
		
		$this->linkpage = $style . "<div class=\"pagination\">" . $pagelist . $urlstart . $url . $urlend . "</div>";
		
		return $this->linkpage;
	}
	
	//获取总页数
	public function getTotalPage() {
		return $this->totalpage;
	}
	
	/**
	 * 要传递的变量设置
	 *
	 * @access public
	 * @param array $data   要传递的变量，用数组来表示，参见上面的例子
	 * @return void
	 */
	public function setvar($data) {
		foreach ( $data as $k => $v ) {
			$this->file .= '/' . $k . '/' . urlencode ( $v );
		}
	}
	/**
	 * 分页结果输出
	 *
	 * @access public
	 * @param bool $return 为真时返回一个字符串，否则直接输出，默认直接输出
	 * @return string
	 */
	public function output($return = false) {
		if ($return) {
			return $this->output;
		} else {
			echo $this->output;
		}
	}
	/**
	 * 生成Limit语句
	 *
	 * @access public
	 * @return string
	 */
	public function limit() {
		return $this->offsetnum . ',' . $this->perpagenum;
	}

}