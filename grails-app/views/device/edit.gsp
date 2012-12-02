
<%@ page import="contro.Device" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'device.label', default: 'Device')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${deviceInstance}">
            <div class="errors">
                <g:renderErrors bean="${deviceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${deviceInstance?.id}" />
                <g:hiddenField name="version" value="${deviceInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="canDimm"><g:message code="device.canDimm.label" default="Can Dimm" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'canDimm', 'errors')}">
                                    <g:checkBox name="canDimm" value="${deviceInstance?.canDimm}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="device.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${deviceInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="timings"><g:message code="device.timings.label" default="Timings" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'timings', 'errors')}">
                                    <g:select name="timings" from="${contro.Timing.list()}" multiple="yes" optionKey="id" size="5" value="${deviceInstance?.timings}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="state"><g:message code="device.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'state', 'errors')}">
                                    <g:textField name="state" value="${deviceInstance?.state}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="device"><g:message code="device.device.label" default="Device" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'device', 'errors')}">
                                    <g:textField name="device" value="${deviceInstance?.device}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="dimm"><g:message code="device.dimm.label" default="Dimm" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: deviceInstance, field: 'dimm', 'errors')}">
                                    <g:textField name="dimm" value="${deviceInstance?.dimm}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
