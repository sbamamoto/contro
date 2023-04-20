
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'Value.label', default: 'Value')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-12 col-xl-8">
                    <nav>
                        <ul class="pager">
                            <li class="previous cntr-text"><g:link controller='device', action="list"><span aria-hidden="true">&larr;</span> Geräteliste</g:link></li>
                            </ul>
                        </nav>
                        <h1>Werteliste (${device.description}) <button class="btn btn-primary" onclick="location.href='${createLink(action:"edit", params:[deviceId:device.id])}';">
                            <span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                            <g:if test="${flash.message}">
                        <div class="${flash.textClass}">${flash.message}</div>
                    </g:if>
                    <table class="table table-striped" width="100%">
                        <thead>
                            <tr>
                                <th class="cntr-table-text">Schlüssel</th>
                                <th class="cntr-table-text">Wert</th>
                                <th class="d-none d-lg-table-cell cntr-table-text">Kanal</th>
                                <th class="cntr-table-text">Hauptwert</th>
                                <th class="cntr-table-text">GUI Contrloller</th>
                                <th class="cntr-table-text">Defaultwert</th>
                                <th class="cntr-table-text">letzte Änderung</th>
                                <th class="cntr-table-text"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${values}" status="i" var="value">
                                <tr>
                                    <td class="cntr-table-text"><g:link action="edit" class="cntr-text" id="${value.key}" params='[channel:"${value.channel}", deviceId:"${device.id}"]'>${value.key}</g:link></td>
                                    <td class="cntr-table-text">${value.value}</td>
                                    <td class="d-none d-lg-table-cell cntr-table-text">${value.channel}</td>
                                    <td>${value.isMainValue}</td>
                                    <td>${value.guiControlType}</td>
                                    <td>${value.defaultValue}</td>
                                    <td>${value.lastChange}</td>
                                    <td><a href="${createLink (action:'delete',params:[id:value.id,deviceId:device.id])}"  onClick="return confirm('Wert: [${value.key}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></span></a></td>
                              </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
