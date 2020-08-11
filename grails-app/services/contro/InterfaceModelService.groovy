package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class InterfaceModelService {

    @Transactional
    def saveInterface(GrailsParameterMap props) {
        Interface swInterface
        println ("***********************************")
        println (props)
        println ("***********************************")
        if (props.id){
            swInterface = Interface.get(props.id)
        }
        else {
            swInterface = new Interface()
        }
        
        swInterface.properties = props
        swInterface.save(flush:true,failOnError:true)
        
        return swInterface
    }
}