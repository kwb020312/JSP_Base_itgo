<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<body>
	<!-- 다국어 처리를 하기 위한 코드 -->
	<fmt:setLocale value='<%= request.getParameter("language") %>' />
	<fmt:bundle basename="resourceBundle.message">

	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><fmt:message key="title" /></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="?language=ko">Korean</a>||<a href="?language=en">English</a>
			<!-- 로그아웃 -->
			<a href="logout.jsp" class="btn btn-sm btn-success pull-right"><b>logout</b></a>
		</div>
	
		<form name="newProduct" action="./processAddProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data" >
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="productId" /></b></label>
				<div class="col-sm-3">
					<input type="text" id="productId" name="productId" class="form-control" placeholder="상품코드를 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="pname" /></b></label>
				<div class="col-sm-3">
					<input type="text" id="name" name="name" class="form-control" placeholder="상품명을 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="unitPrice" /></b></label>
				<div class="col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class="form-control" placeholder="가격을 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="description" /></b></label>
				<div class="col-sm-3">
					<textarea name="description" cols="50" rows="2" class="form-control" placeholder="상세 정보를 입력해주세요"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="manufacturer" /></b></label>
				<div class="col-sm-3">
					<input type="text" name="manufacturer" class="form-control" placeholder="제조사를 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="category" /></b></label>
				<div class="col-sm-3">
					<input type="text" name="category" class="form-control" placeholder="분류를 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="unitsInStock" /></b></label>
				<div class="col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" placeholder="재고 수량을 입력하세요." />
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="condition" /></b></label>
				<div class="col-sm-5">
					<input type="radio" name="condition" value="New" /><fmt:message key="condition_New" />
					<input type="radio" name="condition" value="Old" /> <fmt:message key="condition_Old" />
					<input type="radio" name="condition" value="Refublished" /> <fmt:message key="condition_Refurbished" />
				</div>
			</div>
			
			<!-- 상품 이미지 업로드 부분 -->
			<div class="form-group row">
				<label class="col-sm-2" ><b><fmt:message key="productImage" /></b></label>
				<div class="col-sm-5">
					<input type="file" name="productImage" class="form-control" />
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" onclick="CheckAddProduct()" class="btn btn-primary" value="<fmt:message key="button" />" />
				</div>
			</div>
		</form>
	</div>
	<script src="./resources/js/validation.js"></script>
	</fmt:bundle>
</body>
</html>