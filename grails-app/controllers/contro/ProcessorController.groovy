package contro

class ProcessorController {

    def processorModelService;
    def abilityModelService;

     def index(Integer max) {
        redirect(action: 'list', params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [processorInstanceList: Processor.list().sort { it.description }, processorInstanceTotal: Device.count()]
    }

    def saveProcessor = {
        println params
        Processor processor = processorModelService.saveProcessor(params.processorform)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'processor.label', default: 'Processor'), processor.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def execute = {
        GroovyShell shell = new GroovyShell(this.class.classLoader)
        println params
        Processor processor = Processor.get(params.id)
        String script = processor.processingScript
        params.each {k,v -> 
            script = 'def '+ k + '=' + '"' + v + '"' + '\n' +script
        }
        println script
        shell.evaluate(processor.processingScript)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'processor.label', default: 'Processor'), processor.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def create = {
        Processor processorInstance = new Processor()
        processorInstance.properties = params

        render (view:'edit', model: [processorInstance: processorInstance])
    }

    def edit = {
        Processor processorInstance = Processor.get(params.id)
        println processorInstance
        return [processorInstance: processorInstance]
    }

    def delete = {
        processorModelService.delete(params.id)
        redirect action:'list'
    }

    def addInitialData = {
        processorModelService.addInitialData()
        abilityModelService.addInitialData()
        redirect action:'index'
    }

}
