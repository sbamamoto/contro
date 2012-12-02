package contro

class TimingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [timingInstanceList: Timing.list(params), timingInstanceTotal: Timing.count()]
    }

    def create = {
        def timingInstance = new Timing()
        timingInstance.properties = params
        return [timingInstance: timingInstance]
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
            return [timingInstance: timingInstance]
        }
    }

    def update = {
        def timingInstance = Timing.get(params.id)
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
            if (!timingInstance.hasErrors() && timingInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'timing.label', default: 'Timing'), timingInstance.id])}"
                redirect(action: "show", id: timingInstance.id)
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
