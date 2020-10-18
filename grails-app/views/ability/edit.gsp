
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'ability.label', default: 'Ability')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
            <div class="col-md-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Abilityscriptliste</g:link></li>
                    </ul>
                </nav>
                <g:form action="saveAbility" onSubmit="storeProcessingscript();">
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" name="abilityform.name" id="name" placeHolder="Name" value="${abilityInstance?.name}"/>
                    </div>
                    <div class="form-group">
                        <label for="readOnly">Read Only:</label>
                        <g:checkBox class="form-control" name="abilityform.readOnly" id="readOnly" value="${abilityInstance?.readOnly}"/>
                    </div>
                    <div class="form-group">
                        <label for="description">Beschreibung:</label>
                        <input type="text" class="form-control" name="abilityform.description" id="description" placeHolder="Beschreibung des Macros" value="${abilityInstance?.description}"/>
                    </div>
                    <div class="form-group">
                        <label for="processor">Processor:</label>
                        <g:select from="${processorList}" class="form-control" name="abilityform.processor" id="processor" optionKey="id" value="${abilityInstance?.processor}">
                        </g:select>
                    </div>                    
                    <br>
                    <g:hiddenField name="abilityform.id" value="${abilityInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>
            </div>
        </div>        
    </body>

</html>
