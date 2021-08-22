package contro

class RemoteControlController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def remoteControlModelService

    def index = {
        [remotes: RemoteControl.list().sort{ it.showOrder } , remoteControlInstanceTotal: RemoteControl.count()]
    }

    def switchDevices = {
        def remoteControl = RemoteControl.get(params.id)
        [remoteControl:remoteControl]
    }

    def list = {
        [remoteControlInstanceList: RemoteControl.list(), remoteControlInstanceTotal: RemoteControl.count()]
    }

    def create = {
        def remoteControlInstance = new RemoteControl()
        remoteControlInstance.properties = params
        
        render (view:"edit", model: [remoteControlInstance: remoteControlInstance, allDevices: Device.list().sort { it.description }])
    }

    def edit = {
        def remoteControlInstance = RemoteControl.get(params.id)
        if (!remoteControlInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'remote.label', default: 'Remote'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [remoteControlInstance: remoteControlInstance, deviceList:Device.list()]
        }
    }

    def delete = {
        def remoteControlInstance = RemoteControl.get(params.id)
        if (remoteControlInstance) {
            try {
                remoteControlModelService.deleteRemote(params)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'remoteControl.label', default: 'RemoteControl'), params.id])}"
                flash.textClass="text-success"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'remoteControl.label', default: 'RemoteControl'), params.id])}"
                flash.textClass="text-danger"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'remoteControl.label', default: 'RemoteControl'), params.id])}"
            flash.textClass="text-danger"
            redirect(action: "list")
        }
    }
    
    
    def saveRemoteControl = {
        def remoteControl
        if (params.id) {
            remoteControl = RemoteControl.get(params.id)
        }
        else {
            remoteControl = new RemoteControl();
        }
        remoteControl.properties = params
        println params
        remoteControlModelService.saveRemote(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'remoteControl.label', default: 'RemoteControl'), remoteControl.identity])}"
        flash.textClass="text-success"
        redirect action:"list"
    }
}
