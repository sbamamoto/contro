package contro

class HomematicController {

    def homematicDataModelService
    def scriptExecutorService

    def index() {
        def event = request.JSON
        println '+++++++++++++   ' + event
        homematicDataModelService.updateData(event)

        def observerList = Processor.findByEventKey(event['key'])
        observerList.each {
            println 'Executing: ' + it.description
            Map params = [:]
            params.put('channel', event['address'])
            params.put('key', event['key'])
            params.put('value', event['value'])
            scriptExecutorService.runScript(it, params)
        }
        println '------------- ' + observerList
        render(text: 'OK')
     }

}
