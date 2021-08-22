<%@ page import="contro.RemoteControl" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'remote.label', default: 'RemoteControl')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span>RemoteControlliste</g:link></li>
                    </ul>
                </nav>
                <g:form action="saveRemote">
                    <div class="form-group">
                        <label for="type">Type:</label>
                        <g:select from="['SonOff']" class="form-control" id="type" name="type" value="0">
                        </g:select>
                    </div>
                    <div class="form-group">
                        <label for="remoteName">RemoteControl:</label>
                        <input type="text" class="form-control" name="name" id="name" placeHolder="RemoteControl Name" value="${remoteInstance?.name}"/>
                    </div>
                    <div class="form-group">
                        <label for="remoteDescription">Image:</label>
                        <input type="text" class="form-control" name="description" id="description" placeHolder="RemoteControl Description" value="${remoteInstance?.description}"/>
                    </div>
                    <g:hiddenField name="id" value="${remoteInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>

        </div>
    </body>
</html>
