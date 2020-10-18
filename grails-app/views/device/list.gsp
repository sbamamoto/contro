
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
        <div class="container">
            <h1>Geräteliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"edit")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
            <g:if test="${flash.message}">
                <div class="${flash.textClass}">${flash.message}</div>
            </g:if>
            <div class="col-md-8">
                <table class="table table-striped">
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
                            <td>${deviceInstance.timedAbilities.size()}</td>
                            <td>${deviceInstance.canDimm ? "Ja" : "Nein"}</td>

                            <td>${deviceInstance.state == "ON" ? "eingeschaltet" : "ausgeschaltet"}</td>
                            
                            <td>${deviceInstance.device}</td>
                            <td>${deviceInstance.channel}</td>
                            <td>${deviceInstance.controller}</td>
                            <td><a href="${createLink (action:'delete')}/${deviceInstance.id}"  onClick="return confirm('Gerät: [${deviceInstance.description}] löschen ?');"><span class="fa fa-trash" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
