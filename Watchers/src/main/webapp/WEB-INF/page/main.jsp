<%--
  Created by IntelliJ IDEA.
  User: moonhyunji
  Date: 2018. 6. 7.
  Time: PM 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.watchers.common.session.manager.SessionLoginUtil" %>
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
        .wrap {
            margin-left: -89px;
            text-align: center;
            margin-left: auto;
            margin-top: 27px;
        }

        #features {
            font-size: 40px;
            margin-top: 70px;
            margin-bottom: 30px;
            color: #fff;
            padding: 50px;
            background: #9c27b0;
            border-radius: 50%;
        }

        #features2 {
            font-size: 40px;
            margin-top: 70px;
            margin-bottom: 30px;
            color: #fff;
            padding: 50px;
            background: #9c27b0;
            border-radius: 50%;
        }

        #features3 {
            font-size: 40px;
            margin-top: 70px;
            margin-bottom: 30px;
            color: #fff;
            padding: 50px;
            background: #9c27b0;
            border-radius: 50%;
        }

        #features4 {
            font-size: 40px;
            margin-top: 70px;
            margin-bottom: 30px;
            color: #fff;
            padding: 50px;
            background: #9c27b0;
            border-radius: 50%;
        }

        h4 {
            font-family: 배달의민족 도현;
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


<div class="page-header header-filter clear-filter" data-parallax="true" style="background-image: url('${pageContext.request.contextPath}/img/bg2.jpg');">
    <div class="container">
        <div class="row slide-margin">
            <div class="col-sm-6">
                <div class="carousel-content">
                    <h1 class="animation animated-item-1" style="font-family:'배달의민족 도현'; letter-spacing:1px; margin-top:60px;">걸음걸이로 실종자찾기</span>
                    </h1>
                    <p class="animation animated-item-2" style="font-family:배달의민족 도현; font-size:22px; line-height:1.5em; margin-top:30px;">개개인마다 다른 걸음걸이의 기계 학습을 이용한 <br>생체 인식 기능 프로그램</p>
                    <button class="btn btn-primary btn-round" style="margin-top:20px;">
                        <a href="${pageContext.request.contextPath}/About.watchers" style="color:#fff !important"><i class="material-icons">add</i>&nbsp; 경험해보기</a>
                    </button>
                </div>
            </div>

            <div class="col-sm-6 hidden-xs animation animated-item-4">
                <div class="slider-img">
                    <img src="${pageContext.request.contextPath}/img/footprint3.png" class="img-responsive" style="margin-left:70px; margin-top:40px;">
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<!-- 	            end nav tabs -->

<div id="back-clr" class="back-clr" style="margin-top:250px; background-color:#fff;">
    <div class="container">
        <div class="row text-center pad-top pad-bottom">
            <div class="col-md-3">
                <i class="fa fa-search fa-3x icon-custom" id="features"></i>
                <h4>쉬운 접근성</h4>
                <hr/>
                <p>간편한 걸음걸이 등록으로 보다 쉬워진 보행자 찾기가 가능합니다.</p>

            </div>
            <div class="col-md-3">
                <i class="fa fa-arrow-up fa-3x icon-custom" id="features2"></i>
                <h4>인식의 정확도 증가</h4>
                <hr />
                <p>기계학습을 통한 데이터로 걸음걸이 정확도를 향상시켰습니다.</p>

            </div>
            <div class="col-md-3">
                <i class="fa fa-cloud fa-3x icon-custom" id="features3"></i>
                <h4>실종자 프로파일</h4>
                <hr />
                <p>데이터 마이닝을 이용한 실종자 빅데이터를 구축하였습니다.</p>
            </div>
            <div class="col-md-3">
                <i class="fa fa-thumbs-up fa-3x icon-custom" id="features4"></i>
                <h4>최적화된 프로그램</h4>
                <hr />
                <p>정확도가 향상된 시계열 데이터 분석으로 최적화된 프로파일링을 개발했습니다.</p>
            </div>
        </div>
    </div>

</div>

<div class="about">
    <div class="container" style="display:flex;">
        <div class="col-md-6">
            <h2>About WATCHERS</h2>
            <img src="${pageContext.request.contextPath}/img/about.JPG" class="img-responsive" />
        </div>
        <div class="col-md-6" style="margin-top:90px;">
            <p>수분에 취약하고, 외부 요인에 의해 소실 될 수 있는 지문인식의 문제점으로, 개개인마다 다른 걸음걸이를 이용한 생체 인식 기술이 필요합니다.
            <P>각자 다른 보행습관은 기존의 생체 인식 기술의 한계를 보완하며 신체 접속 없이 특정인의 인식을 가능하게 합니다.</P>
            <p>공공데이터를 활용한 실종자 프로파일 데이터를 분석하여 'WATCHERS'만의 빅데이터를 구축하여 최적화된 프로파일링 시스템을 안내합니다.
            </p>
            <p>기존 몸 이미지를 이용한 영상은 몸의 변화의 존재로 인해 사람 인식에 어려움이 있지만, 움직임 탐지가 가능한 키넥트(Kinect)로 기존의 가시광선 카메라뿐만 아니라 열화상 카메라로 3D 영상을 수집합니다.</p>
        </div>
    </div>
</div>
</div>

<div class="lates">
    <div class="text-center">
        <h2>Update News</h2>
    </div>
    <div class="container" style="display:flex;">
        <div class="col-md-4">
            <img src="${pageContext.request.contextPath}/img/update.jpg" class="img-responsive" />
            <h4>Version 0.9</h4>
            <p>걸음걸이 인식과 보행자 정보 등록 (베타 버전)
            </p>
        </div>

        <div class="col-md-4">
            <img src="${pageContext.request.contextPath}/img/update.jpg" class="img-responsive" class="img-responsive" />
            <h4>Version 1.0</h4>
            <p>걸음걸이 저장, 보행자 인식, 실종자 공공 데이터 업로드 완료
            </p>
        </div>

        <div class="col-md-4">
            <img src="${pageContext.request.contextPath}/img/update.jpg" class="img-responsive" class="img-responsive" />
            <h4>Version 1.3</h4>
            <p> 오류 수정
            </p>
        </div>
    </div>
</div>

<!--     <section id="public-missing"> -->
<!--         <div id="myCarousel" class="carousel slide border" data-ride="carousel"> -->
<!--             indicators -->
<!--             <div class="container"> -->
<!--                 <h2>실종자 공공데이터</h2> -->
<!--                 <ol class="carousel-indicators"> -->
<!--                     <li data-target="#myCarousel" data-slide-to="0" class="active"></li> -->
<!--                     <li data-target="#myCarousel" data-slide-to="1"></li> -->
<!--                     <li data-target="#myCarousel" data-slide-to="2"></li> -->
<!--                 </ol> -->
<!--             </div> -->
<!--         </div> -->
<!--         <div id="myCarousel" class="carousel slide border" data-ride="carousel"> -->
<!--             indicators -->
<!--             <ol class="carousel-indicators"> -->
<!--                 <li data-target="#myCarousel" data-slide-to="0" class="active"></li> -->
<!--                 <li data-target="#myCarousel" data-slide-to="1"></li> -->
<!--                 <li data-target="#myCarousel" data-slide-to="2"></li> -->
<!--             </ol> -->
<!--             변경 에정 -->
<!--             <div class="carousel-inner"> -->
<!--                 <div class="carousel-item active"> -->
<!--                     <table class="table table-user-information"> -->
<!--                         <tbody> -->
<!--                             <tr> -->
<!--                                 <td>이름</td> -->
<!--                                 <td>성별</td> -->
<!--                                 <td>실종당시 나이</td> -->
<!--                                 <td>현재 나이</td> -->
<!--                                 <td>실종 지역</td> -->
<!--                             </tr> -->
<!--                             <tr> -->
<!--                                 <td> -->
<%--                                     <%=missings.name%> --%>
<!--                                 </td> -->
<!--                                 <td> -->
<%--                                     <%=missings.sex%> --%>
<!--                                 </td> -->
<!--                                 <td> -->
<%--                                     <%=missings.occr_age%> --%>
<!--                                 </td> -->
<!--                                 <td> -->
<%--                                     <%=missings.current_age%> --%>
<!--                                 </td> -->
<!--                                 <td> -->
<%--                                     <%=missings.occr_address%> --%>
<!--                                 </td> -->
<!--                             </tr> -->
<!--                         </tbody> -->
<!--                     </table> -->
<!--                 </div> -->
<!--             </div> -->
<!--             Controls -->
<!--             <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev"> -->
<!--                 <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->
<!--                 <span class="sr-only">Previous</span> -->
<!--             </a> -->
<!--             <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next"> -->
<!--                 <span class="carousel-control-next-icon" aria-hidden="true"></span> -->
<!--                 <span class="sr-only">Next</span> -->
<!--             </a> -->
<!--         </div> -->
<!--     </section> -->

<section id="contact-page">
    <div class="container" style="margin-top:50px;">
        <div class="center">
            <h2>Contact Us</h2>
            <p>고객센터에 메세지를 보내 궁금증을 해결하세요.</p>
        </div>
        <div class="contact-wrap">
            <div class="status alert alert-success" style="display: none"></div>
            <div class="col-md-6 col-md-offset-3">
                <div id="sendmessage">감사합니다!</div>
                <div id="errormessage"></div>
                <form action="/contact_write" method="post" role="form" class="contactForm" onsubmit="return onWriteSubmit()">
                    <div class="form-group">
                        <input type="text" name="creator_name" class="form-control" id="creator_name" placeholder="이름" data-rule="text" data-msg="이름을 입력해주세요." required/>
                        <div class="validation"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="mail" id="mail" placeholder="이메일" data-rule="text" data-msg="이메일을 입력해주세요." required/>
                        <div class="validation"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" name="title" id="title" placeholder="제목" data-rule="text" data-msg="제목을 입력해주세요." required/>
                        <div class="validation"></div>
                    </div>
                    <div class="form-group">
                        <textarea class="form-control" name="message" rows="5" data-rule="required" data-msg="내용을 입력해주세요." placeholder="내용" required></textarea>
                        <div class="validation"></div>
                    </div>
                    <div class="text-center"><button type="submit" name="submit" class="btn btn-primary btn-lg" required="required" style="margin-top: 20px;">메세지 보내기</button></div>
                </form>

                <script>
                    function onWriteSubmit() {
                        if ($("creator_name").val().trim() == "") {
                            var message = "아이디를 입력해주세요";
                            $("#creator_id").val("");
                            $("#creator_id").focus();
                            alert(message);
                            return false;
                        }
                        if ($("#mail").val().trim() == "") {
                            var message = "이메일을 입력해 주세요";
                            $("#mail").val("");
                            $("#mail").focus();
                            alert(message);
                            return false;
                        }

                        if ($("#title").val().trim() == "") {
                            var message = "제목을 입력해 주세요";
                            $("#title").val("");
                            $("#title").focus();
                            alert(message);
                            return false;
                        }

                        if ($("#content").val().trim() == "") {
                            var message = "본문 내용을 입력해 주세요";
                            $("#content").val("");
                            $("#content").focus();
                            alert(message);
                            return false;
                        }
                    }

                </script>
            </div>
        </div>
        <!--/.row-->
    </div>
    <!--/.container-->
</section>
<!--/#contact-page-->


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