package contro

/**
*
*/

import grails.converters.JSON

class DeviceController {

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'GET']

    def deviceModelService

    def index = {
        redirect(action: 'list', params: params)
    }

    def apigetdevices = {
        def devices = Device.list().sort {it.description}
        JSON.use('deep')
        render devices as JSON
    }

    def apilistdevices = {
        def devices = Device.list().sort {it.description}
        render devices as JSON
    }

    def apismalldevicelist = {
        def devices = Device.list().sort {it.description}
        [devices:devices]
    }


    def apigetemptydevice = {        
        Device dev = new Device();
        dev.description = "";
        dev.controller = new Interface()
        dev.type = new DeviceType()
        println "%%%%%%%%%%%%%%%% "+dev
        render dev as JSON
    }


    def apilistabilities = {
        def device = Device.get(params.id)
        println "xxxxxxxxxxxxxx "+params
        def abilities = []
        if (device != null) {
            abilities = device.abilities
        }
        render abilities as JSON
    }

    def apilisttimings = {
        def device = Device.get(params.id)
        println "list timings "+params
        def timings = []
        if (device != null) {
            timings = device.timings
        }
        render timings as JSON
    }

    def apiupdatetimedabilities = {
        println "update " + request.JSON['timedabilities']

        println "Device: "+request.JSON['device']
        // for (x in request.JSON['timedabilities']) {
        //     println("sjkasjkasdjkal")
        //     for (y in x) {
        //         println "xcvbnxcvbncmxbvxcn"
        //         println y.value.selected.ability.id
        //     }
        // }
        deviceModelService.saveTimedAbilities(request .JSON['device'], request.JSON['timedabilities'])
        render "OK"
    }

    def apiupdatedevice = {
        //println "update device "+request.JSON['device']
        println "------------------------------------------------------------------apiupdate-------------------------------------------------------------------"
        deviceModelService.saveJsonDevice(request.JSON['device'])
        render "OK"
    }

    def apigettimedabilities = {
        println "get timings "+params
        def deviceInstance = Device.get(params.id)      
        Map<Ability, Map<String, List<Timing>>> abilities = [:]
        
        if (deviceInstance != null) {
            //println("##### - "+deviceInstance.timedAbilities)
            //create an object that containes the ability timings possible and the selected timings

            for (ta in deviceInstance.timedAbilities.sort {tim ->tim.time}) {
                def timings = [:]
                timings['selected'] = ta.timings
                abilities[[name:ta.ability.name, id: ta.ability.id]] = timings
            }
            println("------------------ "+deviceInstance.type.abilities)
            for (ab in deviceInstance.type.abilities) {
                def options = Timing.findAllByAbility(ab, [sort:"timing"]) // retrieve all abilities available for given type
                if (abilities[[name:ab.name, id: ab.id]] != null) {
                    abilities[[name:ab.name, id: ab.id]]['options'] = options
                }
                else {
                    def timings = [:]
                    timings['options'] = options
                    abilities[[name:ab.name, id: ab.id]] = timings
                } 
            }
        }
        render abilities as JSON
    }

    def apideletedevice = {
        println "Device ID: "+params.id
        Device deviceInstance = Device.get(params.id)
        println "Device   : " + deviceInstance
        if (deviceInstance != null) {
            println "§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§_____§§§§§§§§§§§§§§§§§§§§§§§§"
            deviceModelService.deleteDevice(deviceInstance)
        }
        render "OK"
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
