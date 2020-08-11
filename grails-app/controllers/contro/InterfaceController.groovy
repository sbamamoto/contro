package contro

import static org.springframework.http.HttpStatus.*

class InterfaceController {
    def interfaceModelService;

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

    def saveInterface() {
        println ("aasjkdlajdklajdldjalkajl")
        def interfacex = interfaceModelService.saveInterface(params.interfacex)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'interfacex.label', default: 'Interface'), interfacex.description])}"
        flash.textClass="text-success"
        redirect action:"list"
    }  
    
    def edit = {
        Interface interfaceInstance = Interface.get(params.id)
        println interfaceInstance
        return [interfaceInstance: interfaceInstance]
    }
}
