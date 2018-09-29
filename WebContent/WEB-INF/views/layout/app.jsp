<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
        <title>農家の日誌</title>
        <link rel="stylesheet" href="<c:url value='/css/reset.css' />">
        <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <div id="header_menu">
                    <h1><a href="<c:url value='/' />">農家の日誌</a></h1>&nbsp;&nbsp;&nbsp;
                    <c:if test="${sessionScope.login_employee != null}">
                        <c:if test="${sessionScope.login_employee.admin_flag == 1}">
                            <a href="<c:url value='/employees/index' />">従業員管理</a>&nbsp;
                        </c:if>
                        <a href="<c:url value='/diaries/index' />">日誌管理</a>&nbsp;
                    </c:if>
                </div>
                <c:if test="${sessionScope.login_employee != null}">
                    <div id="employee_name">
                        <c:out value="${sessionScope.login_employee.name}" />&nbsp;さん&nbsp;&nbsp;&nbsp;
                        <a href="<c:url value='/logout' />">ログアウト</a>
                    </div>
                </c:if>
            </div>
            <div id="content">
                ${param.content}
            </div>
            <div id="footer">
                by Shingo Fukuda.
            </div>
        </div>
    </body>
</html>