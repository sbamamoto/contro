
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'processor.label', default: 'Processor')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <h1>Processorscriptliste <button class="btn btn-primary" onclick="location.href='${createLink(action:"create")}';"><span class="fa fa-plus" aria-hidden="true"></span></button></h1>
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
                    <g:each in="${processorInstanceList}" status="i" var="processorInstance">
                        <tr>                        
                            <td><g:link action="edit" id="${processorInstance.id}">${processorInstance.name}</g:link></td>
                            <td>${processorInstance.description}</td>
                            <td><a href="#exampleModalCenter" data-toggle="modal" data-target="#exampleModalCenter" onClick="runScript(${processorInstance.id})"><span style="font-size:16pt;" class="mdi mdi-play" aria-hidden="true"></span></a></td>
                            <td><a href="${createLink (action:'delete')}/${processorInstance.id}"  onClick="return confirm('Gerät: [${processorInstance.name}] löschen ?');"><span style="font-size:16pt;" class="mdi mdi-trash-can-outline" aria-hidden="true"></span></a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
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
