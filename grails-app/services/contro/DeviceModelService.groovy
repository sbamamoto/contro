package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import grails.orm.HibernateCriteriaBuilder

@Transactional
class DeviceModelService {

    @Transactional
    Device saveDevice(GrailsParameterMap props) {
        Device device
        println ('# this [' + props.device + '] - [' + props.sessionId + '] is already known to the system. Updating device data.')
        if (props.id) {
            device = Device.get(props.id)
            device.abilities?.clear()
        }
        else {
            // check if device with identically controller,address,channel already exists.
            def devices = Device.findAllByDevice (props.device)

            if (devices != null && devices.size() > 0) {
                
                devices.each {
                    
                    it.sessionId = props.sessionId
                    it.save(flush:true, failOnError:true)
                }
                return null
            }
            else {
                println (' +++ Adding device to Contro devices +++' )
                println (props)
                println (' +++++++++++++++++++++++++++++++++++++++')
            }
            device = new Device()
        }

        device.properties = props
        device.save(flush:true, failOnError:true)
        println '++++++++++++'
        println device.abilities
        return device
    }

    @Transactional
    Device setState(Long id, String state) {
        Device device = Device.get(id)
        device.state = state
        device.save(flush:true, failOnError:true)
        return device
    }

    @Transactional
    void deleteDevice (Device dev) {
        HibernateCriteriaBuilder c = Room.createCriteria()
        List<Room> results = c.list {
            devices {
                eq('id', dev.id)
            }
        }
        results.each {
            it.removeFromDevices(deviceInstance)
            it.save(flush:true, failOnError:true)
        }
        dev.delete(flush: true)
    }

}
