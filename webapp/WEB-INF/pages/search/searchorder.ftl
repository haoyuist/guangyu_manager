<link rel="stylesheet" href="/static/front/css/table.css">
<@model.webheadsearch />
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
												placeholder="请输入您的手机号码" name="mobile">
										</div>
									</div>
								</div>
							</li>
							<!-- 暂时屏蔽掉
							<li>
								<div class="item-content">
									<div class="item-media">
										<i class="icon icon-form-email"></i>
									</div>
									<div class="item-inner" style="padding:0">
										<div class="item-input">
											<input id="vcode" maxlength="5" class="input_enter" type="text" placeholder="输入验证码"
												name="codeimage">
										</div>
										<div class="item-title label" style="width:100px;height:35px;">
											 <img id="num" height="35" src="/getCode?%27+(new%20Date()).getTime()" onclick="document.getElementById('num').src='/getCode?'+(new Date()).getTime()"  alt="换一换" title="换一换" class="codeimage">
										</div>										
									</div>
								</div>
							</li>
							-->
						</ul>
					</div>
					<div class="content-block">
						<p>
							<a class="button button-big button-fill external"
								data-transition='fade' id="submitlogin" onclick="commit();">订单查询</a>
						</p>
						<p class='text-center signup'>
						        <p id="candraw"><a href="/helpdraw.html"
								class='pull-left external' style="font-size: 0.8rem;">提现帮助</a></p>						        					
								<a href="/search.html"
								class='pull-right external' style="font-size: 0.8rem;">继续搜返利</a>								
						</p>
					</div>
			</form>
		</div>

		<div id="result" align="center">
		  <div style="color: red;font-size: 0.7rem;">
		    <br/>FAQ:<br/>
		    <br/>问："我确认收货了，提交订单后，可以马上提现吗？" <br/>答："不能，需要订单核对完成。"<br/>
		    <br/>问："周期需要多久？" <br/>答："只要是确认收货了，一般一天左右。"<br/>
		    <br/>问："能查哪些订单？" <br/>答："能查已核对完成的订单。"<br/>
		    <!--<br/>问："平台收取费用吗？" <br/>答："收，淘宝平台对每单成交收取20%技术服务费。"<br/>-->
		  </div>
		</div>

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
	      var vcode = $('#vcode').val();
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
	      
	      //暂时屏蔽掉
	      //if(!vcode){
	      //  alert("请输入验证码！");
	      //  return;
	      //}else{
	      //  if(vcode.toString().length!=5){
		  //	  alert("验证码输入不正确！");
		  //	  return;
		  //	}
	      //}
	      
	      save(mobile,vcode);	      	      	      	      
	    }

		function save(mobile,vcode) {
				$
						.ajax({
							type : "post",
							url : "/api/searchorder",
							contentType : "application/json",
							dataType : "json",// 返回json格式的数据
							data : JSON.stringify({
								"mobile" : ""+mobile,
								"vcode" : ""+vcode
							}),
							timeout : 30000,
							success : function(data) {
								console.log('请求到的数据为：', data)
								if(JSON.stringify(data) != "{}"){								  		  
								  if(data.ret.result.status=="3"){
								    alert("验证码错误");
								    //暂时屏蔽掉
								    //$("#vcode").val("");								    
								  }
								  if(data.ret.result.status=="0"){
								    $('#result').html(data.ret.result.msg);
								    if(data.ret.result.canDraw=="1"){
								      $('#candraw').html("<a href='orderdraw.html' class='pull-left external' style='font-size: 0.8rem;'>我要申请提现</a>");
								    }else{
								      $("#candraw").html("");
								      $('#candraw').html("<a href='/helpdraw.html' class='pull-left external' style='font-size: 0.8rem;'>提现帮助</a>");
								    }
								    //暂时屏蔽掉
								    //$("#vcode").val("");
								  }
								}
								//暂时屏蔽掉
								//document.getElementById('num').src='/getCode?'+(new Date()).getTime();							
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								console.log('请求失败')
							}
						});
		}
	</script>
<@model.webendsearch />
