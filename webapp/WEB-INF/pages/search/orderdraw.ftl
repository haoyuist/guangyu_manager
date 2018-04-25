<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">   
<title>逛鱼申请提现</title> 
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, minimal-ui">
<link rel="shortcut icon" href="/static/front/favicon.ico">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta content="yes" name="apple-touch-fullscreen">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link rel="stylesheet" href="/static/front/css/light7.css">
<link rel="stylesheet" href="/static/front/css/app.css">

</head>
<body style="position: static; width: 300px; height: 600px;">
	<div class="page">
		<div class="content">
			<form id="formdata">
				<div class="page-login" style="margin-top: 2rem">
					<div class="list-block inset text-center">
						<ul>
							<li>
								<div class="item-content">
								    <div class="item-media">
										<i class="icon icon-form-name"></i>
									</div>
									<div class="item-inner">
										<div class="item-input">
											<input id="mobile" maxlength="11" type="text" class="input_enter"
												placeholder="请输入手机号码(必填)" name="mobile">
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
								    <div class="item-media">
										<i class="icon icon-form-name"></i>
									</div>
									<div class="item-inner">
										<div class="item-input">
											<input id="alipay" maxlength="50" type="text" class="input_enter"
												placeholder="请输入支付宝账号(必填)" name="alipay">
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
									<div class="item-media">
										<i class="icon icon-form-email"></i>
									</div>
									<div class="item-inner" style="padding:0">
										<div class="item-input">
											<input id="vcode" maxlength="5" class="input_enter" type="text" placeholder="输入验证码(必填)"
												name="codeimage">
										</div>
										<div class="item-title label" style="width:100px;height:35px;">
											 <img id="num" height="35" src="/getCode?%27+(new%20Date()).getTime()" onclick="document.getElementById('num').src='/getCode?'+(new Date()).getTime()"  alt="换一换" title="换一换" class="codeimage">
										</div>
										
									</div>
								</div>
							</li>
							<li>
								<div class="item-content">
									<div class="item-media">
										<i class="icon icon-form-email"></i>
									</div>
									<div class="item-inner">
										<div class="item-input">
											<input id="smscode" class="input_enter" type="text" placeholder="输入短信验证码(必填)"
												name="smscode">																																				
										</div>
										<div id="send" class="item-title label" style="width: 3rem;">
											<a href="javascript:void(0);" id="send_btn"
												style="color: #a0a0a0; font-size: 0.8rem;" onclick="sendsmscode()">发送短信验证码</a>
										</div>
										<div id="timer" class="item-title label"
											style="width: 3rem; display: none; color: orangered; font-size: 0.8rem;"></div>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="content-block">
						<p>
							<a class="button button-big button-fill external"
								data-transition='fade' id="submitlogin" onclick="commit();">申请提现</a>
						</p>
						<p class='text-center signup'>
								<a href="searchorder.html" class='pull-left external'
								style="font-size: 0.8rem;">订单查询</a>
								<a href="/search.html"
								class='pull-right external' style="font-size: 0.8rem;">查返利</a>								
						</p>
					</div>
			</form>
		</div>

		<div id="result" align="center"><div style="color: red;"><br/>贴士：提现成功后请注意查收支付宝，我们的客户会在2小时内给您打款！</div></div>

	</div>

	<script type='text/javascript' src='/static/front/js/jquery.min.js' charset='utf-8'></script>
	<script type='text/javascript' src='/static/front/js/light7.js' charset='utf-8'></script>
	<script>	
	    function isPoneAvailable(mobile) {  
          var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;  
          if (!myreg.test(mobile)) {  
              return false;  
          } else {  
              return true;  
          }  
      }
	    
	    function commit(){
	      var mobile = $('#mobile').val();
	      var alipay = $('#alipay').val();
	      var vcode = $('#vcode').val();
	      var smscode = $('#smscode').val();	   
	      if(!mobile){
	        alert("请输入手机号！");
	        return;
	      }else{
	        if(mobile.toString().length!=11){
			  alert("手机号位数不正确！");
			  return;
			}
	        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/; 
	        if (!myreg.test(mobile)) {  
	          alert("请输入正确的手机号码");
              return;  
            } 	        
	      }
	      if(!alipay){
	        alert("请输入支付宝账号，用于收款！");
	        return;
	      }
	      if(!vcode){
	        alert("请输入验证码！");
	        return;
	      }else{
	        if(vcode.toString().length!=5){
			  alert("验证码输入不正确！");
			  return;
			}
	      }
	      if(!smscode){
	        alert("请输入短信验证码！");
	        return;
	      }else{
	        if(smscode.toString().length!=5){
			  alert("短信验证码输入不正确！");
			  return;
			}
	      }
	      
	      save(mobile,alipay,vcode,smscode);	      	      	      	      
	    }

		function save(mobile,alipay,vcode,smscode) {
				$
						.ajax({
							type : "post",
							url : "/api/orderdraw",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							data : JSON.stringify({
								"mobile" : ""+mobile,
								"alipay" : ""+alipay,
								"vcode" : ""+vcode,
								"smscode" : ""+smscode
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								if(JSON.stringify(data) != "{}"){
								  if(data.ret.result.status=="0"){
								    alert("提现申请成功,提现商品"+data.ret.result.productNums+"件,提现金额"+data.ret.result.money+"元,请注意支付宝查收！");
								    $("#mobile").val("");
								    $("#alipay").val("");
								    $("#vcode").val("");
								    $("#smscode").val("");
								    document.getElementById('num').src='/getCode?'+(new Date()).getTime();
								    $('#result').html("<br/><br/><font color='red'>提现申请成功,提现商品"+data.ret.result.productNums+"件,提现金额"+data.ret.result.money+"元,请注意支付宝查收！</font>");
								  }								  
								  if(data.ret.result.status=="5"){
								    alert("验证码验证失败!");
								    document.getElementById('num').src='/getCode?'+(new Date()).getTime();
								  }								  
								  if(data.ret.result.status=="6"){
								    alert("短信验证码已失效，请重新发送!");
								    $("#smscode").val("");
								  }
								  if(data.ret.result.status=="7"){
								    alert("短信验证码验证失败!");
								    $("#smscode").val("");
								  }								  
								}															
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
		}
		
		function sendsmscode() {
			var mobile = $('#mobile').val();
			var vcode = $('#vcode').val();
			if (!mobile) {
				alert("请输入手机号码！");
				return;
			}
			if (!vcode) {
				alert("请输入图形验证码！");
				return;
			}
				$
						.ajax({
							type : "post",
							url : "/api/getSmsCode",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							async:false,
							data : JSON.stringify({
								"mobile" : mobile,
								"vcode" : vcode
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data);
								if(data.ret.result.status=="3"){
								    alert("图形验证码不正确");
								    $("#vcode").val("");								    
								}
								if(data.ret.result.status=="4"){
								    alert("请等待60秒后再次发送短信验证码");							    
								}
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
		}
	</script>
</body>
</html>
