package contro

class DeviceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    
    def switchService
    def deviceModelService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [deviceInstanceList: Device.list().sort { it.description }, deviceInstanceTotal: Device.count()]
    }

    def create = {
        def controllers = Interface.list()
        def deviceInstance = new Device()
        deviceInstance.properties = params
        render (view:"edit", model: [deviceInstance: deviceInstance,allTimings: Timing.list().sort { it.timing }, controllers:controllers])
    }

    def save = {
        def deviceInstance = new Device(params)
        if (deviceInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])}"
            redirect(action: "show", id: deviceInstance.id)
        }
        else {
            render(view: "create", model: [deviceInstance: deviceInstance])
        }
    }

    def show = {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            redirect(action: "list")
        }
        else {
            [deviceInstance: deviceInstance]
        }
    }

    def edit = {
        def controllers = Interface.list()
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            redirect(action: "list")
        }
        else {
            def deviceTimings=[]
            deviceInstance.timings.each {
                deviceTimings.add(it.id)
            }
            return [deviceInstance: deviceInstance, allTimings: Timing.list().sort { it.timing }, deviceTimings:deviceTimings, controllers:controllers  ]
        }
    }

    def update = {
        def deviceInstance = Device.get(params.id)
        if (deviceInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deviceInstance.version > version) {
                    
                    deviceInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'device.label', default: 'Device')] as Object[], "Another user has updated this Device while you were editing")
                    render(view: "edit", model: [deviceInstance: deviceInstance])
                    return
                }
            }
            deviceInstance.properties = params
            if (!deviceInstance.hasErrors() && deviceInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])}"
                redirect(action: "show", id: deviceInstance.id)
            }
            else {
                render(view: "edit", model: [deviceInstance: deviceInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def deviceInstance = Device.get(params.id)
        if (deviceInstance) {
            try {
                
                def c = Room.createCriteria()
                def results = c.list {
                    devices{
                        eq('id', params.long("id"))
                    }
                }
                
                results.each{
                    it.removeFromDevices(deviceInstance)
                    it.save(flush:true, failOnError:true)
                }
                
                deviceInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
                flash.textClass="text-success"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
                flash.textClass="text-danger"
                redirect(action: "list", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            flash.textClass="text-danger"
            redirect(action: "list")
        }
    }
    
    def saveDevice = {
        def device = deviceModelService.saveDevice(params.device)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'device.label', default: 'Device'), device.description])}"
        flash.textClass="text-success"
        redirect action:"list"
    }  
    
    def programDevice = {
        switchService.device(params.id, "150")
        println ("OK")
    }
}
