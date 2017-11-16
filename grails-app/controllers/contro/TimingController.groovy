package contro

class TimingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]

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
        render (view:"edit", model:[timingInstance: timingInstance])
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
            println results
            return [timingInstance: timingInstance, devices:results.sort { it.description }]
        }
    }

    def update = {
        def timingInstance
        if (params.id){
            timingInstance = Timing.get(params.id)
        }
        else {
            timingInstance = new Timing()
        }

        if (timingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (timingInstance.version > version) {
                    
                    timingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'timing.label', default: 'Timing')] as Object[], "Another user has updated this Timing while you were editing")
                    render(view: "edit", model: [timingInstance: timingInstance])
                    return
                }
            }
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
                timingInstance.dimmValue=150
            }
                
            
            if (!timingInstance.hasErrors() && timingInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'timing.label', default: 'Timing'), timingInstance.id])}"
                redirect(action: "list", id: timingInstance.id)
            }
            else {
                render(view: "edit", model: [timingInstance: timingInstance])
            }
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
                timingInstance.delete(flush: true)
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
