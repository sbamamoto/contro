package contro

import grails.converters.JSON

class TimingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def timingModelService

    def apilisttimings = {
        println "s#####################################"
        def timings = Timing.list().sort{ it.timing }
        println timings
        [timings:timings]
    }

    def apigetemptytiming = {
        def timing = new Timing()
        [timing:timing]
    }

    def apiupdatetiming = {
        println "-------------------- "+request.JSON
        timingModelService.saveJsonTiming(request.JSON['timing'])
        render "OK"
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [timingInstanceList: Timing.list().sort { it.timing }, timingInstanceTotal: Timing.count()]
    }

    def create = {
        def timingInstance = new Timing()
        timingInstance.properties = params
        def abilities = Ability.list().sort{it.name}
        println "++++++++++ " + abilities
        render (view:"edit", model:[timingInstance: timingInstance,abilities:abilities])
    }

    def save = {
        def timingInstance = new Timing(params)
        if (timingInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'timing.label', default: 'Timing'), timingInstance.id])}"
            redirect(action: "show", id: timingInstance.id)
        }
        else {
            render(view: "create", model: [timingInstance: timingInstance])
        }
    }

    def show = {
        def timingInstance = Timing.get(params.id)
        if (!timingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
            redirect(action: "list")
        }
        else {
            [timingInstance: timingInstance]
        }
    }

    def edit = {
        def timingInstance = Timing.get(params.id)
        if (!timingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
            redirect(action: "list")
        }
        else {
            def c = Device.createCriteria()
                def results = c.list {
                    timings{
                        eq('id', params.long("id"))
                    }
                }
            println "######"+results
            return [timingInstance: timingInstance, devices:results.sort { it.description }, abilities:Ability.list().sort{it.name}]
        }
    }

    def update = {        
        println params
        if (timingModelService.saveTiming(params)) {
            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
            redirect(action: "list", id: params.id)
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def timingInstance = Timing.get(params.id)
        if (timingInstance) {
            try {
                timingModelService.deleteTiming(params)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'timing.label', default: 'Timing'), params.id])}"
            redirect(action: "list")
        }
    }
}
