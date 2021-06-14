

<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-10">
                <g:each var="room" in='${rooms}'>
                    <div class="cntr-switch-panel" style="background-image: url('${resource(dir: "images", file: "${room.image}")}');" onClick='location.href="${createLink(action:"switchDevices", params:[id:"${room.id}"])}"';>
                        <div class="cntr-switch-panel-title">
                            <p>${room.name}</p>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </body>
</html>
