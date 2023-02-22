<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />

<%
	String sessionId = (String)session.getAttribute("sessionId");
%>

<!-- DB접속 -->
<sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/webmarketdb" driver="com.mysql.cj.jdbc.Driver" user="root" password="0000" />

<!-- SQL Query -->
<sql:query dataSource="${ dataSource }" var="resultSet">
	SELECT * FROM members WHERE id=?
	<sql:param value="<%= sessionId %>" />
</sql:query>

<title>정보수정</title>
</head>
<!-- onload속성은 모든 객체가 불러와진 후 실행된다. -->
<body onload="init()">
	<jsp:include page="/menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">정보 수정</h1>
		</div>
	</div>
	
	<!-- 메일은 '@'를 기준으로 split하여 할당한다. -->
	<c:forEach var="row" items="${ resultSet.rows }">
		<c:set var="mail" value="${ row.mail }" />
		<c:set var="mail1" value="${ mail.split('@')[0] }" />
		<c:set var="mail2" value="${ mail.split('@')[1] }" />
		
		
		<c:set var="birth" value="${ row.birth }" />
		<c:set var="year" value="${ birth.split('/')[0] }" />
		<c:set var="month" value="${ birth.split('/')[1]}" />
		<c:set var="day" value="${ birth.split('/')[2] }" />
		
		<c:set var="gender" value="${ row.gender }" />
		
		<div class="container">
			<form name="newMember" class="form-horizontal" action="processUpdateMember.jsp" method="post" onsubmit="return checkForm()">
				<div class="form-group row">
					<label class="col-sm-2">아이디</label>
					<div class="col-sm-3">
						<!-- id값을 변경할 수 없도록 지정 -->
						<input name="id" type="text" class="form-control" placeholder="아이디" value="<c:out value='${ row.id }' />" readonly />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">비밀번호</label>
					<div class="col-sm-3">
						<input name="password" type="password" class="form-control" placeholder="비밀번호" value="<c:out value='${ row.password }' />" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">비밀번호 확인</label>
					<div class="col-sm-3">
						<input name="password_confirm" type="password" class="form-control" placeholder="비밀번호 확인" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">이름</label>
					<div class="col-sm-3">
						<input name="name" type="text" class="form-control" placeholder="이름" value="<c:out value='${ row.name }' />" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">성별</label>
					<div class="col-sm-10">
						<input name="gender" type="radio" value="남" <c:if test="${ gender.equals('남') }"> <c:out value="checked" /> </c:if> />남
						<input name="gender" type="radio" value="여" <c:if test="${ gender.equals('여') }"> <c:out value="checked" /> </c:if> />여
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">생일</label>
					<div class="col-sm-4">
						<input name="birthyy" type="text" maxlength="4" placeholder="년도(4자리)" size="6" value="${ year }" />
						<select name="birthmm" id="birthmm">
							<option value="">월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" value="${ day }" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">이메일</label>
					<div class="col-sm-10">
						<input name="mail1" type="text" maxlength="50" value="${ mail1 }" />@
						<select name="mail2" id="mail2">
							<option>naver.com</option>
							<option>gmail.com</option>
							<option>daum.net</option>
							<option>nate.com</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">전화번호</label>
					<div class="col-sm-3">
						<input name="phone" type="text" class="form-control" placeholder="전화번호(-생략)" value="${ row.phone }" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">주소</label>
					<div class="col-sm-5">
						<input name="address" type="text" class="form-control" placeholder="주소" value="${ row.address }" />
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="수정반영" />
						<input type="button" class="btn btn-danger" value="회원탈퇴" onclick="return delete_member()" />
						<!-- <a href="deleteMember.jsp" class="btn btn-danger">회원 탈퇴</a> -->
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
<script type="text/javascript">
	function init() {
		setComboMailValue("${mail2}");
		setComboBirthValue("${month}");
	}
	
	function setComboMailValue(val) {
		const selectMail = document.getElementById('mail2');
		for(let i = 0 ; i < selectMail.length ; i ++) {
			if(selectMail.options[i].value === val) {
				selectMail.options[i].selected = true;
				break;
			}
		}
	}
	
	function setComboBirthValue(val) {
		const selectBirth = document.getElementById('birthmm');
		for(let i = 0 ; i < selectBirth.length ; i ++) {
			if(selectBirth.options[i].value === val) {
				selectBirth.options[i].selected = true;
				break;
			}
		}
	}


	function checkForm() {
		if(!document.newMember.id.value) {
			alert("아이디를 입력하세요!");
			return false
		}
		if(!document.newMember.password.value) {
			alert("비밀번호를 입력하세요!");
			return false
		}
		if(document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요!");
			return false
		}
		
		return true
	}
	
	// 회원 삭제
	function delete_member() {
		const result = confirm("정말 회원탈퇴를 하시겠습니까?")
		if(result) {
			location.href="deleteMember.jsp"
			alert("탈퇴되었습니다.")
		} else {
			alert("취소되었습니다.")
			return
		}
	}
</script>
</body>
</html>