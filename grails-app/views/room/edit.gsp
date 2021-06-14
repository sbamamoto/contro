

<%@ page import="contro.Room" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'room.label', default: 'Room')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <form action="${createLink(action:'save', controller:'roomImage')}" id="fileform" name="fileform" class="form-inline my-2 my-lg-0"
              method="POST" enctype='multipart/form-data'>
            <div style="margin-right: 10px;">
              <label class="file-upload btn btn-primary">
                Import <input type="file" id="roomImage" name="roomImage" hidden onchange='document.getElementById("fileform").submit();'/>
              </label>
            </div>
            <input type="hidden" name="roomId" value="${roomInstance.id}"/>
         </form>
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <nav>
                    <ul class="pager">
                        <li class="previous"><g:link action="list"><span aria-hidden="true">&larr;</span> Raumliste</g:link></li>
                        </ul>
                    </nav>
                <g:form action="saveRoom">
                    <div class="form-group">
                        <label for="roomName">Room:</label>
                        <input type="text" class="form-control" name="name" id="name" placeHolder="Room Name" value="${roomInstance.name}"/>
                    </div>
                    <div class="form-group">
                        <label for="showOrder">Order number:</label>
                        <input type="text" class="form-control" name="showOrder" id="showOrder" placeHolder="Room Name" value="${roomInstance.showOrder}"/>
                    </div>                    
                    <div class="form-group">
                        <label for="roomImage">Image:</label>
                        <input type="text" class="form-control" name="image" id="image" placeHolder="Room Image" value="${roomInstance.image}"/>
                    </div>
                    <g:each in="${allDevices}">
                        <div class="checkbox cntr-text">
                            <label class="cntr-text">
                                <input type="checkbox" value="${it.id}" name="devices" ${associatedDevices?.contains(it.device)?"checked":""}/>
                                ${it.description}
                            </label>
                        </div>
                    </g:each>
                    <g:hiddenField name="id" value="${roomInstance?.id}" />
                    <button type="submit" class="btn btn-primary">Save</button>
                </g:form>    
            </div>

        </div>
    </body>
</html>
