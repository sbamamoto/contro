package contro

class HomematicController {

    def homematicDataModelService
    def scriptExecutorService

    def index() {
        def event = request.JSON
        //println '+++++++++++++   ' + event
        homematicDataModelService.updateData(event)
        def hmAddress = event['address'].split(':')
        def observerList = Processor.findAllByEventKeyAndEventAddress(event['key'], hmAddress[0])
        observerList.each {
            //println 'Executing: ' + it.description
            Map params = [:]
            params.put('address', hmAddress[0])
            params.put('channel', ':'+hmAddress[1])
            params.put('key', event['key'])
            params.put('value', event['value'])
            scriptExecutorService.runScript(it, params)
        }
        //println '------------- ' + observerList
        render(text: 'OK')
     }

}