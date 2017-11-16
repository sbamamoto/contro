<%@ page import="contro.Interface" %>



<div class="fieldcontain ${hasErrors(bean: interfaceInstance, field: 'url', 'error')} required">
	<label for="url">
		<g:message code="interface.url.label" default="Url" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="url" required="" value="${interfaceInstance?.url}"/>

</div>

