
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
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <h1>Raumliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
            
                <table class="table table-striped" >
                    <thead>
                    <th class="cntr-table-text">
                        Raum
                    </th>
                    <th class="cntr-table-text">
                        Reihenfolge
                    </th>
                    <th class="cntr-table-text">
                        Aktion
                    </th>
                    </thead>
                    <tbody>
                        <g:each in="${roomInstanceList}" status="i" var="roomInstance">
                            <tr>
                                <td class="cntr-table-text"><g:link action="edit" id="${roomInstance.id}">${fieldValue(bean: roomInstance, field: "name")}</g:link></td>
                                <td class="cntr-table-text">${roomInstance.showOrder}</td>
                                <td><a href="${createLink (action:'delete')}/${roomInstance.id}"  onClick="return confirm('Raum: [${roomInstance.name}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            
            </div>
        </div>
    </body>
</html>
