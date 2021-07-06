package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class TimingModelService {

    @Transactional
    def saveTiming(GrailsParameterMap params) {
        Timing timingInstance

        if (params.id){
            timingInstance = Timing.get(params.id)
        }
        else {
            timingInstance = new Timing()
        }

        println timingInstance

        if (timingInstance) {
            timingInstance.properties = params
            timingInstance.power = params.containsKey("power")
            timingInstance.monday = params.containsKey("monday")
            timingInstance.tuesday = params.containsKey("tuesday")
            timingInstance.wednesday = params.containsKey("wednesday")
            timingInstance.thursday = params.containsKey("thursday")
            timingInstance.friday = params.containsKey("friday")
            timingInstance.saturday = params.containsKey("saturday")
            timingInstance.sunday = params.containsKey("sunday")
            
            if (timingInstance.dimmValue == null && !timingInstance.power) {
                timingInstance.dimmValue=0
            }
            if (timingInstance.dimmValue == null && timingInstance.power) {
                timingInstance.dimmValue=1
            }
        }  
        return timingInstance.save(failOnError:true, flush:true)
    }

    @Transactional
    def deleteTiming(GrailsParameterMap params) {
        Timing timing
        if (params.id){
            timing = Timing.get(params.id)
            def dependantDevices = Device.executeQuery(
                'select device from Device device where :timing in elements(device.timings)',
                [timing: timing])
        
            dependantDevices.each {
                it.removeFromTimings(timing)
                it.save(flush:true, failOnError:true)
            }
            
            timing.delete(flush: true)
        }
    }
}