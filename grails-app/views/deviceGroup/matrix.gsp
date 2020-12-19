<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceGroup.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <g:each  var="deviceGroup" in='${deviceGroups}'>
                    <div class="col-12 col-xl-8">
                        <div class="card" style="margin-top:15px;">
                            <div class="card-body">
                                <span class="card-title cntr-card-title">${deviceGroup.name}</span>
                                <p class="card-text cntr-card-text">${deviceGroup.description}</p>
                                <a href="${createLink(controller:'deviceGroup', action:'groupDevices', params:[id:deviceGroup.id])}" class="btn btn-primary cntr-button">Geräte bearbeiten</a>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </body>
</html>