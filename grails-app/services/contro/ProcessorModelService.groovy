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

}
