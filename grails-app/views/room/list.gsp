
<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#rooms").addClass("active");
            });
        </script>
    </head>
    <body>

        <div class="container">
            <h1>Raumliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button></h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-3">
                <table class="table table-striped" >
                    <thead>
                    <th>
                        Raum
                    </th>
                    <th>
                        Aktion
                    </th>
                    </thead>
                    <tbody>
                        <g:each in="${roomInstanceList}" status="i" var="roomInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td><g:link action="edit" id="${roomInstance.id}">${fieldValue(bean: roomInstance, field: "name")}</g:link></td>
                                <td><a href="${createLink (action:'delete')}/${roomInstance.id}"  onClick="return confirm('Raum: [${roomInstance.name}] löschen ?');"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
