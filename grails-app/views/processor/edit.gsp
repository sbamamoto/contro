
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <script src="${resource(dir:'js',file:'src-noconflict/ace.js')}"></script>
        <script src="${resource(dir:'js',file:'src-noconflict/theme-twilight.js')}"></script>
        <script src="src/mode-javascript.js" type="text/groovy" charset="utf-8"></script>
        <g:set var="entityName" value="${message(code: 'processor.label', default: 'Processor')}" />

        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
            <div class="col-md-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Processorscriptliste</g:link></li>
                    </ul>
                </nav>
                <g:form action="saveProcessor" onSubmit="storeProcessingscript();">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" name="processorform.name" id="name" placeHolder="Name" value="${processorInstance?.name}"/>
                    </div>
                    <div class="form-group">
                        <label for="description">Beschreibung:</label>
                        <input type="text" class="form-control" name="processorform.description" id="description" placeHolder="Beschreibung des Macros" value="${processorInstance?.description}"/>
                    </div>
                    <div class="form-group">
                        <pre id="editor" class="form-control" style="height:500px">${processorInstance?.processingScript}</pre>
                    </div>
                    <br>
                    <g:hiddenField name="processorform.id" value="${processorInstance?.id}" />
                    <g:hiddenField name="processorform.processingScript" id='processingScript' value="${processorInstance?.processingScript}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
            </div>
        </div>        
            <script>
                var editor = ace.edit("editor");
                editor.setTheme("ace/theme/twilight");
                editor.session.setMode("ace/mode/groovy");

                function storeProcessingscript() {
                    text = editor.getSession().getValue();
                    document.getElementById('processingScript').value = text;
                }
            </script>
    </body>

</html>
