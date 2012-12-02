
<%@ page import="contro.Timing" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'timing.label', default: 'Timing')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${timingInstance}">
            <div class="errors">
                <g:renderErrors bean="${timingInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="power"><g:message code="timing.power.label" default="Power" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'power', 'errors')}">
                                    <g:checkBox name="power" value="${timingInstance?.power}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ramp"><g:message code="timing.ramp.label" default="Ramp" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'ramp', 'errors')}">
                                    <g:checkBox name="ramp" value="${timingInstance?.ramp}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="timing"><g:message code="timing.timing.label" default="Timing" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'timing', 'errors')}">
                                    <g:textField name="timing" value="${timingInstance?.timing}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dimmValue"><g:message code="timing.dimmValue.label" default="Dimm Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'dimmValue', 'errors')}">
                                    <g:textField name="dimmValue" value="${timingInstance?.dimmValue}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="timing.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${timingInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="monday"><g:message code="timing.monday.label" default="Monday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'monday', 'errors')}">
                                    <g:checkBox name="monday" value="${timingInstance?.monday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tuesday"><g:message code="timing.tuesday.label" default="Tuesday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'tuesday', 'errors')}">
                                    <g:checkBox name="tuesday" value="${timingInstance?.tuesday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="wednesday"><g:message code="timing.wednesday.label" default="Wednesday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'wednesday', 'errors')}">
                                    <g:checkBox name="wednesday" value="${timingInstance?.wednesday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="thursday"><g:message code="timing.thursday.label" default="Thursday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'thursday', 'errors')}">
                                    <g:checkBox name="thursday" value="${timingInstance?.thursday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="friday"><g:message code="timing.friday.label" default="Friday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'friday', 'errors')}">
                                    <g:checkBox name="friday" value="${timingInstance?.friday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="saturday"><g:message code="timing.saturday.label" default="Saturday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'saturday', 'errors')}">
                                    <g:checkBox name="saturday" value="${timingInstance?.saturday}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sunday"><g:message code="timing.sunday.label" default="Sunday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: timingInstance, field: 'sunday', 'errors')}">
                                    <g:checkBox name="sunday" value="${timingInstance?.sunday}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
