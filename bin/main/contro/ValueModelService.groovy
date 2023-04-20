package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class ValueModelService {


    @Transactional
    Value updateValue(String channel, String key, String value) {
        Value deviceValue = Value.findByChannelAndKey(channel, key)

        if (!deviceValue) {
            deviceValue = new Value(key:key, channel:channel)
        }
        //        
        //        String[] data = channel.split(":")
        //        deviceVale
        //        if (data.length > 1) {
        //            deviceValue.channel = data[1]
        //        }
        deviceValue.lastChange = new Date();
        deviceValue.value = value
        deviceValue.save(flush:true, failOnError:true)

        return deviceValue
    }

    @Transactional
    def saveValue(GrailsParameterMap params) {
        Value value
        Device device=Device.get(params.deviceId)
        
        if (params.id) {
            value = Value.get(params.id)
        }
        else {
            value = new Value();
            value.isAutomatic=false
            value.channel=device.device+device.channel
            params.remove("channel")
        }
        
        value.properties = params
        
        if (params["isEditable"]==null) {
            value.isEditable=false
        }
        
        if (params["isMainValue"]==null) {
            value.isMainValue=false
        }

        //  return value.save(flush: true, failOnError:true)
        
        device.addToValues(value)
        device.save(flush: true, failOnError:true)
        return value
    }
        
    @Transactional
    def deleteValue (valueId, deviceId) {
        Value value = Value.get(valueId)
        Device device = Device.get(deviceId)
        device.removeFromValues(value)
        device.save(flush: true, failOnError:true)
        value.delete(flush: true, failOnError:true)
    }

}
