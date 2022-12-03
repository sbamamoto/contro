package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class DeviceGroupModelService {

    @Transactional
    def saveDeviceGroup(GrailsParameterMap params) {
        DeviceGroup deviceGroup
        if (params.id){
            deviceGroup = DeviceGroup.get(params.id)
        }
        else {
            deviceGroup = new DeviceGroup()
        }
        deviceGroup.properties = params
        return deviceGroup.save(flush: true, failOnError:true)
    }

    @Transactional
    def deleteDeviceGroup(GrailsParameterMap params) {
        DeviceGroup deviceGroup
        if (params.id){
            deviceGroup = DeviceGroup.get(params.id)
            deviceGroup.delete(flush: true, failOnError:true)
        }
    }

    def removeDeviceFromGroup(String deviceGroupId, String deviceId) {
        def group = DeviceGroup.get(deviceGroupId)

        group.removeFromDevices(Device.get(deviceId))
        group.save(flush:true, failOnError:true)
    }
}