package contro

class RemoteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def remoteModelService
    def remoteControlModelService
    def scriptExecutorService
    def deviceModelService
    def settingsModelService

    def index = {
        redirect(action: "list")
    }

    def switchDevice = {
        println "######################### switch"
        
        def remoteControls = RemoteControl.findAllByIdentity(params.id)
        remoteControls.each  { remoteControl ->
            Map map = [:]
            println "################ " + params.id
            if (remoteControl.switchMode == "TOGGLE") {
                if (remoteControl.device.state == "ON") {
                    map ['value'] = '0.0'
                }
                else {
                    map ['value'] = '1.0'
                }
            }
            else {
                map ['value'] = remoteControl.value
            }
            map ['address'] = remoteControl.device.device
            map ['sessionId'] = remoteControl.device.sessionId
            map ['channel'] = remoteControl.device.channel
            map ['url'] = remoteControl.device.controller.url
            Device dev = Device.get(remoteControl.device.id)
            deviceModelService.setState(dev, scriptExecutorService.runScript(remoteControl.ability.processor, map), map['value'])
        }
        println "Storing Key"
        settingsModelService.setValue("LastButtonPressed", params.id)
        render "OK"
    }

    def clearLastButton = {
        println 'Last button cleared'
        settingsModelService.setValue("LastButtonPressed", "NOK")
        render '{"result":"OK"}'
    }

    def getLastButtonPressed = {
        println "Last Button pressed"
        def button = Setting.findBySetting("LastButtonPressed")
        render '{"result":"'+button.value+'"}'
    }

    def list = {
        def list = Remote.list().sort{ it.name } 
        print list
        [remoteInstanceList: Remote.list().sort{ it.name } , remoteInstanceTotal: Remote.count()]
    } 

    def create = {
        def remoteInstance = new Remote()
        //remoteInstance.properties = params
        render (view:"edit", model: [remoteInstance: remoteInstance])
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

    def deleteRemoteControl = {
        def remote
        println params
        if (params.id) {
            remote = Remote.get(params.id)
        }
        def remoteControl
        if (params.remoteControlId) {
            remoteControl = RemoteControl.get(params.remoteControlId)
        }
        remoteModelService.deleteRemoteControl(remote,remoteControl)
    }

    def saveRemoteControl = {
        def remote
        println "save remote control *** "
        println params
        println " ------ "
        if (params.remoteId) {
            remote = Remote.get(params.remoteId)
        }
        else {
            remote = new Remote();
        }
        //        def remoteControl
        //        if (params.id) {
        //            remoteControl = remoteControl(params.id)
        //        }
        //        else {
        //            remoteControl = new RemotControl()
        //        }
        //        remoteControl.properties = params
        def remoteControl = remoteControlModelService.saveRemoteControl(params)
        remoteModelService.addRemoteControl(remote, remoteControl)
        redirect (action:"edit", params:["id":remote.id])
    }
}
