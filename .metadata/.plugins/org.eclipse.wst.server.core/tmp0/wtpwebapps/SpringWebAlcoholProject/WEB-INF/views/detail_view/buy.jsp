<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sample</title>
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

<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script>
	window.onload = function(){
		var url ='buy_product.do';
		var param ='idx='+${idx};
		sendRequest(url,param,resFn,"POST")

	}
	let price;
	function resFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			price = xhr.responseText;
		}
	}
	function amount_pm(op) {
		const f = document.ff;
		const amount = parseInt(f.amount.innerHTML);
		let totPrice = parseInt(f.totPrice.innerHTML);

		if (op == '+') {
			f.amount.innerHTML = amount + 1;
			totPrice += price;
		} else if (op == '-' && amount > 1) {
			f.amount.innerHTML = amount - 1;
			totPrice -= price;
		}

		f.totPrice.innerHTML = totPrice;
	}
</script>
</head>
<body>
<jsp:include page="buy.jsp?idx='상품일련번호'"></jsp:include>
	<form name="ff" class="card">
		<div class="card-body">수량</div>
		<div class="card-body row">
			<div class="btn-group" role="group" aria-label="Basic outlined">
				<button type="button" class="btn btn-outline-primary col"
					onclick="amount_pm('-');">-</button>
				<button type="button" name="amount"
					class="btn btn-outline-primary col-6" disabled>1</button>
				<button type="button" class="btn btn-outline-primary col"
					onclick="amount_pm('+');">+</button>
			</div>
		</div>
		<div class="card-body">총 가격</div>
		<div class="card-body row">
			<button type="button" name="totPrice"
				class="btn btn-outline-primary col" disabled></button>
		</div>
		<div class="card-body">배송료는 3000원입니다.</div>
		<div class="card-body row">
			<button type="button" class="btn btn-outline-primary col">장바구니</button>
			<button type="button" class="btn btn-outline-primary col">선물하기</button>
		</div>
		<div class="card-body row">
			<button type="button" class="btn btn-outline-primary col">구매하기</button>
		</div>
	</form>

	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
 	<script
		src="${pageContext.request.contextPath}/resources/js/register/mainjs.js"></script>
	<!-- Vendor JS Files -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/main_js/main.js"></script>
</body>
</html>