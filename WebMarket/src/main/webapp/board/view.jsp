<%@page import="mvc.model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	BoardDTO notice = (BoardDTO)request.getAttribute("board");
	int num = (Integer)request.getAttribute("num");
	int nowpage = (Integer)request.getAttribute("pageNum");
	String sessionId = (String)session.getAttribute("sessionId");
	String userId = notice.getId();
	/* out.println(notice.getName());
	out.println(num);
	out.println(nowpage); */
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>글 상세 보기</title>
</head>
<body>
	<jsp:include page="../menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	
	<div class="container">
		<form name="newUpdate" action="BoardUpdateAction.do?num=<%= notice.getNum() %>&pageNum=<%= nowpage %>" class="form-horizontal" method="post">
			<!-- DB에 저장된 이름 출력 -->
			<div class="form-group row">
				<label class="col-sm-2 control-label">이름</label>
				<div class="col-sm-3">
					<input name="name" class="form-control" value="<%= notice.getName() %>" readonly />
				</div>
			</div>
			<!-- DB에 저장된 제목 출력 -->
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
				<%
					if(sessionId.equals(userId)) {
				%>
						<input name="subject" class="form-control" value="<%= notice.getSubject() %>" />
				<%
					} else {
				%>
						<input name="subject" class="form-control" value="<%= notice.getSubject() %>" readonly />
				<%	
					}
				%>
				</div>
			</div>
			<!-- DB에 저장된 제목 출력 -->
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<!-- word-break속성은 줄 바꿈에 대한 속성을 지정 -->
				<div class="col-sm-8" style="word-break: break-all" >
					<%
						if(sessionId.equals(userId)) {
					%>
							<textarea name="content" class="form-control" rows="5" cols="50" ><%= notice.getContent() %></textarea>
					<%
						} else {
					%>
							<textarea name="content" class="form-control" rows="5" cols="50" readonly ><%= notice.getContent() %></textarea>
					<%	
						}
					%>
				</div>
			</div>
			<!-- 게시글 작성자 본인이라면, 수정 및 삭제가능 -->
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<c:set var="userId" value="<%= notice.getId() %>" />
					<c:if test="${ sessionId == userId }">
						<a href="./BoardDeleteAction.do?num=<%= notice.getNum() %>&pageNum=<%= nowpage %>" class="btn btn-danger">삭제</a>
						<input type="submit" class="btn btn-success" value="수정" />
					</c:if>
					<a href="./BoardListAction.do?pageNum=<%= nowpage %>" class="btn btn-primary">목록</a>
				</div>
			</div>
		</form>
		<hr/>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>