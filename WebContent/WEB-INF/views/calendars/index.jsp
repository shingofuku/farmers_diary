<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
	<c:param name="content">
		<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/fullcalendar.css"
	type="text/css">
<script src="${pageContext.request.contextPath}/js/moment.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.min.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/fullcalendar.min.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/ja.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/js/gcal.js"
	type="text/javascript"></script>

<title>カレンダー</title>
		</head>
		<body>
			<div id="calendar"></div>
			<div id='loading'>loading...</div>

			<div class="row">
    <div class="col-md-2 col-sm-2 col-xs-12">
        <button id="authorize-button" style="visibility: hidden" class="btn btn-primary">Authorize</button>
    </div><!-- .col -->

    <div class="col-md-10 col-sm-10 col-xs-12"><script type="text/javascript">
                $('#calendar')
                        .fullCalendar(
                                {
                                    header : {
                                        left : 'prev,next today',
                                        center : 'title',
                                        right : 'month,agendaWeek,agendaDay,listWeek'
                                    },

                                    navLinks : true, // can click day/week names to navigate views
                                    selectable : true,
                                    selectHelper : true,
                                    select : function(start, end) {

                                        var eventData;
                                        if (title) {
                                            eventData = {
                                                title : title,
                                                start : start,
                                                end : end
                                            }, $('#calendar').fullCalendar(
                                                    'renderEvent', eventData,
                                                    true); // stick? = true
                                        }
                                        $('#calendar').fullCalendar('unselect');
                                    },
                                    editable : true,
                                    eventLimit : true, // allow "more" link when too many events

                                    googleCalendarApiKey : 'AIzaSyB6GrksUx1kN_fcLPQo7JVX0Qv7XaNp9Uc',

                                    events : '56eag7e94dnr0m8ql47b0rdn8o@group.calendar.google.com',

                                    eventClick : function(event) {
                                        // opens events in a popup window
                                        window.open(event.url, 'gcalevent',
                                                'width=700,height=600');
                                        return false;
                                    },

                                    loading : function(bool) {
                                        $('#loading').toggle(bool);
                                    },

                                });

    </script>


        <script type="text/javascript">
            // date variables
            var now = new Date();
            today = now.toISOString();

            var twoHoursLater = new Date(now.getTime() + (2*1000*60*60));
            twoHoursLater = twoHoursLater.toISOString();

            var clientId = '6480628450-t1ita155qdtehsu77bi3od3i8ef0ssih.apps.googleusercontent.com';
            var apiKey = 'AIzaSyB6GrksUx1kN_fcLPQo7JVX0Qv7XaNp9Uc';

            var scopes = 'https://www.googleapis.com/auth/calendar';

            function handleClientLoad() {
                gapi.client.setApiKey(apiKey);
                window.setTimeout(checkAuth,1);
            }

            function checkAuth() {
                gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: true}, handleAuthResult);
            }

            function handleAuthResult(authResult) {
                var authorizeButton = document.getElementById('authorize-button');
                var resultPanel     = document.getElementById('result-panel');
                var resultTitle     = document.getElementById('result-title');

                if (authResult && !authResult.error) {
                    authorizeButton.style.visibility = 'hidden';            // if authorized, hide button
                    resultPanel.className = resultPanel.className.replace( /(?:^|\s)panel-danger(?!\S)/g , '' ) // remove red class
                    resultPanel.className += ' panel-success';              // add green class
                    resultTitle.innerHTML = 'Application Authorized'        // display 'authorized' text
                    makeApiCall();                                          // call the api if authorization passed
                } else {                                                    // otherwise, show button
                    authorizeButton.style.visibility = 'visible';
                    resultPanel.className += ' panel-danger';               // make panel red
                    authorizeButton.onclick = handleAuthClick;              // setup function to handle button click
                }
            }

            // function triggered when user authorizes app
            function handleAuthClick(event) {
                gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
                return false;
            }

            // setup event details
            var resource = {
                "summary": "予定を入力してください" + Math.floor((Math.random() * 10) + 1),
                "start": {
                    "dateTime": today
                },
                "end": {
                    "dateTime": today
                }
            };


            function makeApiCall() {
                gapi.client.load('calendar', 'v3', function() {
                    var request = gapi.client.calendar.events.insert({
                        'calendarId':       '56eag7e94dnr0m8ql47b0rdn8o@group.calendar.google.com',
                        "resource":         resource
                    });

                    // handle the response from our api call
                    request.execute(function(resp) {
                        if(resp.status=='confirmed') {
                            document.getElementById('event-response').innerHTML = "Event created successfully. View it <a href='" + resp.htmlLink + "'>カレンダーに入力</a>.";
                        } else {
                            document.getElementById('event-response').innerHTML = "There was a problem. Reload page and try again.";
                        }
                        /* for (var i = 0; i < resp.items.length; i++) {        // loop through events and write them out to a list
                            var li = document.createElement('li');
                            var eventInfo = resp.items[i].summary + ' ' +resp.items[i].start.dateTime;
                            li.appendChild(document.createTextNode(eventInfo));
                            document.getElementById('events').appendChild(li);
                        } */
                        console.log(resp);
                    });
                });
            }
        </script>
        <script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>

        <div class="panel panel-danger" id="result-panel">
            <div class="panel-heading">
                <h3 class="panel-title" id="result-title"></h3>
            </div><!-- .panel-heading -->
            <div class="panel-body">
                <p>&hellip;</p>
                <div id="event-response"></div>
            </div><!-- .panel-body -->
        </div><!-- .panel -->

    </div><!-- .col -->
</div><!-- .row -->




		</body>
	</c:param>
</c:import>