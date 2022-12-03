
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ability.label', default: 'Ability')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-8">
                <h1>Abilityscriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="cntr-table-text">Name</th>
                            <th class="cntr-table-text d-none d-xl-table-cell">Beschreibung</th>
                            <th class="cntr-table-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${abilityInstanceList}" status="i" var="abilityInstance">
                        <tr>                        
                            <td class="cntr-table-text"><g:link action="edit" id="${abilityInstance.id}">${abilityInstance.name}</g:link></td>
                            <td class="cntr-table-text d-none d-xl-table-cell">${abilityInstance.description}</td>
                            <td class="cntr-table-text"><a href="${createLink (action:'delete')}/${abilityInstance.id}"  onClick="return confirm('Gerät: [${abilityInstance.name}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
