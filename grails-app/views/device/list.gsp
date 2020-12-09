
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
        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-md-7">
                    <h1>Geräteliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"edit")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
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
                        <g:each in="${deviceInstanceList}" status="i" var="deviceInstance">
                            <tr>
                            
                                <td><g:link action="edit" id="${deviceInstance.id}">${deviceInstance.description}</g:link></td>
                                <td>${deviceInstance.timings.size()}</td>
                                <td>${deviceInstance.canDimm ? "Ja" : "Nein"}</td>

                                <td>${deviceInstance.state == "ON" ? "eingeschaltet" : "ausgeschaltet"}</td>
                                
                                <td>${deviceInstance.device}</td>
                                <td>${deviceInstance.channel}</td>
                                <td>${deviceInstance.controller}</td>
                                <td><a href="${createLink (action:'delete')}/${deviceInstance.id}"  onClick="return confirm('Gerät: [${deviceInstance.description}] löschen ?');"><span style="font-size:16pt;" class="mdi mdi-trash-can-outline" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
