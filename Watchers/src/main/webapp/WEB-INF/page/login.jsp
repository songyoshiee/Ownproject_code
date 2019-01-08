<%--
  Created by IntelliJ IDEA.
  User: jeongjusong
  Date: 2018. 6. 7.
  Time: PM 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.watchers.common.constant.FrameworkConst" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/footprint.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>
        WATCHERS
    </title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <!-- CSS Files -->
    <link href="${pageContext.request.contextPath}/css/material-kit.css" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="${pageContext.request.contextPath}/demo/demo.css" rel="stylesheet" />

	<!--   Core JS Files   -->
	<script src="${pageContext.request.contextPath}/js/core/jquery.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/plugins/moment.min.js"></script>
	<!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
	<script src="${pageContext.request.contextPath}/js/plugins/bootstrap-datetimepicker.js" type="text/javascript"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="${pageContext.request.contextPath}/js/plugins/nouislider.min.js" type="text/javascript"></script>
	<!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
	<script src="${pageContext.request.contextPath}/js/material-kit.js?v=2.0.3" type="text/javascript"></script>

    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#user_id').focus();	
    	})
    	
        function loginProc(){
        	
        	var params = {
        		user_id	: $('#user_id').val()
        	,	user_pw : $('#user_pw').val()
        	};
        	
        	$.ajax({
				type:"POST",
				url: "${pageContext.request.contextPath}/Login.action", 
				cache: false, 
				async:true,
				data:params,
				dataType:"json",
				success:function(response){
					if(typeof(response.<%=FrameworkConst.RESULT_CODE%>) != 'undefined') {
						alert(response.<%=FrameworkConst.RESULT_MSG%>);
					} else {
						alert(response.user_name + ' 님 반갑습니다 !');
						window.location.href = '${pageContext.request.contextPath}/';
					}
				},
				error:function(jqXHR, status) {
					alert(jqXHR.<%=FrameworkConst.RESULT_MSG%>);
				}
			});	
        }
    	
    	function underconstructor(){
	    	alert("서비스 준비중입니다.");	
	    }
    </script>

</head>

<body class="signup-page sidebar-collapse">
<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionNav">
    <div class="container">
        <div class="navbar-translate">
            <h3 style="font-family: VERDANA; font-weight:bold; letter-spacing:1.3px;"><span style="color:#9c27b0;">W</span>ATCHERS</h3>
            <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
                <span class="navbar-toggler-icon"></span>
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">홈</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="section section-signup page-header" style="background-image: url('${pageContext.request.contextPath}/img/bg.jpg'); margin-top:-90px;">
    <div class="container">
        <div class="row">
            <div class="col-md-4 ml-auto mr-auto">
                <div class="card card-signup">
                    <form class="login" method="post" action="" id="form-login" onsubmit="return false;">
                        <div class="card-header card-header-primary text-center">
                            <h2 class="card-title text-center">Login</h2>
                        </div>
                        <div class="card-body">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                        <span class="input-group-text">
                            <i class="material-icons">account_circle</i>
                          </span>
                                </div>
                                <input type="text" class="form-control" name="user_id" id="user_id" placeholder="아이디">
                            </div>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                        <span class="input-group-text">
                            <i class="material-icons">lock_outline</i>
                          </span>
                                </div>
                                <input type="password" placeholder="비밀번호" class="form-control" name="user_pw" id="user_pw" />
                            </div>

                        </div>
                        <div class="card-footer" style="margin-left:-10px;">
                            <a href="${pageContext.request.contextPath}/Register.watchers" class="btn btn-link btn-primary btn-lg">회원가입</a>
                            <a data-toggle="modal" data-target="#find_id" class="btn btn-link btn-primary btn-lg">아이디 / 비밀번호 찾기</a>
                        </div>
                        <div class="text-center" style="margin-top:-15px;">
                            <input type="submit" id="btn-login" value="로그인하기" class="btn btn-primary btn-round" onClick="javascript:loginProc(); return false;">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!--아이디 찾기-->
<div class="modal fade" id="find_id" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="padding:20px;">
            <div style="border: 1.5px solid #9c27b0; border-radius:10px;">
                <div class="modal-header">
                    <h5 class="modal-title">아이디 찾기</h5>
                    <h6 style="margin-top:15px;">- 사용자 이름으로 찾기</h6>
                </div>
                <form action="/find_id" method="post" class="find_id" style="margin-top:30px;">
                    <div class="input-group">
                        <div class="input-group-prepend">
                                <span class="input-group-text">
                            <i class="material-icons">face</i>
                          </span>
                        </div>
                        <input type="text" name="user_name" placeholder="사용자 이름" style="border-bottom: 1px solid #9c27b0; border-left: 0px; border-top: 0px; border-right: 0px; width:350px;">
                    </div>
                    <div style="text-align:center;">
<!--                         <input type="submit" value="아이디 찾기" class="btn btn-primary btn-round" href="/find_id" style="margin-top:32px;"> -->
							<a href="javascript:underconstructor()" class="btn btn-primary btn-round" style="margin-top:32px;">아이디 찾기</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--비밀번호 찾기-->
<div class="modal fade" id="find_pw" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="padding:20px;">
            <div style="border: 1.5px solid #9c27b0; border-radius:10px;">
                <div class="modal-header">
                    <h5 class="modal-title">비밀번호 찾기</h5>
                    <h6 style="margin-top:15px;">- 인증번호로 찾기</h6>
                </div>
                <form action="/find_id" method="post" class="find_id" style="margin-top:30px;">
                    <div class="input-group">
                        <div class="input-group-prepend">
                                <span class="input-group-text">
                            <i class="material-icons">account_circle</i>
                          </span>
                        </div>
                        <input type="text" name="user_name" placeholder="사용자 아이디" style="border-bottom: 1px solid #9c27b0; border-left: 0px; border-top: 0px; border-right: 0px; width:350px;">
                    </div>
                    <div class="input-group" style="margin-top:20px;">
                        <div class="input-group-prepend">
                                <span class="input-group-text">
                            <i class="material-icons">mail</i>
                          </span>
                        </div>
                        <input type="text" name="mail" id="mail" placeholder="가입한 이메일" style="border-bottom: 1px solid #9c27b0; border-left: 0px; border-top: 0px; border-right: 0px;">
                        <a href="/sendmail" style="margin-left:20px;"> 인증번호 보내기 </a>
                    </div>
                    <div class="input-group" style="margin-top:20px;">
                        <div class="input-group-prepend">
                                <span class="input-group-text">
                            <i class="material-icons">check</i>
                          </span>
                        </div>
                        <input type="text" name="user_name" id="user_name" placeholder="인증번호 입력" style="border-bottom: 1px solid #9c27b0; border-left: 0px; border-top: 0px; border-right: 0px; width:350px;">
                    </div>
                    <div style="text-align:center;">
                        <input type="submit" value="비밀번호 찾기" class="btn btn-primary btn-round" href="/find_pw" style="margin-top:32px;">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>

</html>

