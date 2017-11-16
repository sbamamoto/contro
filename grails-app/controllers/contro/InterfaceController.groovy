package contro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InterfaceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [interfaceInstanceList: Interface.list().sort { it.description }, interfaceInstanceTotal: Device.count()]
    }
    
    def show(Interface interfaceInstance) {
        respond interfaceInstance
    }

    def create() {
        def interfaceInstance = new Interface()
        interfaceInstance.properties = params
        render (view:"edit", model: [interfaceInstance: interfaceInstance])
    }

    def saveInterface = {
        def interfacex
        if (params.interfacex.id){
            interfacex = Interface.get(params.interfacex.id)
        }
        else {
            interfacex = new Interface()
        }
        
        interfacex.properties = params.interfacex
        interfacex.save(flush:true,failOnError:true)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'interfacex.label', default: 'Interface'), interfacex.description])}"
        flash.textClass="text-success"
        redirect action:"list"
    }  
    
    @Transactional
    def save(Interface interfaceInstance) {
        if (interfaceInstance == null) {
            notFound()
            return
        }

        if (interfaceInstance.hasErrors()) {
            respond interfaceInstance.errors, view:'create'
            return
        }

        interfaceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'interface.label', default: 'Interface'), interfaceInstance.id])
                redirect interfaceInstance
            }
            '*' { respond interfaceInstance, [status: CREATED] }
        }
    }

    def edit(Interface interfaceInstance) {
        respond interfaceInstance
    }

    @Transactional
    def update(Interface interfaceInstance) {
        if (interfaceInstance == null) {
            notFound()
            return
        }

        if (interfaceInstance.hasErrors()) {
            respond interfaceInstance.errors, view:'edit'
            return
        }

        interfaceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Interface.label', default: 'Interface'), interfaceInstance.id])
                redirect interfaceInstance
            }
            '*'{ respond interfaceInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Interface interfaceInstance) {

        if (interfaceInstance == null) {
            notFound()
            return
        }

        interfaceInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Interface.label', default: 'Interface'), interfaceInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'interface.label', default: 'Interface'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
