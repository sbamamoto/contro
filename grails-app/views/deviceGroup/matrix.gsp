<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceGroup.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <g:each  var="deviceGroup" in='${deviceGroups}'>
                    <div class="col-sm-6">
                        <div class="card" style="margin-top:15px;">
                            <div class="card-body">
                                <h5 class="card-title">${deviceGroup.name}</h5>
                                <p class="card-text">${deviceGroup.description}</p>
                                <a href="${createLink(controller:'deviceGroup', action:'groupDevices', params:[id:deviceGroup.id])}" class="btn btn-primary">Geräte bearbeiten</a>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </body>
</html>