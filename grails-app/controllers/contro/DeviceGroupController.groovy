package contro

class DeviceGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def deviceGroupModelService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {

        [deviceGroupInstanceList: DeviceGroup.list().sort{ it.name } , deviceGroupInstanceTotal: Room.count()]

    }

    def create = {
        def deviceGroupInstance = new DeviceGroup()
        deviceGroupInstance.properties = params

        render (view:"edit", model: [deviceGroupInstance: deviceGroupInstance, allDevices: Device.list().sort { it.description }])
    }

    def edit = {
        def deviceGroupInstance = DeviceGroup.get(params.id)
        if (!deviceGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deviceGroup.label', default: 'Room'), params.id])}"
            redirect(action: "list")
        }
        else {
            def deviceGroupDevices = []
            deviceGroupInstance.devices.each{
                deviceGroupDevices.add(it.device)
            }
            return [deviceGroupInstance: deviceGroupInstance, allDevices:Device.list(), associatedDevices:deviceGroupDevices]
        }
    }

    def delete = {
        def deviceGroupInstance = DeviceGroup.get(params.id)
        if (deviceGroupInstance) {
            try {
                deviceGroupModelService.deleteDeviceGroup(params)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'deviceGroup.label', default: 'DeviceGroup'), params.id])}"
                flash.textClass="text-success"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'deviceGroup.label', default: 'DeviceGroup'), params.id])}"
                flash.textClass="text-danger"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deviceGroup.label', default: 'DeviceGroup'), params.id])}"
            flash.textClass="text-danger"
            redirect(action: "list")
        }
    }
    
    
    def saveDeviceGroup = {
        def deviceGroup
        if (params.id) {
            deviceGroup = DeviceGroup.get(params.id)
        }
        else {
            deviceGroup = new DeviceGroup();
        }
        deviceGroup.devices?.clear()
        deviceGroup.properties = params
        println params
        deviceGroupModelService.saveDeviceGroup(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'deviceGroup.label', default: 'Raum '), deviceGroup.name])}"
        flash.textClass="text-success"
        redirect action:"list"
    }

    def matrix = {
        return [deviceGroups:DeviceGroup.list()]
    }

    def deleteFromGroup = {
        deviceGroupModelService.removeDeviceFromGroup(params.deviceGroupId, params.deviceId)
        forward action:'groupDevices', params:[id:params.deviceGroupId]
    }

    def groupDevices = {
        def deviceGroup = DeviceGroup.get(params.id)
        def devices = deviceGroup.devices
        println params.id
        println devices
        return [devices:devices, deviceGroup:deviceGroup]
    }
}