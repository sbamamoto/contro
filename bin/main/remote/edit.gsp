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
                        <g:select from="['SonOff,HomeMatic']" class="form-control" id="type" name="type" value="0">
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
        <div class="row justify-content-md-center">
            <div class="col-12 col-lg-12 col-xl-6">
                <div style="margin-top:30px;">
                    <h3 class="d-inline-block" style="margin-right:20px;">Gesteuerte Geräte</h3>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal" style="margin-bottom:10px;" data-rcid="-1">
                        <span class="fa fa-plus" aria-hidden="true">
                    </button>
                </div>
                <table class="table table-striped">
                    <thead>
                        <th>Code</th>
                        <th>Gerät</th>
                        <th>Abilitiy</th>
                        <th>Value</th>
                        <th>Aktion</th>
                    </thead>
                    <tbody>
                        <g:each in="${remoteInstance.remoteControls?.sort{it.identity}}" status="i" var="remoteControlInstance">
                            <tr>
                                <td><a href="#exmapleModal" data-toggle="modal" data-target="#exampleModal" data-rcid="${remoteControlInstance.id}">${remoteControlInstance?.identity}</a></td>
                                <td>${remoteControlInstance?.device.device}</td>
                                <td>${remoteControlInstance?.ability.name}</td>
                                <td>${remoteControlInstance?.switchMode}</td>
                                <td><a href="${createLink (controller: 'remote', action:'deleteRemoteControl', params:[id:remoteInstance.id, remoteControlId:remoteControlInstance.id])}"  onClick="return confirm('RemoteControl: [${remoteControlInstance.identity}] löschen ?');"><span class="mdi mdi-trash-can-outline iconic-button" aria-hidden="true"></span></span></a></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
             </div>
        </div>
        <div class="modal" id="exampleModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schalter hinzufügen</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" identity="editForm"></div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <script>
            $('#exampleModal').on('shown.bs.modal', function (e) {
                var rcid = $(e.relatedTarget).data('rcid');                
                $('.modal-body').load('${createLink(controller:"remoteControl", action:"edit", params:[remoteId:remoteInstance.id])}&rcid='+rcid,function(){
                    $('#exampleModal').modal({show:true});
                });
            })
        </script>
    </body>
</html>
