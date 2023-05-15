<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
pageContext.setAttribute("LF", "\n");
%>
<html>
<head>
<title>Product_list</title>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<meta content="" name="description">
<meta content="" name="keywords">

<!-- Google Fonts -->
<%--<link href="https://fonts.gstatic.com" rel="preconnect">
            <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
                  rel="stylesheet">--%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>

<!-- Vendor CSS Files -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<%-- DetailView CSS Files--%>
<%--<link href="${pageContext.request.contextPath}/resources/css/detailview_css/main.css?ver=1"
              rel="stylesheet">--%>
<link
	href="${pageContext.request.contextPath}/resources/css/detailview_css/detail.css?ver=1"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

</head>

<body>

	<c:if test="${isUser1 ne null}">
		<!-- Button trigger modal -->
		<button type="hidden" id="modalBtn" class="btn btn-primary"
			data-bs-toggle="modal" data-bs-target="#exampleModal">Launch
			demo modal</button>

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
							data-bs-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- ======= Header ======= -->
	<jsp:include page="../main/header.jsp"></jsp:include>

	<div class="row">
		<br> <br> <br>
	</div>

	<main id="main" class="main">
		<section id="blog" class="blog">
			<div class="container" data-aos="fade-up">
				<div class="row g-5">
					<div class="col-lg-8">
						<article class="blog-details">
							<div class="post-img">
								<div class="row gx-4 gx-lg-5">
									<div class="col-md-6 d-flex justify-content-center">
										<img
											src="${pageContext.request.contextPath}/resources/alcohol_image/${vo1.product_thumbnail_filename}"
											alt="" class="img-fluid top_img">
									</div>
									<div class="col-md-6 right_box">
										<div class="d-flex"
											style="font-size: 27px; font-weight: bold; color: #808080; margin-top: 5px;">
											${vo1.product_name}</div>
										<div class="d-flex"
											style="font-size: 18px; font-weight: bold; color: #c8c8c8; margin-bottom: 5px;">
											${vo1.product_simple_content}</div>
										<div class="d-flex" style="margin-bottom: 20px;">
											<div class="starpoint_wrap">
												<div class="starpoint_box">
													<c:forEach var="i" begin="1" end="10">
														<label for="starpoint_${i / 2.0}" class="label_star"
															title="${i / 2.0}"> <span class="blind">${i/2.0}점</span>
														</label>
														<input type="radio" id="starpoint_${i / 2.0}"
															class="star_radio">
													</c:forEach>
													<span class="starpoint_bg"></span>
												</div>
											</div>
											<span>${review_score}</span>
										</div>
										<div class="d-flex a_info">
											<span>주종 : ${vo1.product_type}</span>
										</div>
										<div class="d-flex a_info">
											<span>도수 : ${vo1.product_alcohol_degree}%</span>
										</div>
										<div class="d-flex a_info" style="margin-bottom: 30px;">
											<span>용량 : ${vo1.product_capacity}</span>
										</div>
										<div class="d-flex"></div>
										<div class="fs-5 mb-5 sell" style="margin-bottom: 10px;">
											판매가격 : <span class="price"><fmt:formatNumber
													value="${vo1.product_price}" pattern="#,###" />원</span>
										</div>
										<div class="d-flex expi">
											<span>유통기한 : <c:if
													test="${empty vo1.product_expiration_date }">
                                                유통기한 없음
                                            </c:if>
												${vo1.product_expiration_date}
											</span>
										</div>
										<c:if test="${ user1.user1_email eq 'alcohol2@gmail.com'}">
											<div class="d-flex expi ">
												<input class="modify" type="button" value="수정"
													onclick="product_modify(${ vo1.product_idx })">
												<input class="delete" type="button" value="삭제"
													onclick="product_delete(${ vo1.product_idx })">
											</div>
										</c:if>
									</div>
								</div>
							</div>
							<div style="height: 50px; display: flex; margin: 50px 0;">
								<div>
									<i class='bx bx-bowl-hot'
										style='color: #008374; font-size: 50px;'> </i>
								</div>
								<div>
									<div style="height: 15px;"></div>
									<span
										style="padding-left: 10px; font-size: 20px; font-weight: 500;">
										${vo1.product_point_snack} </span>
								</div>
							</div>

							<div>
								<div class="title_1">향미그래프</div>
								<div class="g">
									<span class="gs">단 맛 : </span>
									<div class="progress " role="progressbar"
										aria-label="Basic example" aria-valuenow="100"
										aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar"
											style="width: ${vo1.product_sweet_rating * 10}%">${vo1.product_sweet_rating}</div>
									</div>
								</div>
								<div class="g">
									<span class="gs">신 맛 : </span>
									<div class="progress" role="progressbar"
										aria-label="Basic example" aria-valuenow="100"
										aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar"
											style="width: ${vo1.product_sourish_rating * 10}%">${vo1.product_sourish_rating}</div>
									</div>
								</div>
								<div class="g">
									<span class="gs">깔끔함 : </span>
									<div class="progress" role="progressbar"
										aria-label="Basic example" aria-valuenow="100"
										aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar"
											style="width: ${vo1.product_cleantaste_rating * 10}%">${vo1.product_cleantaste_rating}</div>
									</div>
								</div>
								<div class="g">
									<span class="gs">바디감 : </span>
									<div class="progress" role="progressbar"
										aria-label="Basic example" aria-valuenow="100"
										aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar"
											style="width: ${vo1.product_bodytaste_rating * 10}%">${vo1.product_bodytaste_rating}</div>
									</div>
								</div>
								<div class="g">
									<span class="gs">탄산 : </span>
									<div class="sp_g">
										<c:choose>
											<c:when test="${ vo1.product_sparkling_rating ne 0 }">
                                            있음
                                        </c:when>
											<c:otherwise>
                                            없음
                                        </c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>

							<div style="overflow: hidden; margin: 50px 0;">
								<div class="title_1">상품구성</div>
								<div style="float: left;">
									<div style="display: flex;">
										<div>
											<i class='bx bx-beer'
												style='color: #ffc43f; font-size: 50px;'></i>
										</div>
										<div>
											<div style="height: 5px;"></div>
											<span
												style="font-size: 30px; font-style: italic; color: black; font-weight: bold; margin-left: 5px;">상품</span>
										</div>
									</div>
								</div>

								<div style="float: right;">
									<div style="display: flex;">
										<div>
											<i class='bx bx-package'
												style='color: #ffc43f; font-size: 50px;'></i>
										</div>
										<div>
											<div style="height: 5px;"></div>
											<span
												style="font-size: 30px; font-style: italic; color: black; font-weight: bold; margin-left: 5px;">택배박스</span>
										</div>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-center">
								<img class="img-fluid"
									src="${pageContext.request.contextPath}/resources/alcohol_image/${vo1.product_filename1}">
							</div>

							<div class="title_1" style="text-align: center;">[${ vo1.product_name }]
								어떤맛을 가지고 있나요?</div>

							<div class="content" style="text-align: center;">
								<pre class="content">${fn:replace(vo1.product_detail_content1,LF,"<br>")}</pre>
							</div>
							<!-- End post content -->
							<div class="d-flex justify-content-center">
								<img class="img-fluid"
									src="${pageContext.request.contextPath}/resources/alcohol_image/${vo1.product_filename2}">
							</div>

							<div class="title_1" style="text-align: center;">[${ vo1.product_name }]
								어떤음식과 어울리나요?</div>
							<div class="content" style="text-align: center;">
								<pre class="content">${fn:replace(vo1.product_detail_content2,LF,"<br>")}</pre>
							</div>

							<div class="company">
								<form action="producerName.do" id="go_select">
									<input type="hidden" name="producer_name"
										value="${vo1.producer_name}"> <a target=" _blank "
										href=" https://icons8.com/icon/37888/wooden-beer-keg "></a>
									<!-- 링크 -->
									<img class="company"
										src=" https://img.icons8.com/office/45/000000/wooden-beer-keg.png " />
									<!-- 아이콘 -->
									<span class="company com_text" onclick="show(this.form);">[${ vo1.producer_name }]</span>
								</form>
							</div>


							<!-- End post content -->
						</article>
						<!-- End blog post -->

					</div>

					<div class="col-lg-4">
						<div class="sidebar border rr_box">
							<form name="ff">

								<input name="idx" type="hidden">
								<input name="price" type="hidden">
								<input name="amount" type="hidden" value="1">
								<div style="width: 100%;">
									<div style="font-weight: bold; margin: 20px 0;">수량</div>
									<div class="input_number" style="width: 100%;">
										<div class="btn-group" role="group" aria-label="Basic example" style="width: 100%;">
											<button type="button" class="btn btn-primary left" onclick="cal('-');">-</button>
											<span class="btn btn-primary center" id="amount">1</span>
											<button type="button" class="btn btn-primary right" onclick="cal('+');">+</button>
										</div>
									</div>
								</div>
								<div style="width: 100%;">
									<div style="font-weight: bolder; margin: 20px 0;">총 가격<span style="color : #00665b; font-style:italic;">(배송비 3000원 포함)</span></div>
									<input id="total_price" class="number" name="totPrice" readonly>
								</div>
								<div class="shopping_basket">
									<button type="button" class="btn btn-primary number buy"
										onclick="cart(this.form);">

										<i class='bx bx-basket'>장바구니</i>
									</button>
								</div>
								<div class="shopping">
									<button type="button" class="btn btn-primary number buy"
										onclick="buying(this.form)">
										<i class='bx bx-gift'>구매하기</i>
									</button>
								</div>
							</form>
							<!-- End sidebar categories-->
						</div>
						<!-- End Blog Sidebar -->
					</div>
				</div>
			</div>
			<!-- End Blog Details Section -->
		</section>

		<div>
			<jsp:include
				page="product_review.jsp?review_list=${review_list}&review_map=${review_map}"></jsp:include>
		</div>

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<jsp:include page="../main/footer.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

	<!-- Vendor JS Files -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>

	<script
		src="${pageContext.request.contextPath}/resources/js/detailview_js/main.js"></script>

	<script type="text/javascript">

    window.onload = function () {

        var dom = document.getElementById('starpoint_${review_score}');


        let idx = '${vo1.product_idx}';
        document.ff.idx.value = idx;
        var url = 'buy_product.do';
        var param = 'idx=' + idx;
        sendRequest(url, param, resFn, "POST")
    }
    let price;

    function cal(op) {
        var total_number = document.getElementById('total_price');
        var center = document.getElementById('amount');
        var number = center.innerText;
        if (op == '-'&& number>1) {
            number--;
        } else if(op=='+'){
            number++;
        }
        total_number.value = price * number+3000;
        center.innerText = number;
    }//cal(op)

    function cart(f) {
        f.action = "cartAdd.do";
        f.price.value = f.totPrice.value;
        f.submit();

    }//cart(f)

    function buying(f) {
        f.method = "POST";
        f.action = "pay_ready1.do";
        f.price.value = f.totPrice.value;

        f.submit();
    }

    function product_delete(idx) {

        if (confirm("정말 삭제하시겠습니까?")) {
            location.href = "delete.do?product_idx=" + idx;

        } else {
            return;
        }
    }

    function product_modify(idx) {
        location.href = "modify.do?product_idx=" + idx;

    }//buying(f)
</script>

</body>
</html>