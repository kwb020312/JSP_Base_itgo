<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dfFormat = new DecimalFormat("###,###"); // 천단위 구분자 입력
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>상품 수정</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<%@include file="dbconn.jsp" %>
	<%
		// 어떤 제품을 편집할 것인가
		String productId = request.getParameter("id");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM product WHERE p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
	%>
		<div class="container">
			<div class="row">
				<div class="col-md-5">
					<img alt="Product Image" src="./resources/images/<%= rs.getString("p_filename") %>" style="width:100%" />
				</div>
			
			<div class="col-md-7">
				<form name="newProduct" action="./processUpdateProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<label class="col-sm-3">상품 코드</label>
						<div class="col-sm-3">
							<input type="text" id="productId" name="productId" class="form-control" value="<%= rs.getString("p_id") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">상품명</label>
						<div class="col-sm-3">
							<input type="text" id="name" name="name" class="form-control" value="<%= rs.getString("p_name") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">가격</label>
						<div class="col-sm-3">
							<input type="text" id="unitPrice" name="unitPrice" class="form-control" value="<%= rs.getInt("p_unitPrice") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">상세 설명</label>
						<div class="col-sm-3">
							<input type="text" id="description" name="description" class="form-control" value="<%= rs.getString("p_description") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">제조사</label>
						<div class="col-sm-3">
							<input type="text" id="manufacturer" name="manufacturer" class="form-control" value="<%= rs.getString("p_manufacturer") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">분류</label>
						<div class="col-sm-3">
							<input type="text" id="category" name="category" class="form-control" value="<%= rs.getString("p_category") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">재고 수</label>
						<div class="col-sm-3">
							<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" value="<%= rs.getLong("p_unitsInStock") %>" />
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">상태</label>
						<div class="col-sm-5">
							<input type="radio" name="condition" value="New" /> 신규 제품
							<br/>
							<input type="radio" name="condition" value="Old" /> 중고 제품
							<br/>
							<input type="radio" name="condition" value="Refurbished" /> 재생 제품
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3">이미지</label>
						<div class="col-sm-5">
							<input type="file" name="productImage" class="form-control" />
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" value="편집완료" />
						</div>
					</div>
				</form>
			</div>
			</div>
		</div>
	<% 
		}
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	%>
</body>
</html>