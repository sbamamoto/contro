
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'setting.label', default: 'Setting')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-md-6">
                    <nav>
                        <ul class="pager">
                            <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span>System Settings</g:link></li>
                        </ul>
                    </nav>
                    <g:form action="saveAbility" onSubmit="storeProcessingscript();">
                        <g:each in="${settings}">
                        <div class="form-group">
                            <label for="name">${it.setting}:</label>
                            <input type="text" class="form-control" name="settingsform.${it.setting}" id="${it.setting}" placeHolder="Value" value="${it.value}"/>
                        </div>
                        </g:each>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </g:form>    
                </div>
            </div>
        </div>        
    </body>

</html>
