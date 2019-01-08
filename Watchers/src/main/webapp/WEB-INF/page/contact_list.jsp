<%--
  User: jeongjuSong
  Date: 2018. 7. 29.
  Time: AM 4:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.watchers.common.session.manager.SessionLoginUtil" %>
<%@ page import="com.watchers.business.contact.model.BoardVo" %>
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
    
    <%
    	JSONArray list = (JSONArray)request.getAttribute("ContactList");
    %>
    <script type="text/javascript">
    	function goContactRead(idx){
    		$('#contactForm').find('input[name="idx"]').val(idx);
    		$('#contactForm').attr('action', '${pageContext.request.contextPath}/ContactRead.watchers');
    		$('#contactForm').attr('method', 'post');
    		$('#contactForm').submit();
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
                    <a href="${pageContext.request.contextPath}/about" class="nav-link">다운로드 / 메뉴얼</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/Login.watchers" class="nav-link">로그인</a>
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


<div class="page-header header-filter clear-filter" data-parallax="true" style="background-image: url('${pageContext.request.contextPath}/img/bg.jpg');">
</div>
<div class="main main-raised">
        <div class="container">
            <div class="section text-center">
                <div class="row">
                    <div class="col-md-8 ml-auto mr-auto">
                        <h2 class="title">Contact List</h2>
                        <p class="description" style="font-family: 나눔바른고딕;">서비스에 대해 문의할 점이 있으시면 '문의글 작성하기'를 통해 남겨주세요.<br/></p>
                    </div>
                </div>
                <div class="container" style="margin-top:50px;">
                    <div class="contact-wrap">
                        <div class="status alert alert-success" style="display: none"></div>
                        <div class="col-md-6 col-md-offset-3">
                            <div id="sendmessage">감사합니다!</div>
                            <div id="errormessage"></div>
                            <form id="contactForm" name="sentMessage" novalidate>
								<input type="hidden" name="idx" value="" />
                                <table style='text-align: center' class="table table-striped">
                                    <tr>
                                        <th>번호</th>
                                        <th>작성자</th>
                                        <th>제목</th>
                                        <th>작성일</th>
                                        <th>변경일</th>
                                    </tr>
                                    <%
								    for(int i=0; i<list.size(); i++)
								    {
								
								        JSONObject row = list.getJSONObject(i);
								    %>
                                    <tr>
                                        <td>
                                            <%=row.get("idx")%>
                                        </td>
                                        <td>
                                            <%=row.get("id")%>
                                        </td>
                                        <td>
                                            <a href="#" onclick="javascript:goContactRead('<%=row.get("idx")%>'); return false;">
                                                <%=row.get("title")%>
                                            </a>
                                        </td>
                                        <td>
                                            <%=row.get("first_date")%>
                                        </td>
                                        <td>
                                            <%=row.get("renewal_date")%>
                                        </td>
                                    </tr>
                                    <%
								    }
								    %>
                                </table>
                                <br/>
                               	<a class="btn btn-primary btn-round" style="margin-top:20px;" href="${pageContext.request.contextPath}/ContactWrite.watchers">
				                	<i class="material-icons">create</i> &nbsp;문의글 작성하기
				              	</a>
                                <!--<a href="/board/write">글쓰기로 이동</a>-->
                            </form>
                        </div>
                    </div>
                    <!--/.row-->
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

</body>

</html>