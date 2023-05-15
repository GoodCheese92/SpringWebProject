<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>header</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="#" rel="icon">
    <link href="#" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
            rel="stylesheet">

    <!-- Vendor CSS Files -->

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
            crossorigin="anonymous">


    <link
            href="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css"
            rel="stylesheet">


    <!-- Template Main CSS File -->
    <link
            href="${pageContext.request.contextPath}/resources/css/main_css/main.css"
            rel="stylesheet">

</head>
<body>
<c:if test="${isUser1 ne null}">
    <!-- Button trigger modal -->
    <button type="hidden" id="modalBtn" class="btn btn-primary"
            data-bs-toggle="modal" data-bs-target="#exampleModal">
        Launch demo modal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그인 정보 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">로그인 중입니다.</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<%--<jsp:include page="header.jsp"></jsp:include>--%>
<header id="header" class="header d-flex align-items-center">

    <div
            class="container-fluid container-xl d-flex align-items-center justify-content-between">
        <a href="main.do" class="logo d-flex align-items-center">
            <!-- Uncomment the line below if you also wish to use an image logo -->
            <!-- <img src="assets/img/logo.png" alt=""> -->
            <h1>
                술앗간<span>.</span>
            </h1>
        </a>

        <nav id="navbar" class="navbar">
            <ul>
                <li><a href="main.do">Home</a></li>
                <li class="nav-item dropdown"><a href="#"><span>상품보기</span></a>
                    <ul class="dropdown dropdown-menu-arrow profile">
                        <li><a href="fullview.do" class="dropdown-item"><span>전체상품</span>
                        </a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a href="best_product.do">베스트</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a href="new_product.do">신상품</a></li>
                    </ul>
                    <%--<li><a href="fullview.do">전체상품</a></li>
                                       <li><a href="#">신상품</a></li>
                                       <li><a href="#">베스트</a></li>--%>
                <%--<li><a href="#">담화배송</a></li>--%>
                <li><a href="event.do">이벤트</a></li>
                <%--<li><a href="#">구독</a></li>--%>
                <li><a href="board_list.do">자유게시판</a></li>


                <c:if test="${user1 eq null}">
                    <li><a href="login.do"> 로그인 해주세요. </a></li>
                </c:if>

                <li class="nav-item dropdown"><c:if test="${user1 ne null}">
                    <a
                            class="nav-link nav-profile d-flex align-items-center pe-0 text-decoration-none"
                            href="#" data-bs-toggle="dropdown"> <span
                            class="d-none d-md-block dropdown-toggle ps-2">${user1.user1_name}</span>
                    </a>

                    <%--<img src="${pageContext.request.contextPath}/resources/upload/Stephan.jpg" alt="Profile" class="rounded-circle">--%>
                    <!-- End Profile Iamge Icon -->

                    <ul class="dropdown-menu dropdown-menu-arrow profile">
                    	<c:if test="${ user1.user1_email eq 'alcohol2@gmail.com'}">
                    		<li>
	                            <a class="dropdown-item" href="product_insert.do">
	                                <span>상품 등록하기</span>
	                            </a>
                        	</li>
                        	<hr class="dropdown-divider">
                    	</c:if>
                        <li>
                            <a class="dropdown-item" href="pay_list.do">
                                <span>구매 목록</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="cart.do">
                                <span>장바구니 목록</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="user_reviewList.do?user1_idx=${user1.user1_idx}">
                                <span>리뷰 목록</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="my_information_modify.do">
                                <span>Account Settings</span>
                            </a>
                        </li>
                        <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="logout.do">
                                <span>Sign Out</span>
                            </a>
                        </li>

                    </ul>
                    <!-- End Profile Dropdown Items -->
                </c:if></li>
                <!-- End Profile Nav -->
            </ul>
        </nav>
        <!-- .navbar -->

        <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i> <i
            class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>

    </div>
</header>
<!-- End Header -->

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/register/mainjs.js"></script>
<!-- Vendor JS Files -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/main_js/main.js"></script>

</body>
</html>
