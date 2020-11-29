
<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceGroup.label', default: 'Room')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#deviceGroups").addClass("active");
            });
        </script>
    </head>
    <body>

        <div class="container">
            <h1>Gerätegruppenliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-3">
                <table class="table table-striped" >
                    <thead>
                    <th>
                        Gruppe
                    </th>
                    <th>
                        Aktion
                    </th>
                    </thead>
                    <tbody>
                        <g:each in="${deviceGroupInstanceList}" status="i" var="deviceGroupInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td><g:link action="edit" id="${deviceGroupInstance.id}">${fieldValue(bean: deviceGroupInstance, field: "name")}</g:link></td>
                                <td><a href="${createLink (action:'delete')}/${deviceGroupInstance.id}"  onClick="return confirm('Gerätegruppe: [${deviceGroupInstance.name}] löschen ?');"><span class="fa fa-trash" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
