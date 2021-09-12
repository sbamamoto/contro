
<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'remoteControl.label', default: 'RemoteControl')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
                $("li").removeClass("active");
                $("#remoteControls").addClass("active");
            });
        </script>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <h1>RemoteControlliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
            
                <table class="table table-striped" >
                    <thead>
                    <th class="cntr-table-text">
                        RemoteControl
                    </th>
                    <th class="cntr-table-text">
                        Schaltwert
                    </th>
                    <th class="cntr-table-text">
                        Aktion
                    </th>
                    </thead>
                    <tbody>
                        <g:each in="${remoteControlInstanceList}" status="i" var="remoteControlInstance">
                            <tr>
                                <td class="cntr-table-text"><g:link action="edit" id="${remoteControlInstance.id}">${fieldValue(bean: remoteControlInstance, field: "identity")}</g:link></td>
                                <td class="cntr-table-text">${remoteControlInstance.value}</td>
                                <td><a href="${createLink (action:'delete')}/${remoteControlInstance.id}"  onClick="return confirm('Raum: [${remoteControlInstance.identity}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            
            </div>
        </div>
    </body>
</html>
