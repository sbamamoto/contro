package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

@Transactional
class RemoteControlModelService {

    @Transactional
    def saveRemoteControl(GrailsParameterMap params) {
        RemoteControl remoteControl
        if (params.id) {
            remoteControl = RemoteControl.get(params.id)
        }
        else {
            remoteControl = new RemoteControl()
        }
        println params
        remoteControl.properties = params
        return remoteControl.save(flush: true)
    }

    @Transactional
    def deleteRemoteControl(GrailsParameterMap params) {
        RemoteControl remoteControl
        if (params.id) {
            remoteControl = RemoteControl.get(params.id)
            remoteControl.delete(flush: true)
        }
    }

}