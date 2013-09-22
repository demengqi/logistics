<script type="text/javascript" >
function checkLoginForm(){
	var password=document.getElementById('password').value;
	if(''== password){
		alert('需要输入密码');
		document.getElementById("password").focus();
		return false;
	}
	return true;
}
</script>
<style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }
 
      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin select,
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }
 
    </style>
<div class="container">
 
      <form class="form-signin" id="login_form" action="/login/op" method="post" onsubmit="return checkLoginForm();">
        <h2 class="form-signin-heading"><*$setting.company*></h2>
                <select name="account"  id="account_input"  class="input-block-level" >
        <*foreach from=$workidlist item=item key=key*>
        <option value="<*$item*>" selected="selected"><*$item*></option>
        <*/foreach*>
        </select>
        <input type="password" class="input-block-level"  name="password"  id="password" placeholder="输入密码">
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> 记住密码
        </label>
        <button class="btn btn-large btn-primary" type="submit">登录</button>
      </form>
 
    </div>


	<script>
		
	window.onload = function() {
	  document.getElementById("password").focus();
	}
	</script>
