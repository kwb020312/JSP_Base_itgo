<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	String edit = request.getParameter("edit"); // 넘어오는 edit값을 받는 중
	DecimalFormat dfFormat = new DecimalFormat("###,###"); // 천단위 구분자 입력
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>상품 편집</title>
<script type="text/javascript">
	function deleteConfirm(id) {
		if(confirm("해당 상품을 삭제합니다!!") == true)
			location.href = "./deleteProduct.jsp?id=" + id;
		else
			return;
		
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "SELECT * FROM product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
			%>
			<div class="col-md-4">
				<img src="./resources/images/<%= rs.getString("p_fileName") %>" style="width: 100%" />
				<h3><%= rs.getString("p_name") %></h3>
				<p><%= rs.getString("p_description") %></p>
				<p><%= dfFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</p>
				<p>
				<% 
					if(edit.equals("update")) {
				%>
					<a href="./updateProduct.jsp?id=<%= rs.getString("p_id") %>" class="btn btn-success" role="button">수정 &raquo;</a>
				<% } else if(edit.equals("delete")) { %>
					<a href="#" onclick="deleteConfirm('<%= rs.getString("p_id") %>')" class="btn btn-danger">삭제 &raquo;</a>
				<% } %>
				</p>
			</div>
			<%
				}
				
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
		</div>
		<hr/>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>