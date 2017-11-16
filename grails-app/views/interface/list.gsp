
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'interface.label', default: 'Controller')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#devices").addClass("active");
            });
            
            function deleteDevice (device, id) {
                var result = confirm("Gerät: ["+interface+"] wirklich löschen ?");
                if (result) {
                    location.href = '${createLink(action:"delete", )}'
                }
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Controllerliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button></h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-8">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Controller</th>
                            <th>Steuerungs-URL</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${interfaceInstanceList}" status="i" var="interfaceInstance">
                        <tr>                        
                            <td><g:link action="edit" id="${interfaceInstance.id}">${interfaceInstance.description}</g:link></td>
                            <td>${interfaceInstance.url}</td>
                            <td><a href="${createLink (action:'delete')}/${interfaceInstance.id}"  onClick="return confirm('Gerät: [${interfaceInstance.description}] löschen ?');"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
