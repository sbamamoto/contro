package contro

class HomematicController {

    def homematicDataModelService
    def deviceModelService
    def scriptExecutorService
    def valueModelService

    def index() {
        def event = request.JSON

        //FIXME: Doppelte Event Skriptstarts unterdrücken, wenn das Skript das festlegt. Vielleicht eine Eventqueue aufbauen.

        // Starting listener for this specific channel and event.
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
            params.put('sessionId', event['sessionId'])
            scriptExecutorService.runScript(it, params)
        }

        // Update device values
        valueModelService.updateValue(event['address'], event['key'], event['value'])        
        render(text: 'OK')
     }

    def addDevice() {
        Device device = deviceModelService.incomingDevice(params.device)
        def result = 'OK'
        if (device) {
            println ('Device added or updated')
        }
        else {
            println ('#### Devcie update failed.')
            result = 'NOK'
        }
        render (text: result)
    }

}