
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceType.label', default: 'DeviceType')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <h1>DeviceTypescriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-8">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${deviceTypeInstanceList}" status="i" var="deviceTypeInstance">
                        <tr>                        
                            <td><g:link action="edit" id="${deviceTypeInstance.id}">${deviceTypeInstance.name}</g:link></td>
                            <td>${deviceTypeInstance.description}</td>
                            <td><a href="${createLink (action:'delete')}/${deviceTypeInstance.id}"  onClick="return confirm('Gerät: [${deviceTypeInstance.name}] löschen ?');"><span style="font-size:16pt;" class="mdi mdi-trash-can-outline" aria-hidden="true"></span></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
