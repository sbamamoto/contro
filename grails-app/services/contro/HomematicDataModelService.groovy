package contro

import grails.gorm.transactions.Transactional

@Transactional
class HomematicDataModelService {

    def updateData(updateTupel) {
        String deviceCode = updateTupel['address'].split(':')[0]
        String chan = updateTupel['address'].split(':')[1]
        Device device = Device.findByDevice(deviceCode)
        if (device) {
            def list = device.values.find { value -> value.channel ==  chan && value.key == updateTupel['key'] }
            println '-----------------------------------------------'
            println ' ############### ---- ' + list
            
        }
        Value val = new Value(channel:':' + updateTupel['address'].split(':')[1], key:updateTupel['key'], value:updateTupel['value'])
        println ' ---- ' + val
        device.addToValues(val)
        device.save(flush:true, failOnError:true)
    }

}
