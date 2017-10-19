<%@ page import="com.amc.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	User user = new User();
	user.setUserId("sadf@naver.com");
	user.setRole("admin");
	session.setAttribute("user", user);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script type="text/javascript">
	function addOpenAlarm(){
   								$.ajax({
								    		url: "/alarm/json/switchOpenAlarm?screenContentNo=10000&userId="+"${sessionScope.user.userId}", //서버로 알림 체크 요청
								    		type: 'GET',
								    	}).done(function(data) {
								    		//정상 통신인 경우
								    		if ( data == 'add' ) {
								    			var msg = '오픈알림이 신청되었습니다.';
								    			/* msg += '\n무슨영화 : ' + movie정보;
								    			*/
								    			alert(msg);
								    		} else {
								    			alert("오픈알림이 취소되었습니다.");
								    		}
								    	});
							}//end of kakaoPayCancel function	
</script>


<body>

<input type="button" value="오픈 알림 신청" onClick="javascript:addOpenAlarm()">

</body>
</html>