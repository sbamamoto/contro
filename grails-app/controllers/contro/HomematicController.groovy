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
        //println("............................. "+event)
        def hmAddress = event['address'].split(':')
        if (event['key'] == 'PRESS_SHORT') {
            println("++++++++++++++++++++++ Swicth detected")
            def rc = RemoteControl.findByIdentity(event['address'])
            //println ("xxxxxxxxxxxx "+rc.ability.id)
            redirect(controller: "switchDevice", action:"switchDevice", 
                params:[
                    ability:rc.ability.id,
                    address:rc.device.device,
                    url:rc.device.controller.url,
                    value:rc.value
                ]);
        }
        def lister = Processor.createCriteria()
        def results = lister.list {
            eq('type', 'EVENT') and {
                eq('eventKey', event['key'])
                and {
                    or {
                        eq('eventAddress', event['address']) 
                        eq('eventAddress', '*')
                    }
               }
            }
        }

        results.each{
            println 'Event processor: ' + it.name
        }

        results.each {
            println 'Executing: ' + it.description + ' ' + it.type
            Map params = [:]
            Device dev = Device.findByDevice(hmAddress[0])
            params.put('address', hmAddress[0])
            params.put('channel', ':' + hmAddress[1])
            params.put('key', event['key'])
            params.put('value', event['value'])
            params.put('sessionId', event['sessionId'])
            deviceModelService.setState(dev, scriptExecutorService.runScript(it, params), event['value'])
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
            println ('Not updating device [' + params.Device + ']')
            result = 'NOK'
        }
        render (text: result)
    }

}
