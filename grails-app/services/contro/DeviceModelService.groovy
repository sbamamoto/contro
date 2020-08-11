package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class DeviceModelService {

    @Transactional
    def saveDevice(GrailsParameterMap props) {
        Device device
        println ("***********************************")
        println (props)
        println ("***********************************")
        if (props.id){
            device = Device.get(props.id)
        }
        else {
            device = new Device()
        }
        device.timings?.clear()
        device.properties = props
        device.save(flush:true,failOnError:true)
        
        return device
    }

    @Transactional
    def setState(id, state) {
        Device device = Device.get(id)
        device.state = state
        device.save(flush:true,failOnError:true)
        return device
    }
}