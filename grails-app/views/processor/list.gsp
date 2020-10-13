
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'processor.label', default: 'Processor')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <h1>Processorscriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
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
                    <g:each in="${processorInstanceList}" status="i" var="processorInstance">
                        <tr>                        
                            <td><g:link action="edit" id="${processorInstance.id}">${processorInstance.name}</g:link></td>
                            <td>${processorInstance.description}</td>
                            <td><a href="${createLink (action:'execute')}/${processorInstance.id}"  onClick="return confirm('Processor: [${processorInstance.name}] ausführen ?');"><span class="fa fa-play" aria-hidden="true"></span></a></td>
                            <td><a href="${createLink (action:'delete')}/${processorInstance.id}"  onClick="return confirm('Gerät: [${processorInstance.name}] löschen ?');"><span class="fa fa-trash" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
