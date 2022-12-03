
<%@ page import="contro.RemoteControl" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'remoteControl.label', default: 'RemoteControl')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
            $("li").removeClass("active");
            $("#remotes").addClass("active");
            });
        </script>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <h1>Remoteliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
            
                <table class="table table-striped" >
                    <thead>
                        <th class="cntr-table-text">
                            RemoteControl
                        </th>
                        <th class="cntr-table-text">
                            Description
                        </th>
                    </thead>
                    <tbody>
                        <g:each in="${remoteInstanceList}" status="i" var="remoteInstance">
                            <tr>${remoteInstance.name}
                                <td class="cntr-table-text"><g:link action="edit" id="${remoteInstance.id}">${fieldValue(bean: remoteInstance, field: "name")}</g:link></td>
                                <td class="cntr-table-text">${remoteInstance.description}</td>
                                <td><a href="${createLink (action:'delete')}/${remoteInstance.id}"  onClick="return confirm('RemoteControl: [${remoteInstance.name}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            
            </div>
        </div>
    </body>
</html>
