package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class ProcessorModelService {

    @Transactional
    def saveProcessor(GrailsParameterMap props) {
        Processor swProcessor
        println ('***********************************')
        println (props)
        println ('***********************************')
        if (props.id) {
            swProcessor = Processor.get(props.id)
        }
        else {
            swProcessor = new Processor()
        }

        swProcessor.properties = props
        swProcessor.save(flush:true, failOnError:true)

        return swProcessor
    }

    @Transactional
    Processor delete(String id) {
        Processor p = Processor.get(id)
        p.delete(failOnError:true, flush:true)
    }

    @Transactional
    Processor addInitialData() {
        Processor p = Processor.get(0)
        if (p==null) {
            p = new Processor(id: 0, name: "ArduControl", description: "Arduino Gateway Switching",
                processingScript: "def groovy", type: "SCRIPT")
            p.save(failOnError: true, flush: true)
            p = new Processor(id: 1, name: "WifiControl", description: "Arduino WLAN Switching",
                processingScript: "def groovy", type: "SCRIPT")
            p.save(failOnError: true, flush: true)
            p = new Processor(id: 2, name: "HomematicControl", description: "Homematic Bridge Interface",
                processingScript: "def groovy", type: "SCRIPT")
            p.save(failOnError: true, flush: true)
        }
    }

}
