package contro

class HomematicController {

    def homematicDataModelService
    def deviceModelService
    def scriptExecutorService

    def index() {
        def event = request.JSON

        //FIXME: Doppelte Event Skriptstarts unterdrücken, wenn das Skript das festlegt. Vielleicht eine Eventqueue aufbauen.
        // Starting listener for this specific channel and event.
        homematicDataModelService.updateData(event)
        def hmAddress = event['address'].split(':')
        def observerList = Processor.findAllByEventKeyAndEventAddress(event['key'], event['address'])

        def lister = Processor.createCriteria()
        def results = lister.list {
            eq('eventKey', event['key'])
            and {
                eq('eventAddress', event['address'])
                or {
                    eq('eventAddress', '*')
                }
            }
        }
        results.each{
            println 'Event processor: '+ it.name
        }

        observerList.each {
            if (it.type?.equals('EVENT')) {
                println 'Executing: ' + it.description + ' ' + it.type
                Map params = [:]
                params.put('address', hmAddress[0])
                params.put('channel', ':' + hmAddress[1])
                params.put('key', event['key'])
                params.put('value', event['value'])
                params.put('sessionId', event['sessionId'])
                scriptExecutorService.runScript(it, params)
            }
        }

        // Update device values
        // valueModelService.updateValue(event['address'], event['key'], event['value'])
        render(text: 'OK')
    }

    def addDevice() {
        Device device = deviceModelService.incomingDevice(params.device)
        def result = 'OK'
        if (device) {
            println ('Device added or updated')
        }
        else {
            println ('Not updating device [' + params.Device + ']')
            result = 'NOK'
        }
        render (text: result)
    }

}
