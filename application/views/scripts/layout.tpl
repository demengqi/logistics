<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><*$setting.company*></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta content="<*$setting.company*>  Inc." name="Copyright" />
	    <meta name="robots" content="index,follow">

		<link rel="stylesheet" href="/css/bootstrap.min.css"  rel="stylesheet">
		<link rel="stylesheet" href="/css/bootstrap-responsive.min.css"  rel="stylesheet">
        <link rel="stylesheet" href="/css/normalize.css">
        <link rel="stylesheet" href="/css/main.css">
        <link rel="stylesheet" href="/css/custom.css">
        <script src="/js/vendor/jquery-1.9.1.min.js"></script>
        <script src="/js/vendor/modernizr-2.6.2.min.js"></script>
        <script src="/js/jquery.mb.browser.min.js"></script>

    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="/favicon.png">


    </head>
    <body data-spy="scroll" data-target=".bs-docs-sidebar">
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->


<*if $isNoHead<>1*>
  <*include file="common/header.tpl"*>
<*/if*>

  <*$this->layout()->content*>

<*if $isNoHead<>1*>
    <*include file="common/bottom.tpl"*>
<*/if*>

        <script src="/js/bootstrap.js"></script>
		<script src="/js/plugins.js"></script>
        <script src="/js/main.js"></script>
	<script src="/js/jquery.unveil.min.js"></script>
  <script src="/js/jquery.scrollUp.min.js"></script>
    <script>
      $(document).ready(function(){
        $("img.lazy").unveil();
        
             $("#start-intro").click(function(){
                bootstro.start();    
            });

             $.scrollUp({
                  scrollName: 'scrollUp', // Element ID
                  topDistance: '300', // Distance from top before showing element (px)
                  topSpeed: 300, // Speed back to top (ms)
                  animation: 'fade', // Fade, slide, none
                  animationInSpeed: 200, // Animation in speed (ms)
                  animationOutSpeed: 200, // Animation out speed (ms)
                  scrollText: '', // Text for element
                  activeOverlay: false  // Set CSS color to display scrollUp active point, e.g '#00FFFF'
            });
          });
    </script>

    <script src="/js/holder.js"></script>
    <script src="/js/application.js"></script> 
   </body>
</html>