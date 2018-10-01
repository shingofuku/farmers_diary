<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta  http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/css/fullcalendar.css" type="text/css">
    <script src="js/moment.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="js/fullcalendar.min.js" type="text/javascript"></script>
    <script src="js/ja.js" type="text/javascript"></script>
        <title>カレンダー</title>
    </head>
    <body>
    <div id="calendar">
      <script>
        $('#calendar').fullCalendar();
      </script>
    </div>


    </body>
</html>