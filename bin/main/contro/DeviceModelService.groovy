package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import org.grails.web.json.JSONObject
import grails.orm.HibernateCriteriaBuilder

@Transactional
class DeviceModelService {

    @Transactional
    Device saveDevice(GrailsParameterMap props) {
        Device device
        if (props.id) {
            device = Device.get(props.id)
            device.abilities?.clear()
            device.timings?.clear()
        }
        else {
            println (' +++ Adding device to Contro devices +++' )

            device = new Device()
        }

        device.properties = props
        device.save(flush:true, failOnError:true)

        println device.abilities
        return device
    }

    @Transactional
    Device saveJsonDevice(JSONObject jsonDevice) {
        //println "-------------------------------------------------------------" + jsonDevice
        Device dev = Device.get(jsonDevice.id)

        if (dev == null) {
            dev = new Device();
        }

        println "++++++++++++++++ " + jsonDevice.controller.id
        Interface cnt = Interface.get(jsonDevice.controller.id)
        println "++++++++++++++++ " + cnt

        DeviceType typ = DeviceType.get(jsonDevice.type.id)

        dev.type = typ
        dev.controller = cnt

        dev.hasBatteries = jsonDevice.hasBatteries
        dev.dimm = jsonDevice.dimm
        dev.minDimm = jsonDevice.minDimm
        dev.state = jsonDevice.state
        dev.power = jsonDevice.power
        dev.canDimm = jsonDevice.canDimm
        dev.device = jsonDevice.device
        dev.channel = jsonDevice.channel
        dev.description = jsonDevice.description

        dev.save(flush:true, failOnError:true)
        println " ------------------------ SAVED -----------------------"
    }

    @Transactional 
    Device saveTimedAbilities (Long deviceId, JSONObject jsonTimedAbilities) {
        Device dev = Device.get(deviceId)
        
        // Remove old TimedAbilities
        dev.timedAbilities.clear()
        dev.save(flush:true, failOnError:true)

        for (data in jsonTimedAbilities) {
            for (ta in data ) {
                // read timed abilities of device. That matches the ability requested
                for (timing in ta.value.selected) {
                    Long l = timing.ability.id

                    println "******************************* " +  dev.timedAbilities.size()
                    for (x in dev.timedAbilities) {
                        println ("------ " + x.ability.id + " ---- " + l)
                    }

                    TimedAbility tability = dev.timedAbilities.find{e -> e.ability.id == l}

                    if (tability == null) {
                        println ("No timings for this ability available")

                        TimedAbility nta = new TimedAbility()
                        println "++++++ " + timing.ability.id
                        nta.ability = Ability.get(timing.ability.id)
                        println ("+++++ "+nta.ability)               
                        Timing tim = Timing.get(timing.id)
                        println "+++++++++ tim: "+tim.id
                        nta.addToTimings(tim)

                        println nta

                        nta.save(flush:true, failOnError:true) 
                        dev = Device.get(deviceId)
                        dev.addToTimedAbilities(nta)
                        dev.save(flush:true, failOnError:true)
                        println dev.timedAbilities.timings
                    }
                    else {
                        Timing tim = Timing.get(timing.id)
                        println "+++++++++ tim: "+tim.id
                        tability.addToTimings(tim)
                        tability.save(flush:true, failOnError:true) 
                    }
                }
            }
        }
        return dev
    }

    @Transactional
    Device setState(Long id, String state) {
        Device device = Device.get(id)
        device.state = state
        device.save(flush:true, failOnError:true)
        println "State: "+state+" saved"
        return device
    }

    @Transactional
    Device setState(Device dev, String state, String value) {
        dev.state = state
        if (dev.canDimm) {
            dev.dimm = value
        }
        dev.save(flush:true, failOnError:true)
        return dev
    }

    Device incomingDevice(GrailsParameterMap props) {
        Device device
        if (props.id) {
            device = Device.get(props.id)
            device.abilities?.clear()
            println ('# this [' + props.device + '] - [' + props.description + '] is already known to the system. Updating device data.')
        }
        else {
            println ' ------- DEVICE: ' + props.device
            // check if device with identically controller,address already exists.
            def query = Device.createCriteria()
            def devices = query {
                eq('device', props.device)
            }
            if (devices != null && devices.size() > 0) {
                devices.each {
                    println ('Device with address [' + it.device + '] [' + it.description + '] already in storage updating session id')
                    it.sessionId = props.sessionId
                    it.save(flush:true, failOnError:true)
                }
                return device
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
    void deleteDevice (Device dev) {
        HibernateCriteriaBuilder c = Room.createCriteria()
        List<Room> results = c.list {
            devices {
                eq('id', dev.id)
            }
        }
        results.each {
            it.removeFromDevices(dev)
            it.save(flush:true, failOnError:true)
        }

        c = DeviceGroup.createCriteria()
        List<DeviceGroup> groupResults = c.list {
            devices {
                eq('id', dev.id)
            }
        }
        groupResults.each {
            it.removeFromDevices(dev)
            it.save(flush:true, failOnError:true)
        }

        dev.delete(flush: true)
    }

}
