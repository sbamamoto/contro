package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class DeviceTypeModelService {

    @Transactional
    def saveDeviceType(GrailsParameterMap props) {
        DeviceType swDeviceType
        println ('***********************************')
        println (props)
        println ('***********************************')
        if (props.id) {
            swDeviceType = DeviceType.get(props.id)
        }
        else {
            swDeviceType = new DeviceType()
        }

        swDeviceType.abilities?.clear()
        swDeviceType.properties = props
        swDeviceType.save(flush:true, failOnError:true)

        return swDeviceType
    }

}
