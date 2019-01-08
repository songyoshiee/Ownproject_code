<%--
  User: jeongjuSong
  Date: 2018. 10. 05.
  Time: PM 9:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.watchers.common.session.manager.SessionLoginUtil" %>
<%@ page import="com.watchers.common.constant.FrameworkConst" %>
<%@ page import="com.watchers.business.finder.model.FinderVo" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
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
	<script src="${pageContext.request.contextPath}/js/material-kit.js" type="text/javascript"></script>
	
     <style>
     
     
        .user-row {
            margin-bottom: 14px;
        }

        .user-row:last-child {
            margin-bottom: 0;
        }

        .dropdown-user {
            margin: 13px 0;
            padding: 5px;
            height: 100%;
        }

        .dropdown-user:hover {
            cursor: pointer;
        }

        .table-user-information>tbody>tr {
            border-top: 1px solid rgb(221, 221, 221);
        }

        .table-user-information>tbody>tr:first-child {
            border-top: 0;
        }


        .table-user-information>tbody>tr>td {
            border-top: 0;
        }

        .toppad {
            margin-top: 20px;
        }

    </style>
    <%
    	JSONArray list = (JSONArray)request.getAttribute("FinderList");
    	JSONArray missing_list = (JSONArray)request.getAttribute("MissingsList");
    %>
    <script>
        $(document).ready(function() {
            var panels = $('.user-infos');
            var panelsButton = $('.dropdown-user');
            panels.hide();

            //Click dropdown
            panelsButton.click(function() {
                //get data-for attribute
                var dataFor = $(this).attr('data-for');
                var idFor = $(dataFor);

                //current button
                var currentButton = $(this);
                idFor.slideToggle(400, function() {
                    //Completed slidetoggle
                    if (idFor.is(':visible')) {
                        currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
                    } else {
                        currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
                    }
                })
            });


            $('[data-toggle="tooltip"]').tooltip();

        
			$(document).on('change', ':file', function() {
				$(this).parent().parent().parent().prev().val($(this).val().replace(/\\/g, '/').replace(/.*\//, ''));
			});
			
        });
        
        function onWriteSubmit(){
		    var data;
		
		    data = new FormData();
		    data.append('file', $('#file')[0].files[0]);
		    
		
		    $.ajax({
			  url: '${pageContext.request.contextPath}/FileUpload.action',
			  data: data,
			  processData: false,
			  contentType: false,
			  type: 'POST',
			  success: function(response){
			    if(response.<%=FrameworkConst.RESULT_CODE%> != "<%=FrameworkConst.RESULT_SUCCESS%>") {
						alert(response.<%=FrameworkConst.RESULT_MSG%>);
					} else {
						alert('처리결과가 반영되었습니다.');
						window.location.href = '${pageContext.request.contextPath}/FindReq.watchers';
					}
				},
				error:function(jqXHR, status) {
					alert(jqXHR.<%=FrameworkConst.RESULT_MSG%>);
				}
			});
// 		    $.ajax({
// 		        url: '${pageContext.request.contextPath}/FileUpload.action',
// 		        data: data,
// 		        processData: false,
// 		        type: 'POST',
		
// 		        // This will override the content type header, 
// 		        // regardless of whether content is actually sent.
// 		        // Defaults to 'application/x-www-form-urlencoded'
// 		        contentType: 'multipart/form-data', 
		
// 		        //Before 1.5.1 you had to do this:
// 		        beforeSend: function (x) {
// 		            if (x && x.overrideMimeType) {
// 		                x.overrideMimeType("multipart/form-data");
// 		            }
// 		        },
// 		        // Now you should be able to do this:
// 		        mimeType: 'multipart/form-data',    //Property added in 1.5.1
		
// 		        success: function (data) {
// 		            alert(data);
// 		        }
// 		    });
        }

	    function underconstructor(){
	    	alert("서비스 준비중입니다.");	
	    }
    </script>
    
</head>

<body class="index-page sidebar-collapse">
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
            
            	<% if(SessionLoginUtil.getLoginUser() == null) { %>
            	<li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">홈</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/About.watchers" class="nav-link">다운로드 / 메뉴얼</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Login.watchers" class="nav-link">로그인</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Register.watchers" class="nav-link">회원가입</a>
                </li>
            	<% } else if(SessionLoginUtil.getLoginUser() != null) { %>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">홈</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/About.watchers" class="nav-link">다운로드 / 메뉴얼</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Contact.watchers" class="nav-link">문의게시판</a>
                </li>
                <% if(SessionLoginUtil.getLoginUser().getUser_type().equals("M")) { %>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Finder.watchers" class="nav-link">걸음걸이 영상 관리</a>
                </li>
                <li class="dropdown nav-item">
                    <a href="#pablo" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="material-icons">build</i> 회원관리 </a>
                    <div class="dropdown-menu">
                        <h6 class="dropdown-header">[관리자] <%=SessionLoginUtil.getLoginUser().getUser_name()%> 님 환영합니다 :) </h6>
                            <a href="javascript:underconstructor()" class="dropdown-item">회원 목록</a>
                            <div class="dropdown-divider"></div>
                            <a data-toggle="modal" data-target="#myModal" class="dropdown-item">로그아웃</a>
                    </div>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/FindReq.watchers" class="nav-link">걸음걸이 유사도 검사</a>
                </li>
               	<li class="dropdown nav-item">
                    <a href="#pablo" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="material-icons">face</i> User </a>
                    <div class="dropdown-menu">
                        <h6 class="dropdown-header"><%=SessionLoginUtil.getLoginUser().getUser_name()%> 님
                           	환영합니다 :)</h6>
                        <a href="javascript:underconstructor()" class="dropdown-item">회원정보 조회</a>
                            <a href="javascript:underconstructor()" class="dropdown-item">회원 탈퇴</a>
                            <div class="dropdown-divider"></div>
                            <a href="javascript:underconstructor()" class="dropdown-item">개인 게시글 관리</a>
                            <div class="dropdown-divider"></div>
                            <a data-toggle="modal" data-target="#myModal" class="dropdown-item">로그아웃</a>
                    </div>
                </li>
                <% } %>
                <% } %>
            </ul>
        </div>
    </div>
</nav>


<div class="page-header header-filter clear-filter" data-parallax="true" style="background-image: url('${pageContext.request.contextPath}/img/city-profile.jpg');">
</div>
  <div class="main main-raised">
        <div class="container">
            <div class="section text-center">
                <div class="row">
                    <div class="col-md-8 ml-auto mr-auto">
                        <h2 class="title">걸음걸이 유사도 검사</h2>
                        <p class="description" style="font-family: 나눔바른고딕;">녹화하신 걸음걸이의 csv파일을 업로드 해주세요.<br/></p>
                    </div>
                </div>
                
                <a data-original-title="회원 삭제" data-toggle="modal" type="button" data-target="#deleteuser" class="btn btn-primary" style="color:#fff; float:left; margin-top:30px; margin-left:35px; margin-bottom:30px;"><i class="material-icons">file_upload</i> 파일 업로드하기</a>
                
                <br/>
                <div class="container" style="margin-top:50px;">
                    <div class="contact-wrap">
                    
                      
                        <div class="col-md-6 col-md-offset-3">
                            <form id="contactForm" name="sentMessage" novalidate>

                                <table class="table table-user-information">
                                <div class="card-columns"></div>
                                    <tbody>
										<%
			                               for(int i=0; i<list.size(); i++)
			                               {
			                           
			                                   JSONObject user = list.getJSONObject(i);
			                               %>
                                        <tr>
                                           <div class="card-deck" style="width: -webkit-fill-available;">
                                              <div class="card">
			                                      <div class="card-body text-left">
			                                        <h4 class="card-title" style="font-family: 나눔바른펜;"><span class="badge badge-<%=user.getString("status").replace("N", "warning").replace("Y", "success")%> mb-5"><%=user.getString("status").replace("N", "미처리").replace("Y", "처리완료")%></span>  <%=user.get("name")%>@<%=user.get("id")%></h4>
			                                        <p class="card-text">전화번호 : <%=user.get("phone")%></p>
			                                        <p class="card-text">이메일 : <%=user.get("email")%></p>
			                                        <p class="card-text mb-5"><h5><%=user.get("renewal_date")%></h5></p>
			                                        </div>
			                                    </div>
			                                    <% for(int j=0; j < missing_list.size(); j++){
			                                    	JSONObject missings = missing_list.getJSONObject(i);
			                                    	if(user.getString("status").equals("Y") && missings.getString("idx").equals(user.getString("idx"))){
	                                    		%>
			                                    <div class="card">
			                                      <div class="card-body text-left">
			                                        <h4 class="card-title" style="font-family: 나눔바른펜;">걸음걸이 검사 결과</h4>
			                                       <p class="card-text">이름 : <%=missings.get("name")%></p>
														    <p class="card-text">성별 : <%=missings.get("sex")%></p>
														    <p class="card-text">실종 당시 나이 : <%=missings.get("occr_age")%></p>
														    <p class="card-text">현재 나이 : <%=missings.get("current_age")%></p>
														    <p class="card-text">실종 날짜 : <%=missings.get("occr_date")%></p>
														    <p class="card-text">실종 지역 : <%=missings.get("occr_address")%></p> 
			                                       </div>
			                                    </div>
			                                    <%
			                                    	}
			                               		}
												%>
			                                 </div>
                                        </tr>
                                        <%
		                               }
		                               %>
                                    </tbody>
                                </table>
                                
                                
                                <br />
                            </form>
                        </div>
                    </div>
                    <!--/.row-->
                </div>

            </div>
        </div>
    </div>
    
    <div class="modal fade" id="deleteuser" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">걸음걸이 영상을 업로드 해주세요.</h5>
                </div>
                <div class="modal-footer">
                    <form method="post" onsubmit="return false;">
						<div class="file_upload" style="margin-top:20px; margin-bottom:30px;">
									            <div class="input-group">
									                <input type="text" class="form-control mt-1 pl-5"  style="margin-left:-300px;" readonly>
									                <div class="input-group-append">
										                <label class="input-group-btn pl-0">
										                    <span class="btn btn-primary mt-0">
										                        	찾아보기&hellip; <input type="file" id="file" style="display: none;">
										                    </span>
										                </label>
									                </div>
									            </div>
									        </div>
						<button type="submit" class="btn btn-primary btn-round" onclick="onWriteSubmit();">확인</button>
                        <button type="button" class="btn btn-link" data-dismiss="modal">취소</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">정말 로그아웃 하시겠습니까?</h5>
            </div>
            <div class="modal-footer">
                <a class="btn btn-link" href="${pageContext.request.contextPath}/Logout.watchers">Logout</a>
                <button type="button" class="btn btn-danger btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!--  End Modal -->
<footer class="footer" data-background-color="black">
    <div class="container">
        <nav class="float-left">
            <ul>
                <li>
                    <a href="/developers">
                        About Us
                    </a>
                </li>
                <li>
                    <a href="https://www.gachon.ac.kr">
                        Gachon Univ.
                    </a>
                </li>
            </ul>
        </nav>
        <div class="copyright float-right">
            &copy;
            <script>
                document.write(new Date().getFullYear())
            </script>, made by
            <a href="/developers" target="_blank">WATCHERS</a> in gachon Univ.
        </div>
    </div>
</footer>
</body>

</html>