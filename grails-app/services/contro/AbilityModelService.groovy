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

}
