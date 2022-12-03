
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'setting.label', default: 'Setting')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>

    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-md-6">
                <h1>System Einstellungen <button class="btn btn-primary" onclick="location.href='${createLink(action:'edit')}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
                <table class="table table-striped" width="100%">
                    <thead>
                        <tr>
                            <th class="cntr-text">Schlüssel</th>
                            <th class="d-none d-xl-table-cell">Wert</th>
                            <th class="cntr-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${settings}" status="i" var="setting">
                            <tr>
                                <td><g:link action="edit" class="cntr-text" id="${setting.id}">${setting.setting}</g:link></td>
                                <td class="d-none d-lg-table-cell">${setting.value}</td>
                                <td><a href="${createLink (action:'delete')}/${setting.id}"  onClick="return confirm('Gerät: [${setting.setting}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                </div>
            </div>
        </div>        
    </body>

</html>