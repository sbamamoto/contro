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
        def remoteId = params.remoteId
        println "Params für controlcontroller create: " + params
        render (view:"edit", model: [remoteControlInstance: remoteControlInstance, deviceList: Device.list().sort { it.description }, remoteId: remoteId])
    }

    def edit = {
        println (" HERE edit")
        println params
        println ("--------------")
        def remoteControlInstance = RemoteControl.get(params.rcid)
        if (!remoteControlInstance) {
            remoteControlInstance = new RemoteControl()
            remoteControlInstance.properties = params
            def remoteId = params.remoteId
            println "Params für controlcontroller edit: " + params
            [remoteControlInstance: remoteControlInstance, deviceList: Device.list().sort { it.description }, remoteId: remoteId]
        }
        else {
            return [remoteControlInstance: remoteControlInstance, deviceList:Device.list().sort { it.description }, remoteId:params.remoteId]
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
        println "save remote control", params
        if (params.id && params.id.length() > 0) {
            println "   -------------   [" + params.id + "] -------- "
            remoteControl = RemoteControl.get(params.id)
        }
        else {
            remoteControl = new RemoteControl();
        }
        remoteControl.properties = params

        remoteControlModelService.saveRemote(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'remoteControl.label', default: 'RemoteControl'), remoteControl.identity])}"
        flash.textClass="text-success"
        redirect (controller:'remote', action:'edit', params:[id:params.id])
    }
}
