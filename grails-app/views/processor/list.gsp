
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'processor.label', default: 'Processor')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">           
                <div class="col-12 col-xl-8">
                    <h1>Processorscriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
                    <g:if test="${flash.message}">
                        <div class="${flash.textClass}">${flash.message}</div>
                    </g:if>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th class="cntr-table-text">Name</th>
                                <th class="d-none d-lg-table-cell">Beschreibung</th>
                                <th class="d-none d-lg-table-cell">Typ</th>
                                <th>Aktion</th>
                            </tr>
                        </thead>
                        <tbody>
                        <g:each in="${processorInstanceList}" status="i" var="processorInstance">
                            <tr>                        
                                <td><g:link  class="cntr-text"action="edit" id="${processorInstance.id}">${processorInstance.name}</g:link></td>
                                <td class="d-none d-lg-table-cell"><span class="cntr-text">${processorInstance.description}</span></td>
                                <td class="d-none d-lg-table-cell">${processorInstance.type}</td>
                                <td><a href="#exampleModalCenter" data-toggle="modal" data-target="#exampleModalCenter" onClick="runScript(${processorInstance.id})"><span class="mdi mdi-play iconic-button" aria-hidden="true"></span></a>
                                <a href="${createLink (action:'delete')}/${processorInstance.id}"  onClick="return confirm('Gerät: [${processorInstance.name}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Script Output</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="scriptOutput" name="scriptOutput">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function runScript (processorId) {
                $( "#scriptOutput" ).load( "${createLink (action:'execute')}/"+processorId );
            }
        </script
    </body>
</html>
