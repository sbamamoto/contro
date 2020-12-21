
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

        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <h1>Gerätegruppenliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>

                <table class="table table-striped" >
                    <thead>
                    <th class='cntr-table-text'>
                        Gruppe
                    </th>
                    <th class='cntr-table-text'>
                        Aktion
                    </th>
                    </thead>
                    <tbody>
                        <g:each in="${deviceGroupInstanceList}" status="i" var="deviceGroupInstance">
                            <tr>
                                <td class='cntr-table-text'><g:link action="edit" id="${deviceGroupInstance.id}">${fieldValue(bean: deviceGroupInstance, field: "name")}</g:link></td>
                                <td><a href="${createLink (action:'delete')}/${deviceGroupInstance.id}"  onClick="return confirm('Gerätegruppe: [${deviceGroupInstance.name}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
