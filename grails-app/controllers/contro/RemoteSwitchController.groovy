package contro

class RemoteSwitchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def remoteModelService

    def remoteSwitchDevices = {
        def remote = Remote.get(params.id)
        [remote:remote]
    }

    def list = {
        [remoteInstanceList: Remote.list().sort{ it.showOrder } , remoteInstanceTotal: Remote.count()]
    }

    def create = {
        def remoteInstance = new Remote()
        remoteInstance.properties = params
        
        render (view:"edit", model: [remoteInstance: remoteInstance, allDevices: Device.list().sort { it.description }])
    }

    def edit = {
        def remoteInstance = Remote.get(params.id)
        if (!remoteInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'remote.label', default: 'Remote'), params.id])}"
            redirect(action: "list")
        }
        else {
            def remoteControls = []
            remoteInstance.remoteControls.each{
                remoteControls.add(it.device)
            }
            return [remoteInstance: remoteInstance, allRemoteControls:Device.list(), associatedRemoteControls:remoteControls]
        }
    }

    def delete = {
        def remoteInstance = Remote.get(params.id)
        if (remoteInstance) {
            try {
                remoteModelService.deleteRemote(params)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'remote.label', default: 'Raum'), params.id])}"
                flash.textClass="text-success"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'remote.label', default: 'Raum'), params.id])}"
                flash.textClass="text-danger"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'remote.label', default: 'Raum'), params.id])}"
            flash.textClass="text-danger"
            redirect(action: "list")
        }
    }
    
    
    def saveRemote = {
        def remote
        if (params.id) {
            remote = Remote.get(params.id)
        }
        else {
            remote = new Remote();
        }
        remote.properties = params
        println params
        remoteModelService.saveRemote(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'remote.label', default: 'Raum '), remote.name])}"
        flash.textClass="text-success"
        redirect action:"list"
    }
}
