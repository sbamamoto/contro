package contro

import grails.gorm.transactions.Transactional

@Transactional
class HomematicDataModelService {

    def updateData(updateTupel) {
        String deviceCode = updateTupel['address'].split(':')[0]
        Device device = Device.findByDevice(deviceCode)
        println '*********** vchan= [' + updateTupel['address'] + ']  ********  vkey==[' + updateTupel['key'] + ']'
        if (device) {
            def value = device.values.find { value -> value.channel ==  updateTupel['address'] && value.key == updateTupel['key'] }
            if (value) {
                println '-----------------------------------------------'
                println ' ############### ---- ' + value
                value.value = updateTupel['value']
            }
            else {
                Value val = new Value(channel:updateTupel['address'], key:updateTupel['key'], value:updateTupel['value'])
                device.addToValues(val)
            }
            device.save(flush:true, failOnError:true)
        }
    }

}
