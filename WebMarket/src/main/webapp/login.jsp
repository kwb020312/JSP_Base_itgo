<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="EUC-KR">
<title>�α���(login)</title>
</head>
<body>
	<jsp:include page="menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">�α���</h1>
		</div>
	</div>
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				String error = request.getParameter("error");
				if(error != null) {
					out.println("<div class='alert alert-dange'>");
					out.println("���̵�� ��й�ȣ�� Ȯ���� �ּ���!");
					out.println("</div>");
				}
			%>
			<form class="form-signin" action="j_security_check" method="post">
				<!-- ���̵� �Է��ϴ� �κ� -->
				<div class="form_group">
					<label for="inputUserName" class="sr-only">User Name</label>
					<input type="text" class="form-control" placeholder="ID" name="j_username" required autofocus/>
				</div>
				<!-- ��й�ȣ�� �Է��ϴ� �κ� -->
				<div class="form_group">
					<!-- sr-only�� SEO�� ���� ���ҷ� ���� �����. -->
					<label for="inputPassword" class="sr-only">Password</label>
					<input type="password" class="form-control" placeholder="Password" name="j_password" required/>
				</div>
				<button class="btn btn-lg btn-success btn-block" type="submit">�α���</button>
			</form>
		</div>
	</div>
</body>
</html>