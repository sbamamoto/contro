package contro

class DeviceTypeController {

    def deviceTypeModelService;

    def index(Integer max) {
        redirect(action: 'list', params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        println '++++++++++++++++++++++++++'
        [deviceTypeInstanceList: DeviceType.list().sort { it.description }]
    }

    def saveDeviceType = {
        println params
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
        println '************** '+deviceTypeAbilities
        return [deviceTypeInstance: deviceTypeInstance, abilityList:abilityList, deviceTypeAbilities:deviceTypeAbilities]
    }

}
