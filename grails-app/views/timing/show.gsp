
<%@ page import="contro.Timing" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'timing.label', default: 'Timing')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: timingInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.power.label" default="Power" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.power}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.ramp.label" default="Ramp" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.ramp}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.timing.label" default="Timing" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: timingInstance, field: "timing")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.dimmValue.label" default="Dimm Value" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: timingInstance, field: "dimmValue")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: timingInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.monday.label" default="Monday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.monday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.tuesday.label" default="Tuesday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.tuesday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.wednesday.label" default="Wednesday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.wednesday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.thursday.label" default="Thursday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.thursday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.friday.label" default="Friday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.friday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.saturday.label" default="Saturday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.saturday}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="timing.sunday.label" default="Sunday" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${timingInstance?.sunday}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${timingInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
