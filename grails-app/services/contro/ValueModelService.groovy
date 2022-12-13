package contro

import grails.gorm.transactions.Transactional

@Transactional
class ValueModelService {


    @Transactional
    Value updateValue(String key, String channel, String value) {
        Value deviceValue = Value.findByChannelAndKey(channel, key)

        if (!deviceValue) {
            deviceValue = new Value(key:key, channel:channel)
        }
        deviceValue.lastChange = new Date();
        deviceValue.value = value
        deviceValue.save(flush:true, failOnError:true)

        return deviceValue
    }

}
