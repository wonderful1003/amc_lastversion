<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  <%@ page contentType="text/html; charset=EUC-KR" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>
			<h3>�� ����</h3>
		</div>
		
		<div class="row">
			<div class="col-md-6 text-left">
				<p> ��ü �� ��, ���� �� ������</p>
			</div>
			
			
			<div class="col-md-6 text-right">
			
				<form name="detailForm">
					<div>
						<select name="searchCondition">
							<option value="0">��ȭ ����</option>
							<option value="1">������</option>
						</select>
					</div>
			
			<div>
				<label for="searchKeyword">�˻���</label>
				<input type="text" id="searchKeyword" name="searchKeyword" placeholder="�˻���">
			</div>
			
			<button type="button" name = "searchButton">�˻�</button>
			
			<input type="hidden" id="currnetPage" name="currentPage" value=""/>
			</form>

		</div>
	</div>
	
	
	
	<div>
		<div class="row">
		<table>
			<c:set var="i" value="0"/>
				<c:forEach var="screen" items="${list }">
					<c:set var="i" value="${i+1 }"/>
					<tr>
						<td>��ȭ</td>
						<td>�׽�</td>
						<td>Ʈ</td>
					</tr>
					
				</c:forEach>
		</table>	
		</div>
	
	</div>
	
	
	
	
	
</div>
</body>
</html>