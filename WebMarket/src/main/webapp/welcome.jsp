<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>웹 쇼핑몰</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<%
		String greeting = "쇼핑몰입니다.";
		String tagline = "Welcome to Web Market";
	%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%= greeting %></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-center">
			<h3><%= tagline %></h3>
			<%
				// 접속시간 표시
				response.setIntHeader("Refresh", 5);
				Calendar calendar = Calendar.getInstance();
				int hour = calendar.get(Calendar.HOUR_OF_DAY);
				int minute = calendar.get(Calendar.MINUTE);
				int second= calendar.get(Calendar.SECOND);
				int am_pm = calendar.get(Calendar.AM_PM);
				String ampm = null; 
				if(am_pm == 0) {
					ampm = "am";
				} else {
					ampm = "pm";
				}
				
				String connectTime = hour + ":" + minute + ":" + second + " " + ampm;
				out.println("현재 접속 시간 : "+connectTime + "\n");
			%>
		</div>
	</div>
	<hr />
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>