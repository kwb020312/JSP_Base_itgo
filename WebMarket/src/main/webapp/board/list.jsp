<%@page import="mvc.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String sessionId = (String)session.getAttribute("sessionId");
	ArrayList<BoardDTO> boardList = (ArrayList<BoardDTO>)request.getAttribute("boardlist");
	int total_record = ((Integer)request.getAttribute("total_record")).intValue();
	int pageNum = ((Integer)request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer)request.getAttribute("total_page")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>게시판</title>
<script type="text/javascript">
	// 로그인 여부 판별
	function checkForm() {
		if(${ sessionId == null }) {
			alert("로그인 되지 않았습니다.")
			return false
		}
		
		location.href = "./BoardWriteForm.do?id=<%= sessionId %>";
	}
	
	function loginForm() {
		if(${ sessionId == null }) {
			alert("로그인 후 조회가 가능합니다.")
			return false
		}
	}
</script>
</head>
<body>
	<jsp:include page="../menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div> 
	<div class="container">
		<form action="<c:url value='./BoardListAction.do' />" method="post">
			<div>
				<div class="text-right">
					<span class="badge badge-danger">전체 건수 : <%= total_record %></span>
				</div>
			</div>
			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회</th>
						<th>글쓴이</th>
					</tr>
					<%
						for(int j = 0 ; j < boardList.size() ; j ++) {
							BoardDTO notice = boardList.get(j);
					%>
					<tr>
						<td><%= notice.getNum() %></td>
						<!-- 게시글 제목 선택시 조회가 가능하도록 -->
						
						<td>
							<% if(sessionId == null) { %>
								<a href="#" onclick="loginForm()" ><%= notice.getSubject() %></a>
							<% } else { %>
								<a href="./BoardViewAction.do?num=<%= notice.getNum() %>&pageNum=<%= pageNum %>"><%= notice.getSubject() %></a>
							<% } %>
						</td>
						<td><%= notice.getRegist_day() %></td>
						<td><%= notice.getHit() %></td>
						<td><%= notice.getName() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div align="center">
				<c:set var="pageNum" value="<%= pageNum %>" />
				<c:forEach var="i" begin="1" end="<%= total_page %>">
					<a href="<c:url value='./BoardListAction.do?pageNum=${ i }' />">
						<c:choose>
							<c:when test="${ pageNum == i }">
								<font color="4C5317">
									<b>[${ i }]</b>
								</font>
							</c:when>
							<c:otherwise>
								<font color="4C5317">
									[${ i }]
								</font>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
			</div>
			<!-- 검색 페이지 코드 -->
			<div align="left">
				<table>
					<tr>
						<td width="100%" align="left">&nbsp;&nbsp;
							<select name="items" class="txt">
								<option value="subject">제목</option>
								<option value="content">본문</option>
								<option value="name">글쓴이</option>
							</select>
							<input name="text" type="text" />
							<input type="submit" id="btnAdd" class="btn btn-primary btn-sm" value="검색" />
						</td>
						<td width="100%" align="right">
							<!-- 로그인된 회원 외 글쓰기 제한 -->
							<a href="#" onclick="checkForm()" class="badge badge-primary">글쓰기</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<hr/>	
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>