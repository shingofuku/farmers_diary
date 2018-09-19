<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${errors != null}">
	<div id="flush_error">
		入力内容にエラーがあります。<br />
		<c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" />
			<br />
		</c:forEach>

	</div>
</c:if>
<label for="diary_date">日付</label>
<br />
<input type="date" name="diary_date"
	value="<fmt:formatDate value='${diary.diary_date }' pattern='yyyy-MM-dd' />" />
<br />
<br />

<label for="name">氏名</label>
<br />
<c:out value="${sessionScope.login_employee.name}" />
<br />
<br />

<label for="title">タイトル</label>
<br />
<input type="text" name="title" value="${diary.title }" />
<br />
<br />

<label for="content">作業内容</label>
<br />
<textarea name="content" rows="10" cols="50">${diary.content}</textarea>
<br />
<br />

<label for="fixtures">使用した農薬・肥料など</label>
<br />
<textarea name="fixtures" rows="5" cols="50">${diary.fixtures}</textarea>
<br />
<br />

<input type="hidden" name="_token" value="${_token}" />
<button type="submit">登録</button>