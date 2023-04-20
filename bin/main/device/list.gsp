
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $( document ).ready(function() {
                $("li").removeClass("active");
                $("#devices").addClass("active");
            });

            function deleteDevice (device, id) {
                var result = confirm("Gerät: ["+device+"] wirklich löschen ?");
                if (result) {
                        location.href = '${createLink(action:"delete", )}'
                }
            }            
        </script>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-10">
                <h1>Geräteliste <button class="btn btn-primary" onclick="location.href='${createLink(action:'edit')}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                        <g:if test="${flash.message}">
                    <div class="${flash.textClass}">${flash.message}</div>
                </g:if>
                <table class="table table-striped" width="100%">
                    <thead>
                        <tr>
                            <th class="cntr-text">Gerät</th>
                            <th class="d-none d-lg-table-cell">Aktive Timings</th>
                            <th class="d-none d-lg-table-cell">ist dimmbar</th>
                            <th class="d-none d-lg-table-cell">Batterie</th>
                            <th class="d-none d-lg-table-cell">Zustand</th>
                            <th class="d-none d-xl-table-cell">Adresse</th>
                            <th class="d-none d-xl-table-cell">Kanal</th>
                            <th class="d-none d-xl-table-cell">Controller</th>
                            <th class="d-none d-xl-table-cell">Session ID</th>
                            <th class="cntr-text">Aktion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${deviceInstanceList}" status="i" var="deviceInstance">
                            <tr>

                                <td><g:link action="edit" class="cntr-text" id="${deviceInstance.id}">${deviceInstance.description}</g:link></td>
                                <td class="d-none d-lg-table-cell">${deviceInstance.timings.size()}</td>
                                <td class="d-none d-lg-table-cell">${deviceInstance.canDimm ? "Ja" : "Nein"}</td>
                                <td class="d-none d-lg-table-cell">
                                    <g:if test="${deviceInstance.hasBatteries}">
                                        <span class="mdi mdi-battery iconic-button"></span>
                                    </g:if>
                                    <g:else>
                                        <i>N/A</i>
                                    </g:else>
                                <td class="d-none d-lg-table-cell">${deviceInstance.state == "ON" ? "AN" : "AUS"}</td>

                                <td class="d-none d-xl-table-cell">${deviceInstance.device.length() < 30 ? deviceInstance.device : deviceInstance.device[0..29]+" ..."}</td>
                                <td class="d-none d-xl-table-cell">${deviceInstance.channel}</td>
                                <td class="d-none d-xl-table-cell">${deviceInstance.controller}</td>
                                <td class="d-none d-xl-table-cell">${deviceInstance.sessionId}</td>

                                <td style="white-space:nowrap;"><a href="${createLink (controller:'value', action:'index')}/${deviceInstance.id}"><span class="mdi mdi-format-list-bulleted-square iconic-button" aria-hidden="true"></span></a>
                                    <a href="${createLink (action:'delete')}/${deviceInstance.id}"  onClick="return confirm('Gerät: [${deviceInstance.description}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
