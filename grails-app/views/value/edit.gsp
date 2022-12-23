<%@ page import="contro.Value" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'value.label', default: 'Key Value Pairs')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="container">
            <div class="col-md-4">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="index" params="${[id:device.id]}"><span aria-hidden="true">&larr;</span> Values</g:link></li>
                        </ul>
                    </nav>
                <g:form action="save">
                    <div class="form-group">
                        <label for="key">Key:</label>
                        <input type="text" class="form-control" name="key" id="key" ${valueInstance.key==null||!valueInstance.isAutomatic?"":"readonly"} value="${valueInstance.key}"/>
                    </div>
                    <div class="form-group">
                        <label for="value">Value:</label>
                        <input type="text" class="form-control" name="value" id="value"  ${valueInstance.value ==null||!valueInstance.isAutomatic?"":"readonly"} value="${valueInstance.value}"/>
                    </div>
                    <div class="form-group">
                        <label for="value">GUI Control:</label>
                        <input type="text" class="form-control" name="guiControlType" id="guiControlType" placeholder="SWITCH or SLIDER or LABEL" value="${valueInstance.guiControlType}"/>
                    </div>
                    <div class="form-group">
                        <label for="value">Default:</label>
                        <input type="text" class="form-control" name="defaultValue" id="defaultValue" value="${valueInstance.defaultValue}"/>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="true" name="isEditable" ${valueInstance.isEditable?"checked":""}/>
                            Beschreibbar
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="true" name="isMainValue" ${valueInstance.isMainValue?"checked":""}/>
                            Hauptwert
                        </label>
                    </div>
                    <g:hiddenField name="id" value="${valueInstance?.id}" />
                    <g:hiddenField name="deviceId" value="${device.id}" />
                    <g:hiddenField name="channel" value="${valueInstance.channel}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>

        </div>
    </body>
</html>
