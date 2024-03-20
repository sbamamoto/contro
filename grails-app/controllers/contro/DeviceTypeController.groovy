package contro

import grails.converters.JSON
import contro.Timing

class DeviceTypeController {

    def deviceTypeModelService;

    def index(Integer max) {
        redirect(action: 'list', params: params)
    }

    def apilisttypes = {
        def results = DeviceType.list().sort{ it.name }
        println results
        render results as JSON
    }

    def apitypeabilities = {
        def type = DeviceType.get(params.id)
        def result = [:]
        println(" ##### " + params.id)
        for (ability in type.abilities) {
            def timings = Timing.findAllByAbility(ability)
            result[ability.id] =  [ability: ability, timings:timings]
        }

        render result as JSON
    }

    def apigettype = {
        def type = DeviceType.get(params.id)
        render type as JSON
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        println '++++++++++++++++++++++++++'
        [deviceTypeInstanceList: DeviceType.list().sort { it.description }]
    }

    def saveDeviceType = {
        println ("++++++++++++ ")
        println params
        println ("++++++++++++ ")
        DeviceType deviceType = deviceTypeModelService.saveDeviceType(params.deviceTypeForm)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deviceType.label', default: 'DeviceType'), deviceType.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def execute = {
        GroovyShell shell = new GroovyShell(this.class.classLoader)
        println params
        DeviceType deviceType = DeviceType.get(params.id)
        println deviceType.processingScript
        shell.evaluate(deviceType.processingScript)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deviceType.label', default: 'DeviceType'), deviceType.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def create = {
        DeviceType deviceTypeInstance = new DeviceType()
        deviceTypeInstance.properties = params
        def abilityList = Ability.list().sort { it.name }
        render (view:'edit', model: [deviceTypeInstance: deviceTypeInstance, abilityList:abilityList])
    }

    def edit = {
        DeviceType deviceTypeInstance = DeviceType.get(params.id)
        def abilityList = Ability.list().sort { it.name }
        def deviceTypeAbilities = []
        deviceTypeInstance.abilities.each {
            deviceTypeAbilities.add(it.id)
        }
        println '************** '+deviceTypeInstance.guiController
        return [deviceTypeInstance: deviceTypeInstance, abilityList:abilityList, deviceTypeAbilities:deviceTypeAbilities]
    }

}
