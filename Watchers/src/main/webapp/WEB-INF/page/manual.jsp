<%--
  User: jeongjuSong
  Date: 2018. 8. 12.
  Time: PM 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.watchers.common.session.manager.SessionLoginUtil" %>
<%@ page import="com.watchers.business.contact.model.BoardVo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    
      <style>

        .timeline {
  position: relative;
  padding: 0;
  list-style: none;
}

.timeline:before {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 40px;
  width: 2px;
  margin-left: -1.5px;
  content: '';
  background-color: #e9ecef;
}

.timeline > li {
  position: relative;
  min-height: 50px;
  margin-bottom: 50px;
}

.timeline > li:after, .timeline > li:before {
  display: table;
  content: ' ';
}

.timeline > li:after {
  clear: both;
}

.timeline > li .timeline-panel {
  position: relative;
  float: right;
  width: 100%;
  padding: 0 20px 0 100px;
  text-align: left;
}

.timeline > li .timeline-panel:before {
  right: auto;
  left: -15px;
  border-right-width: 15px;
  border-left-width: 0;
}

.timeline > li .timeline-panel:after {
  right: auto;
  left: -14px;
  border-right-width: 14px;
  border-left-width: 0;
}

.timeline > li .timeline-image {
  position: absolute;
  z-index: 100;
  left: 0;
  width: 80px;
  height: 80px;
  margin-left: 0;
  text-align: center;
  color: white;
  border: 7px solid #e9ecef;
  border-radius: 100%;
  background-color: #9c27b0;
  text-align: center;
}

.timeline > li .timeline-image h4 {
  font-size: 10px;
  line-height: 14px;
  margin-top: 12px;
}

.timeline > li.timeline-inverted > .timeline-panel {
  float: right;
  padding: 0 20px 0 100px;
  text-align: left;
}

.timeline > li.timeline-inverted > .timeline-panel:before {
  right: auto;
  left: -15px;
  border-right-width: 15px;
  border-left-width: 0;
}

.timeline > li.timeline-inverted > .timeline-panel:after {
  right: auto;
  left: -14px;
  border-right-width: 14px;
  border-left-width: 0;
}

.timeline > li:last-child {
  margin-bottom: 0;
}

.timeline .timeline-heading h4 {
  margin-top: 0;
  color: inherit;
}

.timeline .timeline-heading h4.subheading {
  text-transform: none;
}

.timeline .timeline-body > ul,
.timeline .timeline-body > p {
  margin-bottom: 0;
}

@media (min-width: 768px) {
  .timeline:before {
    left: 50%;
  }
  .timeline > li {
    min-height: 100px;
    margin-bottom: 100px;
  }
  .timeline > li .timeline-panel {
    float: left;
    width: 41%;
    padding: 0 20px 20px 30px;
    text-align: right;
  }
  .timeline > li .timeline-image {
    left: 50%;
    width: 100px;
    height: 100px;
    margin-left: -50px;
  }
  .timeline > li .timeline-image h4 {
    font-size: 13px;
    line-height: 50px;
    margin-top: 16px;
    text-align: center;
  }
    
    .timeline > li .timeline-image i {
    font-size:57px;
    margin-top:14px;
  }

    
  .timeline > li.timeline-inverted > .timeline-panel {
    float: right;
    padding: 0 30px 20px 20px;
    text-align: left;
  }
    </style>
    
    
    <script type="text/javascript">
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
                    <a href="${pageContext.request.contextPath}/Finder.watchers" class="nav-link">걸음걸이 유사도 검사</a>
                </li>
                <li class="dropdown nav-item">
                    <a href="#pablo" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="material-icons">build</i> 회원관리 </a>
                    <div class="dropdown-menu">
                        <h6 class="dropdown-header">[관리자] <%=SessionLoginUtil.getLoginUser().getUser_name()%> 님 환영합니다 :) </h6>
                        <a href="javascript:underconstructor()" class="dropdown-item">회원 가입승인</a>
                            <a href="javascript:underconstructor()" class="dropdown-item">회원 목록</a>
                            <div class="dropdown-divider"></div>
                            <a data-toggle="modal" data-target="#myModal" class="dropdown-item">로그아웃</a>
                    </div>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/FindReq.watchers" class="nav-link">걸음걸이 영상 관리</a>
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
                        <h2 class="title">Download / Manual</h2>
                        <p class="description" style="font-family: 나눔바른고딕;">서비스를 이용하기 위한 다운로드, 매뉴얼 페이지입니다.<br /></p>
                        <hr>
                    </div>
                </div>
                <div class="container" style="margin-top:50px;">
                    <div class="contact-wrap">
                        <div class="status alert alert-success" style="display: none"></div>
                        <div class="col-md-6 col-md-offset-3">

                            <ul class="timeline">
                                <li>
                                    <div class="timeline-image">
                                        <i class="material-icons" style="align-content: center;">desktop_windows</i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 style="font-weight: bold; font-family:나눔바른펜;">걸음걸이 영상을 촬영하시기 위해서는<br> <a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=44561" target="_blank">'Kinect for Windows SDK 2.0'</a>을<br>클릭하시기 바랍니다.</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p class="text-muted">자동으로 진행되오니 기다려주시기 바랍니다. <br>실행하신 후 SDK Browser v2.0을 실행시켜 주십시오. </p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-image">
                                        <i class="material-icons" style="align-content: center;">photo_camera</i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 style="font-weight: bold; font-family:나눔바른펜;">Kinect 카메라를 PC와 연결해주세요.</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p class="text-muted">'Kinect Configuration Verifier'에서 상태를 확인하십시오.<br>'Body Basics-WPF'를 실행시켜 주십시오.
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="timeline-image">
                                         <i class="material-icons" style="align-content: center;">directions_walk</i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 style="font-weight: bold; font-family:나눔바른펜;">영상을 녹화해 주십시오.</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p class="text-muted">
                                                뼈대가 잘 나오는지 확인하시기 바랍니다.
                                                <br>10초 이상으로 영상을 찍어주십시오.
                                            <br><a href="http://hong-fol.tistory.com/87" target="_blank" style="font-weight: bold;">이 곳</a>을 참고하시면 더욱 쉽게 녹화하실 수 있습니다.
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-image">
                                        <i class="material-icons" style="align-content: center;">file_upload</i>
                                    </div>
                                    <div class="timeline-panel">
                                        <div class="timeline-heading">
                                            <h4 style="font-weight: bold; font-family:나눔바른펜;">걸음걸이 데이터를 업로드하십시오.</h4>
                                        </div>
                                        <div class="timeline-body">
                                            <p class="text-muted">
                                                <a href="${pageContext.request.contextPath}/FileDown.action?file_name=MainWindow.xaml.cs" style="font-weight: bold;">C# 코드</a>를 클릭하셔서 <a href="https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=15" target="_blank" style="font-weight: bold;">Visual Studio</a>에서 실행하세요.
                                                <br>3차원 걸음걸이 좌표를 csv파일로 출력할 수 있습니다.
                                            <br>출력된 파일을 <a href="${pageContext.request.contextPath}/<%=SessionLoginUtil.getLoginUser() == null ? "Login.watchers" : "FindReq.watchers"%>" style="font-weight: bold;">유사도 검사</a>페이지에 업로드 해주십시오.
                                            </p>
                                        </div>
                                    </div>
                                </li>
                                <li class="timeline-inverted">
                                    <div class="timeline-image">
                                        <i class="material-icons" style="align-content: center;">done</i>
                                    </div>
                                </li>
                            </ul>

                            <br />

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
                    <h5 class="modal-title">정말 회원탈퇴 하시겠습니까?</h5>
                </div>
                <div class="modal-footer">
                    <form action="/deleteuser" method="post">
                   <button type="submit" class="btn btn-danger btn-link">회원탈퇴</button>
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