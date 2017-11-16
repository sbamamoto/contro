
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'interface.label', default: 'Interface')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="container">
            <div class="col-md-4">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Controllerliste</g:link></li>
                        </ul>
                    </nav>
                <g:form action="saveInterface">
                    <div class="form-group">
                        <label for="description">Beschreibung:</label>
                        <input type="text" class="form-control" name="interfacex.description" id="description" placeHolder="Description" value="${interfaceInstance?.description}"/>
                    </div>
                    <div class="form-group">
                        <label for="description">Steuerungs URL:</label>
                        <input type="text" class="form-control" name="interfacex.url" id="description" placeHolder="URL der Steuerungssoftware" value="${interfaceInstance?.url}"/>
                    </div>
                    <br>
                    <g:hiddenField name="interfacex.id" value="${interfaceInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
        </div>
    </body>
</html>
