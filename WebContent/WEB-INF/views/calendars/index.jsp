<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
    <head>
        <meta  http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fullcalendar.css" type="text/css">
    <script src="${pageContext.request.contextPath}/js/moment.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/fullcalendar.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/ja.js" type="text/javascript"></script>
        <title>カレンダー</title>
    </head>
    <body>
   <div id="calendar"></div>
<script>
      $('#calendar').fullCalendar();
</script>


    </body>
</c:param>
</c:import>