package contro

/**
*
*/

class DeviceController {

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'GET']

    def deviceModelService

    def index = {
        redirect(action: 'list', params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [deviceInstanceList: Device.list().sort { it.description }, deviceInstanceTotal: Device.count()]
    }

    def create = {
        def controllers = Interface.list()
        Device deviceInstance = new Device()
        deviceInstance.properties = params
        render (view:'edit', model: [deviceInstance: deviceInstance, allTimings: Timing.list().sort { it.timing }, controllers:controllers])
    }

    def save = {
        def deviceInstance = new Device(params)
        if (deviceInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])}"
            redirect(action: 'show', id: deviceInstance.id)
        }
        else {
            render(view: 'create', model: [deviceInstance: deviceInstance])
        }
    }

    def show = {
        def deviceInstance = Device.get(params.id)
        if (!deviceInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            redirect(action: 'list')
        }
        else {
            [deviceInstance: deviceInstance]
        }
    }

    def edit = {
        def controllers = Interface.list()
        def deviceTypes = DeviceType.list()
        def deviceInstance = Device.get(params.id)

        if (!deviceInstance) {
            deviceInstance = new Device()
        }

        def deviceTimings = []
        deviceInstance.timings.each {
            deviceTimings.add(it.id)
        }

        def deviceTypeAbilities = []
        deviceInstance.type?.abilities.each {
            deviceTypeAbilities.add(it)
        }

        def deviceAbilities = []
        deviceInstance.abilities?.each {
            deviceAbilities.add(it.id)
        }

        def abilities = []
        deviceInstance.abilities?.each {
            abilities.add(it)
        }

        println '########  '
        println deviceTypeAbilities
        println '####'
        println deviceTimings
        println '####'

//        def acceptableTimings = Timing.executeQuery('select timing from Timing timing where timing.ability in elements(:deviceTypeAbilities)',
        def acceptableTimings = Timing.executeQuery('select timing from Timing timing, Device device where device.id =:id and timing.ability in elements(device.type.abilities) order by timing.timing',
        [id:deviceInstance.id])
        
        def timings = []
        acceptableTimings.each {
            println (" ************** "+it)
            timings.add(it)
        }

        return [deviceInstance: deviceInstance, allTimings: timings,
            deviceTimings:deviceTimings, controllers:controllers,
            deviceTypes:deviceTypes, deviceTypeAbilities:deviceTypeAbilities, 
            deviceAbilities:deviceAbilities,
            abilities:abilities]

    }

    def update = {
        def deviceInstance = Device.get(params.id)
        if (deviceInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deviceInstance.version > version) {
                    deviceInstance.errors.rejectValue('version', 'default.optimistic.locking.failure', [message(code: 'device.label', default: 'Device')] as Object[], 'Another user has updated this Device while you were editing')
                    render(view: 'edit', model: [deviceInstance: deviceInstance])
                    return
                }
            }
            deviceInstance.properties = params
            if (!deviceInstance.hasErrors() && deviceInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'device.label', default: 'Device'), deviceInstance.id])}"
                redirect(action: 'show', id: deviceInstance.id)
            }
            else {
                render(view: 'edit', model: [deviceInstance: deviceInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            redirect(action: 'list')
        }
    }

    def delete = {
        Device deviceInstance = Device.get(params.id)
        if (deviceInstance) {
            try {
                deviceModelService.deleteDevice(deviceInstance)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
                flash.textClass = 'text-success'
                redirect(action: 'list')
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
                flash.textClass = 'text-danger'
                redirect(action: 'list', id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            flash.textClass = 'text-danger'
            redirect(action: 'list')
        }
    }

    def saveDevice = {
        println('saveDevice')
        if (!params.device.containsKey('canDimm')) {
            params.device.canDimm = false
        }
        if (!params.device.containsKey('hasBatteries')) {
            params.device.hasBatteries = false
        }
        Device device = deviceModelService.saveDevice(params.device)
        if (device) {
            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'device.label', default: 'Device'), device.description])}"
            flash.textClass = 'text-success'
            redirect action:'list'
        }
        else {
            flash.message = "${message(code: 'default.not.updated.message', args: [message(code: 'device.label', default: 'Device'), params.id])}"
            flash.textClass = 'text-danger'
            redirect(action: 'list', id: params.id)
        }
    }

    def abilities = {
        def abilities = Device.get(params.id)?.abilities
        println "+++++++++++++++++"+abilities
        String result = ""
        response.setContentType("application/json")
        if (!abilities) {
            println " ###################### no abilities"
            render '[]'
        } else {
            abilities.each {
                result = result + '{"'+it.name+'": "'+it.id+'"},'
            }
            result = result.substring(0, result.length() - 1);
            println "result:" + result
            render result 
        }

    }

}
