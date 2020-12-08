package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class AbilityModelService {

    @Transactional
    def saveAbility(GrailsParameterMap props) {
        Ability swAbility
        println ('***********************************')
        println (props)
        println ('***********************************')
        if (props.id) {
            swAbility = Ability.get(props.id)
        }
        else {
            swAbility = new Ability()
        }

        swAbility.properties = props
        swAbility.save(flush:true, failOnError:true)

        return swAbility
    }
     
    @Transactional
    void delete(String id) {
        Ability p = Ability.get(id)
        def dependantDevices = Device.executeQuery(
            'select device from Device device where :ability in elements(device.abilities)',
            [ability: p])
        
        dependantDevices.each {
            it.removeFromAbilities(p)
            it.save(flush:true, failOnError:true)
        }

        def dependantDeviceTypes = DeviceType.executeQuery(
            'select devicetype from DeviceType devicetype where :ability in elements(devicetype.abilities)',
            [ability: p])
        
        dependantDeviceTypes.each {
            it.removeFromAbilities(p)
            it.save(flush:true, failOnError:true)
        }

        def dependantTimings = Timing.findAllByAbility(p)
        
        dependantTimings.each {
            it.ability = null
            it.save(flush:true, failOnError:true)
        }        
        
        p.delete(failOnError:true, flush:true)
    }

    @Transactional
    Ability addInitialData() {
        Ability p = Ability.get(0)
        if (p==null) {
            p = new Ability(id: 0, name: "Switch ArduControl", description: "Arduino Gateway Switch",
                type: "DIRECT", processor: Processor.get(0), readOnly:false)
            p.save(failOnError: true, flush: true)
            p = new Ability(id: 1, name: "WifiControl", description: "Arduino WLAN Switch",
                type: "DIRECT", processor: Processor.get(1), readOnly:false)
            p.save(failOnError: true, flush: true)
            p = new Ability(id: 2, name: "HomematicThermostat", description: "Homematic Bridge Thermostat Control",
                type: "DIRECT", processor: Processor.get(2), readOnly:false)
            p.save(failOnError: true, flush: true)
        }
    }

}
