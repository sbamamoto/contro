package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class RemoteModelService {

    @Transactional
    def saveRemote(GrailsParameterMap params) {
        Remote remote
        if (params.id) {
            remote = Remote.get(params.id)
        }
        else {
            remote = new Remote()
        }
        println params
        remote.properties = params
        return remote.save(flush: true)
    }

    @Transactional
    def deleteRemote(GrailsParameterMap params) {
        Remote remote
        if (params.id) {
            remote = Remote.get(params.id)
            remote.delete(flush: true)
        }
    }
}