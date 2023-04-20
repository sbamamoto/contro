package contro

class HomematicController {

    def homematicDataModelService
    def deviceModelService
    def scriptExecutorService
    def valueModelService

    def index() {
        def event = request.JSON
        //FIXME: Doppelte Event Skriptstarts unterdrücken, wenn das 
        // Skript das festlegt. Vielleicht eine Eventqueue aufbauen.
        // Starting listener for this specific channel and event.
        homematicDataModelService.updateData(event)
        println("............................. "+event)
        def hmAddress = event['address'].split(':')
        if (event['key'] == 'PRESS_SHORT' || event['key'] == 'MOTION') {
            println("++++ Switch event detected: " + event)
            def rc = RemoteControl.findByIdentity(event['address'])
            if (rc != null) {
                //println ("xxxxxxxxxxxx "+rc.ability.id)
                println("#### "+rc)
                def switchValue = rc.value
                if (event['key'] == 'MOTION') {
                    if (event['value']=='true') {
                        switchValue = '1.0'
                    }
                    else {
                        switchValue = '0.0'
                    }

                }
                redirect(controller: "switchDevice", action:"switchDevice", 
                    params:[
                        ability:rc.ability.id,
                        address:rc.device.device,
                        channel:rc.device.channel,
                        url:rc.device.controller.url,
                        value:switchValue
                    ]);
            } 
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
        //valueModelService.updateValue(event['address'], event['key'], event['value'])
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
