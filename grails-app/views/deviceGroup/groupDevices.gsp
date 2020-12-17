<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'deviceGroup.label', default: 'DeviceGroup')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <h1>Geräte der Gruppe: ${deviceGroup.name}</h1>
                <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
                <table class="table table-striped" width="100%">
                    <thead>
                        <tr>
                            <th>Gerät</th>
                            <th>Aktive Timings</th>
                            <th>ist dimmbar</th>
                            <th>Zustand</th>
                            <th>Adresse</th>
                            <th>Kanal</th>
                            <th>Controller</th>
                            <th>Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${devices}" status="i" var="deviceInstance">
                            <tr>                            
                                <td><g:link controller="device" action="edit" id="${deviceInstance.id}">${deviceInstance.description}</g:link></td>
                                <td>${deviceInstance.timings.size()}</td>
                                <td>${deviceInstance.canDimm ? "Ja" : "Nein"}</td>
                                <td>${deviceInstance.state == "ON" ? "eingeschaltet" : "ausgeschaltet"}</td>
                                <td>${deviceInstance.device}</td>
                                <td>${deviceInstance.channel}</td>
                                <td>${deviceInstance.controller}</td>
                                <td><a href="${createLink (action:'deleteFromGroup', params:[deviceId:deviceInstance.id, deviceGroupId:deviceGroup.id])}"  
                                onClick="return confirm('Gerät: [${deviceInstance.description}] löschen ?');"><span style="font-size:16pt;" class="mdi mdi-trash-can-outline" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>