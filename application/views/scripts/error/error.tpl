<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<TITLE><*$message*></TITLE>
<STYLE type=text/css>
body,div,img,dl,dt,dd,ul,li,h1,h2,h3,h4,h5,h6,form,fieldset,input,textarea,p,th,td,table{ margin:0; padding:0; border:0;}
h1,h2,h3,h4,h5,h6{ font-size:14px;}
TABLE {BORDER-COLLAPSE: collapse; border-spacing: 0}
ADDRESS {FONT-WEIGHT: normal; FONT-STYLE: normal}
CAPTION {FONT-WEIGHT: normal; FONT-STYLE: normal}
CITE {FONT-WEIGHT: normal; FONT-STYLE: normal}
CODE {FONT-WEIGHT: normal; FONT-STYLE: normal}
DFN {FONT-WEIGHT: normal; FONT-STYLE: normal}
EM {FONT-WEIGHT: normal; FONT-STYLE: normal}
TH {FONT-WEIGHT: normal; FONT-STYLE: normal}
VAR {FONT-WEIGHT: normal; FONT-STYLE: normal}
UL {LIST-STYLE-TYPE: none}
CAPTION {TEXT-ALIGN: left}
TH {TEXT-ALIGN: left}
Q:unknown {content: ''}
Q:unknown {content: ''}
abbr {BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px}
ACRONYM {BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px}
BODY {PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 12px; BACKGROUND: #e7e7e7; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; FONT-FAMILY: Arial, Helvetica, sans-serif}
A {COLOR: #666}
A:hover {COLOR: #111}
#bg {MARGIN-TOP: 100px; BACKGROUND: #d8d8d8; BORDER-BOTTOM: #f1f1f1 8px solid; HEIGHT: 100px}
#main {MARGIN: -180px auto 0px; WIDTH: 650px; COLOR: #666}
#main EM {LINE-HEIGHT: 25px}
#content {BORDER-RIGHT: #c0c0c0 1px solid; PADDING-RIGHT: 20px; BORDER-TOP: #c0c0c0 1px solid; PADDING-LEFT: 20px; BACKGROUND: #fff; PADDING-BOTTOM: 20px; BORDER-LEFT: #c0c0c0 1px solid; COLOR: #333; LINE-HEIGHT: 18px; PADDING-TOP: 20px; BORDER-BOTTOM: #c0c0c0 1px solid}
#main H1 {FONT-SIZE: 14px; MARGIN-BOTTOM: 10px; COLOR: #e21a0a}
#content P {PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px}
#content DL {BORDER-TOP: #efefef 1px solid; MARGIN: 10px 0px}
#content DL DT {PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-WEIGHT: bold; FONT-SIZE: 14px; PADDING-BOTTOM: 5px; COLOR: #1389c4; PADDING-TOP: 10px}
#content DL DD {PADDING-BOTTOM: 10px; COLOR: #555; BORDER-BOTTOM: #efefef 1px solid}
</STYLE>
</HEAD>
<BODY>
<DIV id=bg></DIV>
<DIV id=main>
  <DIV id=content>
    <H1><*$message*></H1>

	<*if $development=='development'*>
    <DL>
      <DT>Exception information:</DT>
      <DD> <*$exception*> </DD>
      <DT>Stack trace:</DT>
      <DD>
        <pre><*$trace*></pre>
      </DD>
      <DT>Request Parameters:</DT>
      <DD>
        <pre> <*$request*></pre>
      </DD>
    </DL>
	<*else*>
    <P>谢谢您选择与信任！ <BR>
      顺祝商祺！<BR>
    </P>
	<*/if*>
  </DIV>
</DIV>
</BODY>
</HTML>