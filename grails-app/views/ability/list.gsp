
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ability.label', default: 'Ability')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <h1>Abilityscriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
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
                    <g:each in="${abilityInstanceList}" status="i" var="abilityInstance">
                        <tr>                        
                            <td><g:link action="edit" id="${abilityInstance.id}">${abilityInstance.name}</g:link></td>
                            <td>${abilityInstance.description}</td>
                            <td><a href="${createLink (action:'delete')}/${abilityInstance.id}"  onClick="return confirm('Gerät: [${abilityInstance.name}] löschen ?');"><span style="font-size:16pt;" class="mdi mdi-trash-can-outline" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
